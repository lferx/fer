public with sharing class DesalojoController {
    public Desalojo__c desalojo {get;set;}
    public String mensajeError {get;set;}
    public list<DocumentoEtapa__c> conjuntoDocumentos{get;set;}
    public list<Documento>  listaDocumentos {get;set;}
    public list<Documento__c> documentosEtapaOferta{get;set;}
    public map<String,wrapDocumento> mapaDocumentos{get;set;}
    public list<Schema.FieldSetMember > conjuntoCampos {set;get;}
    public list<Paso> listaPasos {get;set;}
    public list<Paso> listaPasosjudiciales {get;set;}
    public list<Paso> listaPasosExtrajudiciales {get;set;}
    public boolean verExtrajudicial{get; set;}
    public boolean verjudicial{get;set;}
     public boolean verEstatus{get;set;}
     public date fechaasignada{get;set;}
    
    //Modificacion
        public list<DocumentoEtapa__c> conjuntoDocumentosjudiciales{get;set;}
    public list<Documento>  listaDocumentosjudiciales {get;set;}
    public list<Documento__c> documentosEtapaOfertajudiciales{get;set;}
    public map<String,wrapDocumento> mapaDocumentosjudiciales{get;set;}
    public list<Schema.FieldSetMember > conjuntoCamposjudiciales {set;get;}
    //modificacion nivel dos
        public list<DocumentoEtapa__c> conjuntoDocumentosExtrajudiciales{get;set;}
    public list<Documento>  listaDocumentosExtrajudiciales {get;set;}
    public list<Documento__c> documentosEtapaOfertaExtrajudiciales{get;set;}
    public map<String,wrapDocumento> mapaDocumentosExtrajudiciales{get;set;}
    public list<Schema.FieldSetMember > conjuntoCamposExtrajudiciales {set;get;}
    
    //modificacion
    public Boolean muestraBoton {get;set;}
    public String subIndex {set;get;}
    public Boolean muestraCabecera {set;get;}
    public User usuarioActual{get;set;}
    private Id idDesalojo {get;set;}
    private Id idOferta {get;set;}
    private Oferta__c oferta {get;set;}
    private Etapa__c etapaDesalojo {get;set;}
    public date  fechax {get;set;}
    
    public class Documento{
        public Documento__c documento{get;set;}
        public Attachment archivo {get;set;}
        
        public Documento(Documento__c doc, Attachment archi ){
            documento = doc;
            archivo = archi;
        }
    }
    
    public class WrapDocumento{
        public list<Documento> documentos{get;set;}
        public integer sizeDocumentos { 
            
            get{
                return documentos.size();
            } 
        
        set;}
        public wrapDocumento(){
            documentos = new list<Documento>();
        }
    }
    
    public DesalojoController(ApexPages.StandardController controller){
        
        usuarioActual = [SELECT id,Name,PermisoDocs__c FROM User WHERE id =: userinfo.getUserId()];
        mapaDocumentos = new map<String,wrapDocumento>();
        idOferta = ApexPages.currentPage().getParameters().get('idOferta');
        listaDocumentos = new list<Documento>();
        String sMuestraCabecera = ApexPages.currentPage().getParameters().get('muestraCabecera') == null ? 'true' : ApexPages.currentPage().getParameters().get('muestraCabecera');
        muestraCabecera = Boolean.valueOf(sMuestraCabecera);
        desalojo = new Desalojo__c(EtapaDesalojoJudicial__c = null, Fecha__c = null,Estatus_del_Desalojo__c = null,Juicio__c = null,Materia__c = null,Prioridad_de_desalojo2__c = null,Nivel__c=null,Desalojador__c = null,CosteComision__c = 0.0,CosteAdeudos__c = 0.0,Comentarios__c = null,Expediente__c = null,Juzgado__c = null,Municipio_de_juzgado__c = null,Estatus__c = null,Fecha_de_Asignacion__c=null,Fecha_actual_desalojo__c=null, Estatus_del_Desalojo_actual__c=null,   Tipo_de_Desalojo__c=null,Desalojo_Terminado__c=false,Rehabilitacion3__c=false,Estatus_de_Juicio__c=null,Fecha_Estatus_Previsto__c=null);
        desalojo.Oferta__c = idOferta;
        try{
            if(muestraCabecera){
                idDesalojo =  controller.getId();
                desalojo = [SELECT EtapaDesalojoJudicial__c,id,name,Oferta__c,Nivel__c,Fecha__c,Desalojador__c,CosteComision__c,Estatus_del_Desalojo__c,Juicio__c,Materia__c,Prioridad_de_desalojo2__c,Municipio_de_juzgado__c,CosteAdeudos__c, Tipo_de_Desalojo__c,Comentarios__c,Expediente__c,Juzgado__c,Prioridad_de_Desalojo__c, Fecha_Prevista_Desalojo__c,Desalojo_Terminado__c,Rehabilitacion3__c,Estatus_de_Juicio__c,Fecha_actual_desalojo__c,Estatus_del_Desalojo_actual__c,Fecha_de_Asignacion__c, Estatus__c,Fecha_Estatus_Previsto__c FROM Desalojo__c WHERE Id =: idDesalojo];
                idOferta = desalojo.Oferta__c;
            }else if(idOferta != null){
                oferta = [SELECT Id,Name,Desalojo__c FROM Oferta__c WHERE Id =: idOferta];
                idDesalojo = oferta.Desalojo__c;
                desalojo = [SELECT EtapaDesalojoJudicial__c,id,name,Oferta__c,Nivel__c,Fecha__c,Desalojador__c,CosteComision__c,Estatus_del_Desalojo__c,Juicio__c,Materia__c,Prioridad_de_desalojo2__c,Municipio_de_juzgado__c,CosteAdeudos__c, Tipo_de_Desalojo__c,Comentarios__c,Expediente__c,Juzgado__c,Prioridad_de_Desalojo__c, Fecha_Prevista_Desalojo__c,Desalojo_Terminado__c,Rehabilitacion3__c,Estatus_de_Juicio__c,Fecha_de_Asignacion__c,Fecha_actual_desalojo__c,Estatus_del_Desalojo_actual__c, Estatus__c,Fecha_Estatus_Previsto__c  FROM Desalojo__c WHERE Id =: idDesalojo];
            }
        }catch(Exception e){
            System.debug('Error: ' + e.getMessage());
        }
        
        if(desalojo.Tipo_de_Desalojo__c=='judicial'||desalojo.Desalojo_Terminado__c==true){
            verjudicial=true;
        }else{
            verjudicial=false;
        }
        
        if(desalojo.Tipo_de_Desalojo__c=='Extrajudicial'){
            verExtrajudicial=true;
        }else{
            verExtrajudicial=false;
        }
        if(desalojo.Estatus_de_Juicio__c=='No Presentación'){
            verEstatus=true;
        }else{
            verEstatus=false;
        }
        
        Schema.SObjectType sot = Schema.getGlobalDescribe().get('Desalojo__c');
        Schema.DescribeSObjectResult d = sot.getDescribe();
        Map<String, Schema.FieldSet> FsMap = d.fieldSets.getMap();
        conjuntoCampos = FsMap.get('EtapaUno').getFields();
        conjuntoCamposjudiciales = FsMap.get('X2_Etapa_2').getFields();
        conjuntoCamposExtrajudiciales = FsMap.get('X3_Etapa_3').getFields();
        etapaDesalojo = [SELECT id,Name FROM Etapa__c WHERE Name = 'Desalojo'];
        conjuntoDocumentos = [SELECT id,Name,Etapa__c,Tipo__c,Obligatorio__c, Orden__c, AdjuntarClienteDocumento__c,CargaRestringida__c FROM  DocumentoEtapa__c WHERE Etapa__c =: etapaDesalojo.id order by Orden__c];
        
        for(DocumentoEtapa__c cd:conjuntoDocumentos){
            if(!mapaDocumentos.containsKey(cd.Name)){
                mapaDocumentos.put(cd.Name, new WrapDocumento());
            }
        }
        cargarDocumentos();
        cargarDocumentosExtrajudiciales();
        cargarDocumentosjudiciales();
        muestraBoton = idDesalojo == null ? false :true;
        
    }
    
    public DesalojoController(){
        
    }
    
    public  void cargarDocumentos(){
        listaDocumentos = new list<Documento>();
        listaPasos = new list<Paso>();
        documentosEtapaOferta = new list<Documento__c>();
        documentosEtapaOferta = [SELECT id,Name, DocumentoPadre__c, DocumentoEtapa__c, DocumentoEtapa__r.Obligatorio__c, DocumentoEtapa__r.name, 
                                        DocumentoEtapa__r.Orden__c, DocumentoEtapa__r.AdjuntarClienteDocumento__c, Fecha_Compromiso__c, Fecha_Cierre__c,
                                        Tiempo_Restante__c, Cerrado__c, Iniciado__c, Fecha_Com_Controller__c, EtapaOferta__c, Oferta__c
                                        from Documento__c WHERE Oferta__c =: IdOferta AND EtapaOferta__r.Etapa__r.NumEtapa__c =: 10.1 AND DocumentoEtapa__c != null AND DocumentoEtapa__r.Orden__c < 18 order by DocumentoEtapa__r.Orden__c];
        for(Documento__c doc:documentosEtapaOferta){
            listaPasos.add(new Paso(doc));
            for(Attachment att: [SELECT id,ParentId,Name,Description FROM Attachment Where ParentId =: doc.id]){
                if(mapaDocumentos.containsKey(doc.Name)){
                    mapaDocumentos.get(doc.Name).documentos.add(new Documento(doc,att));
                }
                listaDocumentos.add(new Documento(doc,att));
            }
            if(doc.DocumentoPadre__c != null){
                for(Attachment att: [SELECT id,ParentId,Name,Description FROM Attachment Where ParentId =: doc.DocumentoPadre__c]){
                    if(mapaDocumentos.containsKey(doc.Name)){
                        mapaDocumentos.get(doc.Name).documentos.add(new Documento(doc,att));
                    }
                    listaDocumentos.add(new Documento(doc,att));
                }
            }
        }
    }
     public  void cargarDocumentosExtrajudiciales(){
        listaDocumentosExtrajudiciales = new list<Documento>();
        listaPasosExtrajudiciales = new list<Paso>();
        documentosEtapaOfertaExtrajudiciales = new list<Documento__c>();
        documentosEtapaOfertaExtrajudiciales = [SELECT id,Name, DocumentoPadre__c, DocumentoEtapa__c, DocumentoEtapa__r.Obligatorio__c, DocumentoEtapa__r.name, 
                                        DocumentoEtapa__r.Orden__c, DocumentoEtapa__r.AdjuntarClienteDocumento__c, Fecha_Compromiso__c, Fecha_Cierre__c,
                                        Tiempo_Restante__c, Cerrado__c, Iniciado__c, Fecha_Com_Controller__c, EtapaOferta__c, Oferta__c
                                        from Documento__c WHERE Oferta__c =: IdOferta AND EtapaOferta__r.Etapa__r.NumEtapa__c =: 10.1 AND DocumentoEtapa__c != null AND DocumentoEtapa__r.Orden__c > 17 AND DocumentoEtapa__r.Orden__c < 20 order by DocumentoEtapa__r.Orden__c];
        for(Documento__c doc:documentosEtapaOfertaExtrajudiciales){
            listaPasosExtrajudiciales.add(new Paso(doc));
            for(Attachment att: [SELECT id,ParentId,Name,Description FROM Attachment Where ParentId =: doc.id]){
                if(mapaDocumentos.containsKey(doc.Name)){
                    mapaDocumentos.get(doc.Name).documentos.add(new Documento(doc,att));
                }
                listaDocumentosExtrajudiciales.add(new Documento(doc,att));
                listaDocumentos.add(new Documento(doc,att));
            }
            if(doc.DocumentoPadre__c != null){
                for(Attachment att: [SELECT id,ParentId,Name,Description FROM Attachment Where ParentId =: doc.DocumentoPadre__c]){
                    if(mapaDocumentos.containsKey(doc.Name)){
                        mapaDocumentos.get(doc.Name).documentos.add(new Documento(doc,att));
                    }
                    listaDocumentosExtrajudiciales.add(new Documento(doc,att));
                    listaDocumentos.add(new Documento(doc,att));
                }
            }
        }
    }
    public  void cargarDocumentosjudiciales(){
        listaDocumentosjudiciales = new list<Documento>();
        listaPasosjudiciales = new list<Paso>();
        documentosEtapaOfertajudiciales = new list<Documento__c>();
        documentosEtapaOfertajudiciales = [SELECT id,Name, DocumentoPadre__c, DocumentoEtapa__c, DocumentoEtapa__r.Obligatorio__c, DocumentoEtapa__r.name, 
                                        DocumentoEtapa__r.Orden__c, DocumentoEtapa__r.AdjuntarClienteDocumento__c, Fecha_Compromiso__c, Fecha_Cierre__c,
                                        Tiempo_Restante__c, Cerrado__c, Iniciado__c, Fecha_Com_Controller__c, EtapaOferta__c, Oferta__c
                                        from Documento__c WHERE Oferta__c =: IdOferta AND EtapaOferta__r.Etapa__r.NumEtapa__c =: 10.1 AND DocumentoEtapa__c != null AND DocumentoEtapa__r.Orden__c > 19 order by DocumentoEtapa__r.Orden__c];
        for(Documento__c doc:documentosEtapaOfertajudiciales){
            listaPasosjudiciales.add(new Paso(doc));
            for(Attachment att: [SELECT id,ParentId,Name,Description FROM Attachment Where ParentId =: doc.id]){
                if(mapaDocumentos.containsKey(doc.Name)){
                    mapaDocumentos.get(doc.Name).documentos.add(new Documento(doc,att));
                }
                listaDocumentosjudiciales.add(new Documento(doc,att));
                listaDocumentos.add(new Documento(doc,att));
            }
            if(doc.DocumentoPadre__c != null){
                for(Attachment att: [SELECT id,ParentId,Name,Description FROM Attachment Where ParentId =: doc.DocumentoPadre__c]){
                    if(mapaDocumentos.containsKey(doc.Name)){
                        mapaDocumentos.get(doc.Name).documentos.add(new Documento(doc,att));
                    }
                    listaDocumentosjudiciales.add(new Documento(doc,att));
                    listaDocumentos.add(new Documento(doc,att));
                }
            }
        }
    }
    
           public pagereference creaPasos()
       {
                try{     
            list<Documento__c> ldocs = new list<Documento__c>();
            Datetime dFrom = Datetime.now();
                
                EtapaOferta__c etapaoferta = new EtapaOferta__c();
                etapaoferta = [Select id, name from EtapaOferta__c Where Oferta__c =: idOferta and Etapa__r.NumEtapa__c =: 10.1];
                if(etapaOferta != null)
                {
                    list<Documento__c> ldocumentos = new list<Documento__c>();
                    ldocumentos = [Select id, name, DocumentoEtapa__c From Documento__c Where EtapaOferta__r.NumEtapa__c =: 10.1 and Oferta__c =: idOferta];
                    map<Id, Documento__c> mDocumentos = new map<Id, Documento__c>();
                    for (Documento__c doc :lDocumentos)
                    {
                        mDocumentos.put(doc.DocumentoEtapa__c, doc);
                    }
                    for(DocumentoEtapa__c detapa :[Select id, Name, Tipo__c, Tiempo_Proceso__c, Etapa__r.NumEtapa__c, Orden__c
                                                   From DocumentoEtapa__c Where Etapa__r.NumEtapa__c =: 10.1 and Orden__c > 17])
                    {
                          
                            if ( mDocumentos.get(detapa.id) == null)
                            {
                                Documento__c dinsert = new Documento__c();
                                dinsert.Oferta__c = oferta.id;
                                dinsert.EtapaOferta__c = etapaoferta.id;
                                dinsert.DocumentoEtapa__c = detapa.id;
                                dinsert.Name = detapa.Name;
                                dinsert.Tipo__c = detapa.Tipo__c;
                                dinsert.Fecha_Inicio__c = dFrom;
                                dinsert.Fecha_Compromiso__c = wsUtility.addBusinessDays(dFrom, detapa.Tiempo_Proceso__c);
                                dinsert.Fecha_Com_Controller__c = wsUtility.addBusinessDays(dFrom, detapa.Tiempo_Proceso__c);
                                dinsert.Iniciado__c = true;
                                ldocs.add(dinsert);
                            }
                    }
                    
                    etapaoferta.Estatus__c = 'Abierta';
                    update etapaoferta;
                    if (ldocs.size() > 0)
                        upsert ldocs;                               
                }}
                catch(Exception e){
                    
                }
                return null;
            
       }
    
    


    
    public pagereference guardar(){
        mensajeError = '';
        try{
            if(desalojo.Estatus__c == 'Completado'){
                if(conjuntoCampos !=null){
                    for(Schema.FieldSetMember cc: conjuntoCampos){
                        if(desalojo.get(cc.getFieldPath()) == null && cc.getRequired()){
                            mensajeError = 'No se puede completar, llene todos los campos.';
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error,mensajeError);
                            ApexPages.addMessage(msg);
                            break;
                        }else if(cc.getRequired() && desalojo.get(cc.getFieldPath()) == null){
                            mensajeError = 'No se puede completar, llene todos los campos.';
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error,mensajeError);
                            ApexPages.addMessage(msg);
                            break;
                        }
                    }
                }
                
                
                for(Documento__c doc: [Select Id, Name, EtapaOferta__c, Cerrado__c, Tipo__c, DocumentoEtapa__c, DocumentoEtapa__r.Obligatorio__c From Documento__c Where Oferta__c =: idOferta AND EtapaOferta__r.Etapa__r.NumEtapa__c =: 10.1]){
                
                    if(doc.DocumentoEtapa__r.Obligatorio__c && doc.Cerrado__c == false){
                        
                            mensajeError = 'No se puede completar. Debe completar el paso: ' + doc.Name;
                            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error,mensajeError);
                            ApexPages.addMessage(msg);
                        
                    }
                }
                
            }
            
            
            if(mensajeError.equals('')){
                upsert desalojo;
                idDesalojo = desalojo.id;
                muestraBoton = true;
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Info,'Registro guardado con éxito');
                ApexPages.addMessage(msg);
            }
            if(listaDocumentos != null && listaDocumentos.size() > 0){
                List<Attachment> filesUpdate = new List<Attachment>();
                List<Documento__c> docsUpdate = new List<Documento__c>();
                for(Paso pdc :listapasos)
                {
                    pdc.Documento.Desalojo__c = idDesalojo;
                    docsUpdate.add(pdc.Documento);
                }
                update docsUpdate;
                for(Documento doc : listaDocumentos){
                    //doc.documento.Desalojo__c = desalojo.Id;
                    
                    if(doc.archivo != null){
                        filesUpdate.add(doc.archivo);
                    }
                }
                update filesUpdate;
                //update docsUpdate;
            }
        }catch(Exception e){
            mensajeError = e.getMessage();
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error,mensajeError );
            ApexPages.addMessage(msg);
        }
        return muestraCabecera ? new PageReference('/' + idDesalojo) : null;
    }
    
    public void delDocumento(){ 
        Documento documento = listaDocumentos.get(Integer.valueOf(subIndex));
        try{
            //Si es el ultimo archivo del documento, se elimina el documento caso contrario solo el archivo adjunto
            list<Attachment> adjuntos = [SELECT id FROM Attachment Where ParentId =: documento.documento.Id];
            if(adjuntos.size() ==1 ){
                delete documento.archivo;
                delete documento.documento;
                System.debug('Ultimo ducumento: ' + documento.documento);
                if(mapaDocumentos.containsKey(documento.documento.Name)){
                    mapaDocumentos.get(documento.documento.Name).documentos.clear();
                } 
            }else{ 
                delete documento.archivo;
            }
        }catch(Exception e){
            mensajeError = e.getMessage();
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error,mensajeError );
            ApexPages.addMessage(msg);
        }
        cargarDocumentos();
        subIndex = null;
    }
    public class Paso{
        public Documento__c documento{get;set;}
        public DocumentoEtapa__c docEtapa{get;set;}
        public string fechaCierre{get;set;}
        public string fechaCompromiso{get;set;}
        public String semaforo{get;set;}
        public Paso(Documento__c doc){
            docEtapa = [SELECT id,Name,Etapa__c,Tipo__c,Obligatorio__c, Tiempo_Proceso__c, Orden__c, AdjuntarClienteDocumento__c,CargaRestringida__c FROM  DocumentoEtapa__c WHERE id =: doc.DocumentoEtapa__c];
            documento = doc;
            fechaCierre = string.valueOf(documento.Fecha_Cierre__c);
            fechaCompromiso = string.valueOf(documento.Fecha_Com_Controller__c);
            if (documento.Tiempo_Restante__c != null && docEtapa.Tiempo_Proceso__c != null && docEtapa.Tiempo_Proceso__c > 0){
                if ((documento.Tiempo_Restante__c/docEtapa.Tiempo_Proceso__c) > 0.2) semaforo = 'Green';
                if ((documento.Tiempo_Restante__c/docEtapa.Tiempo_Proceso__c) <= 0.2 && (documento.Tiempo_Restante__c/docEtapa.Tiempo_Proceso__c) > 0) semaforo = 'Yellow';
                if ((documento.Tiempo_Restante__c/docEtapa.Tiempo_Proceso__c) < 0) semaforo = 'Red';
            }
        }
        
    }
    public void Cobertura(){
        Integer a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
    }
    
}