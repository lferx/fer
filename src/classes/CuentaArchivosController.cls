public class CuentaArchivosController {
    //public List<Attachment> newAttachments {get; set;}
    public Account cuenta {get;set;}
    public String tipoDocumento {get;set;}
    public map<String,Documento__c> mapDocumento {get;set;}
    public map<String,Attachment> mapDocumentoAdjunto {get;set;}
    public list<WrapDocumento> documentosPrincipal {get;set;}
    public map<String,WrapDocumento> mapDocumentoPrincipal {get;set;}
	public list<String> tipoDocumentos = new List<String> { 'IFE', 'Comprobante de domicilio','Estado de cuenta','RFC' ,'Acta constitutiva','Comprobante fiscal'};  
    public String tipoDocumentoGloabal {get;set;}    
    
    public String redirectUrl {get;set;}
    public Boolean bRedirect {get;set;}

    public class WrapDocumento{
        public String tipoDocumento {get;set;}
        public Documento__c documento {get;set;}
        public Attachment adjunto {get;set;}
        public Boolean obligatorio {get;set;}
        //public Attachment adjuntoAnterior {get;set;}
        public list<WrapAttachment> adjuntos {get;set;}
        public WrapDocumento(){
            documento = new Documento__c();
            adjunto =  new Attachment();
            //adjuntoAnterior = new Attachment();
            adjuntos = new list<WrapAttachment>();
            obligatorio = false;
        }
    }
    
    public class WrapAttachment{
        public Boolean selected {get;set;}
        public Attachment attachment {get;set;}
        public WrapAttachment(Attachment attachment){
            this.selected = false;
            this.attachment = attachment;
        }
    }

    public map<String,Boolean> mapDocumentoObligatorio{

        get{
            if(mapDocumentoObligatorio == null){
                   mapDocumentoObligatorio = new map<String,Boolean>(); 
                   if(cuenta.TipoPersona__c == 'Física'){
                        mapDocumentoObligatorio.put('IFE',true);
                        mapDocumentoObligatorio.put('Comprobante de domicilio',true);
                        mapDocumentoObligatorio.put('Estado de cuenta',true);
                        mapDocumentoObligatorio.put('RFC',true);
                   }else if(cuenta.TipoPersona__c == 'Moral'){
                        mapDocumentoObligatorio.put('Acta constitutiva',true);
                        mapDocumentoObligatorio.put('Comprobante fiscal',true);
                   }
            }
            return mapDocumentoObligatorio;
        }
        set;
    }

    public CuentaArchivosController (ApexPages.StandardController stdController){
        bRedirect = false;
        try{
        	if (Test.isRunningTest())
            {
            	cuenta = [SELECT id,Name,TipoPersona__c FROM Account Limit 1];
            }else
            {
        	    cuenta = [SELECT id,Name,TipoPersona__c FROM Account WHERE id =: stdController.getRecord().id];
            }
            redirectUrl = '/' + cuenta.Id;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
        }
        cargaInicio();
    }
    
    public void cargaInicio(){
        //newAttachments = new List<Attachment>{ new Attachment(),new Attachment(),new Attachment()}; 
        list<Documento__c> documentos = new list<Documento__c>();
        documentosPrincipal = new list<WrapDocumento>();
        mapDocumentoPrincipal = new map<String,WrapDocumento>();
        for(String td: tipoDocumentos){
            WrapDocumento wd = new WrapDocumento();
            wd.obligatorio = mapDocumentoObligatorio.get(td);
            wd.tipoDocumento = td;

            Documento__c docPrevio = regresaDocumento(td);
            if(docPrevio != null){
                wd.documento = docPrevio;
            }else{
                wd.documento.cuenta__c = cuenta.Id;
                wd.documento.Name = td;
            }
            
            if(wd.documento.Id != null){
                list<Attachment> adjPrevios = regresaAdjunto(wd.documento.Id);
                if(adjPrevios != null){
                    for(Attachment att : adjPrevios){
                        WrapAttachment wa = new WrapAttachment(att);
                        wd.adjuntos.add(wa);
                    }
                }
            }
            documentosPrincipal.add(wd);
            if(!mapDocumentoPrincipal.containsKey(td)){
                mapDocumentoPrincipal.put(td,wd);
            }
        }
    }
    
    private Documento__c regresaDocumento(String tipo){
        Documento__c documento = null;
        try{
            documento = [SELECT Id,Name,Tipo__c,Gasto__c FROM Documento__c WHERE Name  =: tipo AND Cuenta__c  =: cuenta.Id];
        }catch(Exception e){
           System.debug('ERROR RegresaDocumento: ' + e.getMessage());
        }
        return documento;
    }
    
   private list<Attachment> regresaAdjunto(String idDocumento){
        list<Attachment> adjuntos = null;
        try{
            adjuntos = [SELECT id,ParentId,Name,Description,body FROM Attachment Where ParentId =: idDocumento];
        }catch(Exception e){
           System.debug('ERROR RegresaAdjunto: ' + e.getMessage());
        }
       return adjuntos;
   }
    
    public void addArchivo(){
        List<Attachment> toUpsert = new List<Attachment>();
        for(String sKey:mapDocumentoPrincipal.keySet()){
           Documento__c documento = mapDocumentoPrincipal.get(sKey).documento;
            try{
                upsert documento;
                Attachment newAtt = mapDocumentoPrincipal.get(sKey).adjunto;
                if (newAtt.Body != null){
                    newAtt.ParentId = documento.Id;
                    toUpsert.add(newAtt);
                    if(sKey.equals('IFE')){
                        cuenta.Doc_IFE__c = true;
                    }
                    if(sKey.equals('Estado de cuenta')){
                        cuenta.Doc_EstadoCuenta__c = true;
                    }
                    if(sKey.equals('RFC')){
                        cuenta.Doc_CedulaRFC__c = true;
                    }
                    if(sKey.equals('Comprobante de domicilio')){
                        cuenta.Doc_ComprobanteDomicilio__c = true;
                    }
                }
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
            }
        }
        
        try{
            upsert toUpsert;
            update cuenta;
            cargaInicio();
            bRedirect = true;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Se han cargado correctamente los archivos'));
        }catch(Exception e){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
    }
    
    public void delArchivo(){
        List<Attachment> toDelete = new List<Attachment>();
        for(String sKey:mapDocumentoPrincipal.keySet()){
            for(WrapAttachment wa:mapDocumentoPrincipal.get(sKey).adjuntos){
                if(wa.selected){
                    toDelete.add(wa.attachment);
                }
            }
        }  
        
        try{
            delete toDelete;
            cargaInicio(); 
            for(String sKey:mapDocumentoPrincipal.keySet()){
                if(mapDocumentoPrincipal.get(sKey).adjuntos.size() == 0){
                    if(sKey.equals('IFE')){
                        cuenta.Doc_IFE__c = false;
                    }
                    if(sKey.equals('Estado de cuenta')){
                        cuenta.Doc_EstadoCuenta__c = false;
                    }
                    if(sKey.equals('RFC')){
                        cuenta.Doc_CedulaRFC__c = false;
                    }
                    if(sKey.equals('Comprobante de domicilio')){
                        cuenta.Doc_ComprobanteDomicilio__c = false;
                    }
                }
            }
             update cuenta;
              bRedirect = true;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Se han eliminado correctamente los archivos'));
        }catch(Exception e){
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
    }
}