global with sharing class PaqueteOfertaController {
	public List<Oferta__c> ofertas { get; private set; }
	public List<Oferta__c> ofertasAdded { get; private set; }
	public List<Oferta__c> ofertasSincronizar {get; set;}
	
	
	public Paquete__c paquete{get;set;}
	public Etapa__c ultimaEtapa {get;set;}
	public List<Etapa__c> etapas {get;set;}
	
	public String ofertaName { get; set; }
	public String orderBy { get; set; }
	public String sortOrder { get; set; }
	public Integer pageNumber { get; set; }
	public Integer pageSize { get; set; }
	public Integer resultSize { get; private set; }
	public Integer totalPages { get; private set; }
	public Integer pageStart { get; private set; }
	public Integer pageEnd { get; private set; }
	
	public String addOfertaId {get; set;}
	private Set<Id> ofertaIds;
	private List<Oferta__c> ofertasDeletable;
	
	global class Pair {
		public String key { get; private set; }
		public String value { get; private set; }
		
		public Pair(String key, String value) {
			this.key = key;
			this.value = value;
		}
	}
	
	public PaqueteOfertaController(){
		
	}
	
	public PaqueteOfertaController(ApexPages.StandardController controller){
			orderBy = 'Name';
			sortOrder = 'ASC';
			pageNumber = 1;
			pageSize = 10;
			OfertasAdded = new List<Oferta__c>();
			ofertasDeletable =  new List<Oferta__c>();
			ofertasSincronizar = new List<Oferta__c>(); 
			ofertas = new  List<Oferta__c>();
			ofertaIds = new Set<Id>();
			paquete = [SELECT id, Name, Etapa__c FROM Paquete__c WHERE Id =: controller.getId()];
			ultimaEtapa = [SELECT id, Name, Orden__c FROM  Etapa__c WHERE Name =: paquete.Etapa__c];
			etapas = [SELECT Name FROM Etapa__c WHERE Orden__c <=: ultimaEtapa.Orden__c ORDER BY Orden__C ASC];
			setOfertasAdded();
	}
	
	private void setOfertasAdded() {
		ofertaIds = new Set<Id>();
		ofertasAdded = new List<Oferta__c>();
		for(Oferta__c oferta : [SELECT Id,Name,Etapa__c, Direccion__c, Colonia__c,Paquete__c FROM Oferta__c WHERE Paquete__c =: paquete.Id ORDER BY Name]) {
			ofertasAdded.add(oferta);
			ofertaIds.add(oferta.Id);
		}
	}
	
	public void queryOfertas(){
			try {
			String strOfertaIds = '';
			String whereArgs = ' (Paquete__c = null OR Paquete__c = \''+ paquete.Id +'\') AND (Name LIKE \'%' + ofertaName + '%\' OR Colonia__c LIKE  \'%'+ ofertaName + '%\') AND Etapa__c = \'Oferta\'';
			if(!ofertaIds.isEmpty()) {
				for(Id OfertaId : ofertaIds) {
					strOfertaIds += '\''+OfertaId+'\',';
				}
				strOfertaIds = strOfertaIds.substring(0, strOfertaIds.length()-1);
				whereArgs += ' AND Id NOT IN ('+strOfertaIds+') ';
			}
			String queryCount = 'SELECT count() FROM Oferta__c WHERE '+whereArgs;
			System.debug('Query count: ' + queryCount);
			resultSize = Database.countQuery(queryCount);
			totalPages = Math.mod(resultSize,pageSize) > 0 ? resultSize/pageSize+1 : resultSize/pageSize;
			pageNumber = pageNumber > totalPages ? (totalPages == 0 ? 1 : totalPages) : pageNumber;
			pageStart = pageSize*(pageNumber-1)+1;
			pageEnd = pageSize*pageNumber > resultSize ? resultSize : pageSize*pageNumber;
			Integer offset = pageSize*(pageNumber-1);
			String queryPrincipal = Utils.getCreatableFieldsSOQL('Oferta__c', whereArgs, true);
			queryPrincipal = queryPrincipal + ' ORDER BY '+orderBy+' '+sortOrder+' LIMIT '+pageSize+' OFFSET '+offset;
			System.debug('Query: ' + queryPrincipal);
			ofertas = Database.query(queryPrincipal);
		} catch(Exception e) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
		}
	}
	
	@RemoteAction
	global static List<Pair> search(String word) {
		if(word != null) {
			word = '*' + word + '*';
			List<List<SObject>> searchResults = [FIND :word IN ALL FIELDS RETURNING Oferta__c(Id, Name, Colonia__c,Direccion__c)];
			List<Pair> resultsObj = new List<Pair>();
			for(Oferta__c oferta : (List<Oferta__c>)searchResults[0]) {
				resultsObj.add(new Pair(oferta.Id, oferta.Name + ' ' + oferta.Direccion__c + ' ' + oferta.Colonia__c));
			}
			return resultsObj;
		}
		return null;
	}
	
	public void first() {
		pageNumber = 1;
		queryOfertas();
	}
	
	public void previous() {
		if(pageNumber > 1) {
			pageNumber--;
			queryOfertas();
		}
	}
	
	public void next() {
		if(pageNumber < totalPages) {
			pageNumber++;
			queryOfertas();
		}
	}
	
	public void last() {
		pageNumber = totalPages;
		queryOfertas();
	}
	
	public void addOferta(){
		Id ofertaId = ApexPages.currentPage().getParameters().get('addOfertaId');
		List<Oferta__c> ofertasAddedAux = ofertasAdded;
		ofertasAdded = new List<Oferta__c>();
		for(Integer i=0; i<ofertas.size(); i++) {
			if(ofertas[i].Id == ofertaId) {
				ofertasAdded.add(ofertas[i]);
				ofertaIds.add(ofertaId);
				ofertas.remove(i);
				break;
			}
		}
		ofertasAdded.addAll(ofertasAddedAux);
		queryOfertas();
	}
	
	public void delOferta(){
		String ofertaId = ApexPages.currentPage().getParameters().get('delOfertaId');
		for(Integer i=0; i<ofertasAdded.size(); i++) {
			if(ofertasAdded[i].Id == ofertaId) {
				if(ofertasAdded[i].Paquete__c!= null) {
					ofertasDeletable.add(ofertasAdded[i]);
				}
				ofertaIds.remove(ofertasAdded[i].Id);
				ofertasAdded.remove(i);
				break;
			}
		}
		queryOfertas();
	}
	
	public void save(){
		for(Oferta__c oferta : ofertasDeletable) {
			oferta.Paquete__c = null;
		}
		for(Oferta__c oferta : ofertasAdded) {
			oferta.Paquete__c = paquete.Id;
			if(paquete.Etapa__c != oferta.Etapa__c){
				oferta.Etapa__c = paquete.Etapa__c;
				//ofertasSincronizar.add(oferta);
			}
		}
		List<Oferta__c> ofertasDML = new List<Oferta__c>();
		ofertasDML.addAll(ofertasDeletable);
		ofertasDML.addAll(ofertasAdded);
		try{
			upsert ofertasDML;
			//sincroninzarOfertas();
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Los cambios se guardarón exitósamente'));
		}catch(Exception e){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
		}	
	}
	
	public void sincroninzarOfertas(){
		list<EtapaOferta__c> etapasOfertas = new list<EtapaOferta__c>();
		for(Oferta__c oferta: ofertasSincronizar){
			for(Etapa__c etapa:etapas){
				EtapaOferta__c etapaOferta = [SELECT id,Name, FechaCierre__c, Oferta__c, Etapa__r.Name FROM EtapaOferta__c WHERE oferta__c =: oferta.Id AND  Etapa__r.Name =: etapa.Name ];
				etapaOferta.FechaCierre__c = Date.today();
	 			etapaOferta.Estatus__c = 'Cerrada';
	 			etapaOferta.Cerrada__c = true;
	 			etapasOfertas.add(etapaOferta);
	 			oferta.Etapa__c = etapa.Name;
			}
		}
		update etapasOfertas;
	}
	
	public void cancel(){
	
	}
	
	public static testMethod void testPaqueteOfertaController() {
		Etapa__c etapa = new Etapa__c();
		etapa.Activa__c = true;
		etapa.Estatus__c = 'Oferta';
		etapa.EstatusOferta__c = 'Compra';
		etapa.Orden__c = 1;
		etapa.NumEtapa__c = 1;
		etapa.Etapa__c = 'Oferta';
		etapa.Name = 'Oferta';
		insert etapa;
		
		Paquete__c paq = new Paquete__c();
		paq.Name = 'PaqueteUNO';
		insert paq;
		
		Propiedad__c p = new Propiedad__c();
		p.Name = 'TEST01';
		p.GeneraOferta__c = true;
		p.PaqueteOrigen__c = paq.Id;
		insert p;
		
		Oferta__c oferta = [Select Id, Name, Propiedad__c, Paquete__c From Oferta__c Where Propiedad__c =: p.Id];
		
		Propiedad__c p2 = new Propiedad__c();
		p2.Name = 'TEST02';
		p2.GeneraOferta__c = true;
		insert p2;
		 
		Oferta__c oferta2 = [Select Id, Name, Propiedad__c, Paquete__c From Oferta__c Where Propiedad__c =: p2.Id];
		
		Test.startTest();
		PaqueteOfertaController.search('TES');
		ApexPages.StandardController scOferta = new ApexPages.StandardController(paq);
		PaqueteOfertaController con = new  PaqueteOfertaController(scOferta);
		con.ofertaName = 'TEST';
		con.queryOfertas();
		PageReference pageRef = Page.etapaEntregableArchivos;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('addOfertaId', oferta2.Id);
        con.addOferta();
        con.save();
        
        ApexPages.currentPage().getParameters().put('delOfertaId', oferta.Id);
        con.delOferta();
        
        con.first();
        con.last();
        con.previous();
        con.next();
		Test.stopTest();
	}		
}