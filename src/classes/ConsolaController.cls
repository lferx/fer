public with sharing class ConsolaController {
	public list<Etapa__c> etapas{get;set;}
	public list<EtapaOferta__c> etapasOferta{get;set;}
	public transient ApexPages.Component componenteGeneral{get;set;}
	public String idEtapaOferta {get;set;}
	public string idOferta {get;set;}
	
	public String orderBy { get; set; }
	public String sortOrder { get; set; }
	public Integer pageNumber { get; set; }
	public Integer pageSize { get; set; }
	public Integer resultSize { get; private set; }
	public Integer totalPages { get; private set; }
	public Integer pageStart { get; private set; }
	public Integer pageEnd { get; private set; } 
	
	
	public Map<String, List<DocumentoEtapa__c>> mapDocumentos{
		get{
			if(mapDocumentos == null){
				mapDocumentos = new Map<String, List<DocumentoEtapa__c>>();
				for(Etapa__c etapa : [Select Id, Name, (Select Id, Name, NombreUsuario__c From Documentos_Etapa__r Where Activo__c = true order by Orden__c) From Etapa__c Where Activa__c = true]){
					if(!mapDocumentos.containsKey(etapa.Id)){
						mapDocumentos.put(etapa.Id, new List<DocumentoEtapa__c>());
					}
					mapDocumentos.get(etapa.Id).addAll(etapa.Documentos_Etapa__r);
				}
			}
			return mapDocumentos;
		}set;
	}
	
	
	public ConsolaController(){
		
	}
	
	public void cargaEtapasOferta(){
		orderBy = 'Estatus__c DESC, Etapa__r.OrdenOperadores__c ASC, CreatedDate ASC';
		sortOrder = 'ASC';
		
		if(ApexPages.currentPage().getParameters().get('pageNumber') != null){
			pageNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('pageNumber'));
		}else{
			pageNumber = 1;
		}
		
		if(ApexPages.currentPage().getParameters().get('pageSize') != null){
			pageSize = Integer.valueOf(ApexPages.currentPage().getParameters().get('pageSize'));
		}else{
			pageSize = 25;
		}
		queryPrincipal();
	}
	
	public Map<String, List<DocumentoWrapper>> mapDocumentosEtapa {get;set;}
	
	/*Paginación-Inicio*/
	public void queryPrincipal(){
		try {
			String whereArgs = 'Estatus__c = \'Abierta\' ';
			if(Userinfo.getProfileId() != '00ei0000000ex8BAAQ' && Userinfo.getProfileId() != '00ei0000000r3DhAAI'){
				whereArgs += 'AND Oferta__r.OwnerId = \'' +Userinfo.getUserId()+ '\' '; 
			}
			resultSize = Database.countQuery('select count() from EtapaOferta__c WHERE '+ whereArgs);
			totalPages = Math.mod(resultSize,pageSize) > 0 ? resultSize/pageSize+1 : resultSize/pageSize;
			pageNumber = pageNumber > totalPages ? (totalPages == 0 ? 1 : totalPages) : pageNumber;
			pageStart = pageSize*(pageNumber-1)+1;
			pageEnd = pageSize*pageNumber > resultSize ? resultSize : pageSize*pageNumber;
			Integer offset = pageSize*(pageNumber-1);
			etapasOferta = Database.query('Select id, Oferta__r.Owner.FirstName, Oferta__r.Owner.LastName, Oferta__c, Oferta__r.Name, Name, Etapa__c, Avance__c, Etapa__r.Name, Etapa__r.Descripcion__c, EstatusTiempo__c, EstatusFinal__c, Etapa__r.Descripcion2__c From EtapaOferta__c WHERE ' + whereArgs  +' ORDER BY '+orderBy +' LIMIT '+pageSize+' OFFSET '+offset);
			generaWrapperDocumentos();
		}catch(Exception e){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
		}
		
	}
	
	private void generaWrapperDocumentos(){
		mapDocumentosEtapa = new Map<String, List<DocumentoWrapper>>();
		for(EtapaOferta__c etapa : etapasOferta){
			if(!mapDocumentosEtapa.containsKey(etapa.Id)){
				mapDocumentosEtapa.put(etapa.Id, new List<DocumentoWrapper>());
			}
			if(mapDocumentos.containsKey(etapa.Etapa__c)){
				for(DocumentoEtapa__c doc: mapDocumentos.get(etapa.Etapa__c)){
					DocumentoWrapper dw = new DocumentoWrapper(doc, null);
					mapDocumentosEtapa.get(etapa.Id).add(dw);
				}
			}
			
		}
		for(Documento__c doc: [Select Id, DocumentoEtapa__c, EtapaOferta__c, NumFiles__c From Documento__c Where EtapaOferta__c IN: etapasOferta AND DocumentoEtapa__r.Activo__c = true order by EtapaOferta__c,DocumentoEtapa__r.Orden__c asc]){
			for(DocumentoWrapper dw : mapDocumentosEtapa.get(doc.EtapaOferta__c)){
				if(doc.DocumentoEtapa__c == dw.documentoEtapa.Id){
					dw.documento = doc;
					break;
				}
			}
		}
	}
	
	public void first() {
		pageNumber = 1;
		queryPrincipal();
	}
	
	public void previous() {
		if(pageNumber > 1) {
			pageNumber--;
			queryPrincipal();
		}
	}
	
	public void next() {
		if(pageNumber < totalPages) {
			pageNumber++;
			queryPrincipal();
		}
	}
	
	public void last() {
		pageNumber = totalPages;
		queryPrincipal();
	}
	
	/*Paginación-Termina*/
	public PageReference recargarDos(){
		queryPrincipal();
		//return new PageReference('/apex/ConsolaPropiedades?pageSize=' + pageSize +  '&pageNumber=' + pageNumber);
		return null;
	}
	
	public class DocumentoWrapper{
		public DocumentoEtapa__c documentoEtapa {get;set;}
		public Documento__c documento {get;set;}
		
		public DocumentoWrapper(DocumentoEtapa__c documentoEtapa, Documento__c documento){
			this.documentoEtapa = documentoEtapa;
			this.documento = documento;
		}
	}
	
	public void crearComponente(){
		componenteGeneral = new Component.c.etapaEntregable(propiedadVal = idOferta, etapaVal = idEtapaOferta,zetapa = 'Detalles2');
	}
	
	//@isTest(SeeAllData=true)
	public static void testConsolaController() {
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
		
		Test.startTest();
		
		ConsolaController consola = new ConsolaController();
		consola.cargaEtapasOferta();
		consola.next();
		consola.first();
		consola.last();
		consola.previous();
		consola.recargarDos();
		Test.stopTest();
		//System.AssertEquals(
		//	database.countquery('SELECT COUNT()'
		//	+' FROM Documento__c Where Oferta__c = \''+oferta.Id+'\''),0
		//);
	}
}