public with sharing class GastosArchivosController{
    public list<Attachment> listaArchivos{get;set;}
    public list<WrapAttachment> listaWrapArchivos{get;set;}
    public List<Attachment> newAttachments {get; set;}
    public String subIndex {get;set;}
    public boolean permiteAdjuntar {get;set;}
    public User usuario {get;set;}
    
    public class WrapAttachment {
        public Boolean selected {get;set;}
        public Attachment attachment {get;set;}
        public WrapAttachment(Attachment attachment){
            this.selected = false;
            this.attachment = attachment;
        }
    }
    
    public Attachment attachment {
        get {
          if (attachment == null)
            attachment = new Attachment();
          return attachment;
        }
            set;
    }
    public String gastoId {get;set;}
    public String solicitudId {get;set;}
    public String tipo {get;set;}
    private Documento__c documento {get;set;}
    
    public GastosArchivosController(){
        gastoId = null;
        solicitudId = null;
        permiteAdjuntar = true;
        gastoId = ApexPages.currentPage().getParameters().get('gastoId');
        solicitudId = ApexPages.currentPage().getParameters().get('solicitudId');
        tipo = ApexPages.currentPage().getParameters().get('tipo');
        documento = regresaDocumento();
        if(tipo.equals('Comprobante pago')){
        	usuario = [SELECT id,Name, CargaTransferencias__c  FROM User WHERE id =: UserInfo.getUserId()];
            if(usuario.CargaTransferencias__c == false){
                permiteAdjuntar = false;
            }
    	}
        loadInit();
    }
    private void loadInit(){
        newAttachments = new List<Attachment>{ new Attachment(),new Attachment(),new Attachment() ,new Attachment(),new Attachment()};
        listaArchivos = [SELECT id,ParentId,Name,Description FROM Attachment Where ParentId =: documento.Id];
        listaWrapArchivos = new list<WrapAttachment>();
        for(Attachment att : listaArchivos){
            listaWrapArchivos.add(new WrapAttachment(att));
        }
    }
    private Documento__c regresaDocumento(){
        Documento__c doc = null;
        try{
            if(gastoId != null){
              doc = [SELECT Id,Name,Tipo__c,Gasto__c FROM Documento__c WHERE TipoGasto__c =: tipo AND Gasto__c =: gastoId];
            }else{
              doc = [SELECT Id,Name,Tipo__c,Gasto__c FROM Documento__c WHERE TipoGasto__c =: tipo AND SolicitudPago__c =: solicitudId];  
            }
        }catch(Exception e){
        	//ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
        	System.debug('ERROR RegresaDocumento: ' + e.getMessage());
        }finally{
            if(doc == null){
                 doc = new Documento__c();
                 doc.TipoGasto__c = tipo;
               	 if(gastoId != null){
                 	doc.Gasto__c = gastoId;
                 }else{
                 	doc.SolicitudPago__c = solicitudId;
                 } 
                 doc.Name = tipo;
                 //upsert doc;
             }
        }
        return doc;
    }
    
    public PageReference addArchivo(){   
        List<Attachment> toInsert = new List<Attachment>();
        try{
            upsert documento;
            for(Attachment newAtt:newAttachments){
                if (newAtt.Body!=null){
                    newAtt.ParentId = documento.Id;
                    toInsert.add(newAtt);
                }
            }
            upsert toInsert;
            loadInit();
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Se han cargado correctamente los archivos'));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            loadInit();
        }
        return null;
    }
    
    public PageReference delArchivo(){
        list<Attachment> attDelete = new list<Attachment>();
        try{
           for(WrapAttachment wa: listaWrapArchivos){
               if(wa.selected){
                   attDelete.add(wa.attachment);
               }
           }
           delete attDelete;    
           loadInit();  
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Se han borrado correctamente los archivos'));
        }catch(Exception e){
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
        }
        return null;
    }
}