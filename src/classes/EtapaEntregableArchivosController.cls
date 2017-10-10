public with sharing class EtapaEntregableArchivosController {
    public list<Attachment> listaArchivos{get;set;}
    
    public Attachment attachment {
        get {
          if (attachment == null)
            attachment = new Attachment();
          return attachment;
        }
            set;
    }
    
    private String parentId;
    private String parentField;
    private String parentId2;
    private String parentField2;
    private String tipo;
    private String idDocumento;
    private String idDesalojo;
    
    // list of new attachments to add
    public List<Attachment> newAttachments {get; set;}
    // the number of new attachments to add to the list when the user clicks 'Add More'
    public static final Integer NUM_ATTACHMENTS_TO_ADD = 1;
    
    
    public EtapaEntregableArchivosController(){
        parentId = ApexPages.currentPage().getParameters().get('parentId');
        parentField = ApexPages.currentPage().getParameters().get('parentField');
        
        parentId2 = ApexPages.currentPage().getParameters().get('parentId2');
        parentField2 = ApexPages.currentPage().getParameters().get('parentField2');
        
        tipo = ApexPages.currentPage().getParameters().get('tipo');
        idDesalojo = ApexPages.currentPage().getParameters().get('idDesalojo');
        Documento__c documento = regresaDocumento();
        newAttachments = new List<Attachment>{ new Attachment(),new Attachment(),new Attachment() ,new Attachment(),new Attachment()};
        listaArchivos = [SELECT id,ParentId,Name,Description FROM Attachment Where ParentId =: documento.id limit 5];
    }
    
    private Documento__c regresaDocumento(){
        String query = 'SELECT id, Name, Oferta__c, DocumentoEtapa__c, DocumentoEtapa__r.Ultimo_Documento__c, DocumentoEtapa__r.Obligatorio__c,EtapaOferta__c, Desalojo__c, Cerrado__c, Iniciado__c, Fecha_Cierre__c, EtapaOferta__r.Etapa__c FROM Documento__c';
        String whereArgs = ' WHERE ';
        String queryLimit = ' LIMIT 1';
        
        if(parentField != null && parentId != null && parentField2 != null && parentId2 != null){
            whereArgs += parentField + '  = \'' + parentId + '\' AND ' + parentField2 + '  = \'' + parentId2 + '\'';
        }
        query += whereArgs + queryLimit;
        system.debug('QUERY ARCHIVOS: ' + query);
        
        List<Documento__c> ldocs = Database.query(query);
        Documento__c doc;
        if(ldocs != null && ldocs.size() > 0){
            doc = ldocs[0];
        }else{
            doc = new Documento__c();
            doc.Tipo__c = tipo;
            doc.put(parentField, parentId);
            doc.put(parentField2, parentId2);
        }
        return doc;
    }
    
    /*public PageReference addArchivo(){
        Documento__c documento = regresaDocumento();
        if(idDesalojo != null && idDesalojo.length() > 0){
            documento.Desalojo__c = idDesalojo;
        }
        try{
            upsert documento;
            attachment.ParentId = documento.id;
            upsert attachment;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
        }
        attachment = new Attachment(); 
        listaArchivos = [SELECT id,ParentId,Name,Description FROM Attachment Where ParentId =: documento.id];
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Se han cargado correctamente los archivos'));
        return null;
    }*/
    
    public PageReference addArchivo(){
        Documento__c documento = regresaDocumento();
        Boolean ret;
        integer iDoc;
        boolean ultdoc = true;
        if(idDesalojo != null && idDesalojo.length() > 0){
            documento.Desalojo__c = idDesalojo;
        }
        List<Attachment> toInsert=new List<Attachment>();
        Boolean nofiles = true;
        for(Attachment newAtt:newAttachments){
		    if (newAtt.Body!=null){
		          nofiles = false;
		          break;
		    }
		}
        
        try{
        	if(nofiles == false)
        	{
        		if (tipo == 'Exp')
        		{
        		   upsert documento;
        		   for(Attachment newAtt:newAttachments){
			            if (newAtt.Body!=null){
			                 newAtt.ParentId = documento.id;
			                 toInsert.add(newAtt);
			            }
			        }
			        upsert toInsert;	
			        ret = true;
        		}else
	        		{
		            if(documento.DocumentoEtapa__r.Ultimo_Documento__c == true)
		            {
		            	iDoc = [SELECT Count() FROM Documento__c WHERE Oferta__c =: documento.Oferta__c AND DocumentoEtapa__r.Obligatorio__c =: true AND Cerrado__c =: false and Iniciado__c =:true];
		                if(iDoc > 1)
		                {
		                	ret = false;
		                	ultdoc = false;
		                }else
		                {
		                	ret = wsUtility.ConcluyePaso(documento);
				            if(ret == true)
				            {
					            for(Attachment newAtt:newAttachments){
					                if (newAtt.Body!=null){
					                    newAtt.ParentId = documento.id;
					                    toInsert.add(newAtt);
					                }
					            }
					            upsert toInsert;
				            }
		                }
		            }else
		            {
			            ret = wsUtility.ConcluyePaso(documento);
			            if(ret == true)
			            {
				            for(Attachment newAtt:newAttachments){
				                if (newAtt.Body!=null){
				                    newAtt.ParentId = documento.id;
				                    toInsert.add(newAtt);
				                }
				            }
				            upsert toInsert;
			            }
		            }
        		}
        	}else
        	{
        		ret = false;
        	}
            
            
               
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
        } finally 
        {
        	newAttachments.clear();
        }
        if (ret == true)
        {
	        for(Attachment doc:newAttachments){
	            doc = new Attachment();
	        }
	        listaArchivos = [SELECT id,ParentId,Name,Description FROM Attachment Where ParentId =: documento.id limit 5];
	        newAttachments = new List<Attachment>{ new Attachment(),new Attachment(),new Attachment() ,new Attachment(),new Attachment()};
	        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Se han cargado correctamente los archivos'));
        }else
        {
        	if (tipo == 'Exp')
        	{
        	   ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'El Archivo no puede cargarse porque existe un problema'));	
        	}else
        	{
	        	if (nofiles == false && ret == false)
	        	   ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'El Archivo no puede cargarse porque existe un problema en el proceso del Documento y la Etapa'));
	        	if (ultdoc == false)
	        	   ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Deben completarse todos los pasos obligatorios antes de concluir la Oferta'));
        	}   
        }
        return null;
    }
    
    public PageReference addMore()
    {
        // append NUM_ATTACHMENTS_TO_ADD to the new attachments list
        for (Integer idx=0; idx<NUM_ATTACHMENTS_TO_ADD; idx++)
        {
            newAttachments.add(new Attachment());
        }
        return null;
    }    
    
    public static testMethod void testCargaDocs() {
        Propiedad__c p = new Propiedad__c();
        p.Name = 'TEST01';
        p.GeneraOferta__c = true;
        insert p;
        
        Oferta__c oferta = [Select Id, Name, Propiedad__c From Oferta__c Where Propiedad__c =: p.Id];
        
        Documento__c doc = new Documento__c();
        doc.Tipo__c = 'TEST';
        doc.Oferta__c = oferta.Id;
        doc.Name = 'IFE';
        insert doc;
        Attachment attach = new Attachment();
        attach.Name = 'Nuevo';
        attach.ParentId = doc.Id;
        attach.Body = Blob.valueOf('body');
        insert attach;
        
        DocumentosPaquete__c setting = new DocumentosPaquete__c();
        setting.Name = 'IFE';
        setting.Activo__c = true;
        setting.Tipo__c = 'TEST';
        insert setting;

        
        Test.startTest();
        PageReference pageRef = Page.etapaEntregableArchivos;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('parentField', 'Oferta__c');
        ApexPages.currentPage().getParameters().put('parentId', oferta.Id);
        
        ApexPages.currentPage().getParameters().put('parentField2', 'Name');
        ApexPages.currentPage().getParameters().put('parentId2', 'Prueba');
        
        
        EtapaEntregableArchivosController carga = new EtapaEntregableArchivosController();
        carga.attachment.Name = 'Archivo prueba';
        carga.attachment.Body = Blob.valueOf('Contenido prueba');
        carga.addArchivo();
        
        Test.stopTest();
    }
}