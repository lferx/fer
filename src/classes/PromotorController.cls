public with sharing class PromotorController {
	public String idOferta;
	public List<Account> accounts { get; private set; }
	public List<PromotorWrapper> promotoresWrap { get; private set; }
	public List<PromotorOferta__c> promotorOfertaDelete { get; private set; }
	public String clienteName { get; set; }
	public String orderBy { get; set; }
	public String sortOrder { get; set; }
	public Integer pageNumber { get; set; }
	public Integer pageSize { get; set; }
	public Integer resultSize { get; private set; }
	public Integer totalPages { get; private set; }
	public Integer pageStart { get; private set; }
	public Integer pageEnd { get; private set; }
	
	private Set<Id> accountIds;
	private RecordType tipoRegistro;
	private Account cuentaSelected;
	
	
	public class PromotorWrapper {
		public PromotorOferta__c promotor { get; private set; }
		public String index { get; set; }
		public Boolean isNew;
		public String cuentaName{get;set;}
		
		public PromotorWrapper(PromotorOferta__c promotor, String index, Boolean isNew,String cuentaName) {
			this.promotor = promotor;
			this.index = index;
			this.isNew = isNew;
			this.cuentaName = cuentaName;
		}
	}
	
	public String getIdOferta(){
		return this.idOferta;
	}
	
	public void setIdOferta(String s){
		if(this.idOferta == null){
			this.idOferta = s;
			iniciaClientesWraps();
		}
	}
	
	public PromotorController() {
		tipoRegistro = [SELECT id,Name FROM  RecordType WHERE Name =: 'Promotor'];
		orderBy = 'Name';
		sortOrder = 'ASC';
		pageNumber = 1;
		pageSize = 10;
	
		promotorOfertaDelete = new List<PromotorOferta__c>();
		promotoresWrap = new List<PromotorWrapper>();
		accountIds = new Set<Id>();
		queryClientes();
		cliente = new Contact();
	}
	
	private void iniciaClientesWraps() {
		promotoresWrap = new List<PromotorWrapper>();
		for(PromotorOferta__c po : [SELECT Id, Cuenta__c, Cuenta__r.Name, Cuenta__r.Contacto__c, Cuenta__r.Contacto__r.Name, Cuenta__r.Id, Contacto__r.id,Cuenta__r.RecordType.Name FROM PromotorOferta__c WHERE Oferta__c =: idOferta]) {
			promotoresWrap.add(new PromotorWrapper(po, po.Id, false,po.Cuenta__r.Name));
			accountIds.add(po.Cuenta__c);
		}
	}
	
	public void addCliente(){
		Id accountId = ApexPages.currentPage().getParameters().get('addAccountId');
		cuentaSelected = [SELECT id,Name FROM Account WHERE Id =: accountId ];
		for(Integer i=0; i<accounts.size(); i++) {
			if(accounts[i].Id == accountId) {
				PromotorOferta__c po = new PromotorOferta__c();
				po.Oferta__c = idOferta;
				po.Cuenta__c = cuentaSelected.Id;
				po.Contacto__c = accounts[i].Contacto__c;
				promotoresWrap.add(new PromotorWrapper(po, 'new'+ promotoresWrap.size() , true,cuentaSelected.Name));
				accountIds.add(accountId);
				accounts.remove(i);
				break;
			}
		}
	}
	
	public void delCliente() {
		String index = ApexPages.currentPage().getParameters().get('delAccountId');
		for(Integer i=0; i<promotoresWrap.size(); i++) {
			if(promotoresWrap[i].index == index) {
				if(!promotoresWrap[i].isNew) {
					promotorOfertaDelete.add(promotoresWrap[i].promotor);
				}
				accountIds.remove(promotoresWrap[i].promotor.Cuenta__c);
				promotoresWrap.remove(i);
				break;
			}
		}
	}
	public String mensajeError {get;set;}
	public void save(){
		mensajeError = '';
		list<PromotorOferta__c> promotoresOferta =  new list<PromotorOferta__c>();
	    try{
	    	if(promotorOfertaDelete.size() > 0){
				delete promotorOfertaDelete;
			}
			for(PromotorWrapper pw:promotoresWrap){
						promotoresOferta.add(pw.promotor);
			}
			upsert promotoresOferta;
			
	    }catch(Exception e){
	    	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
	    	mensajeError = e.getMessage();
	    }
	    this.idOferta = null; 
	}
	
	public void cancel(){
	
	}
	
	
	public void queryClientes() {
		String whereArgs = '';
		try {
			String strAccountIds = '';
			whereArgs = ' Name LIKE \'%'+clienteName+'%\' AND RecordTypeId = \'' + tipoRegistro.Id +'\' ';
			if(!accountIds.isEmpty()) {
				for(Id accountId : accountIds) {
					strAccountIds += '\''+accountId+'\',';
				}
				strAccountIds = strAccountIds.substring(0, strAccountIds.length()-1);
				whereArgs += ' AND Id NOT IN ('+strAccountIds+') ';
			}
			resultSize = Database.countQuery('SELECT count() FROM Account WHERE '+whereArgs);
			totalPages = Math.mod(resultSize,pageSize) > 0 ? resultSize/pageSize+1 : resultSize/pageSize;
			pageNumber = pageNumber > totalPages ? (totalPages == 0 ? 1 : totalPages) : pageNumber;
			pageStart = pageSize*(pageNumber-1)+1;
			pageEnd = pageSize*pageNumber > resultSize ? resultSize : pageSize*pageNumber;
			Integer offset = pageSize*(pageNumber-1);
			accounts = Database.query('SELECT Id, Name,Contacto__c ,(SELECT Name, AccountId FROM Contacts ORDER BY Name) FROM Account WHERE '+whereArgs+' ORDER BY '+orderBy+' '+sortOrder+' LIMIT '+pageSize+' OFFSET '+offset);
		} catch(Exception e) {
			System.debug('STR: ' + whereArgs);
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
		}
	}
	
	public void first() {
		pageNumber = 1;
		queryClientes();
	}
	
	public void previous() {
		if(pageNumber > 1) {
			pageNumber--;
			queryClientes();
		}
	}
	
	public void next() {
		if(pageNumber < totalPages) {
			pageNumber++;
			queryClientes();
		}
	}
	
	public void last() {
		pageNumber = totalPages;
		queryClientes();
	}
	
	
	//public List<ClienteWrapper> clientes {get; private set;}
	public Contact cliente {get;set;}
	
	
	public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Contact.FieldSets.ClienteOferta.getFields();
    }
	
	public void selectCliente() {
		String id = ApexPages.currentPage().getParameters().get('selectedCliente');
		if(id != '') {
			cliente = [SELECT Id, Name, FirstName, LastName, Email, Phone, MobilePhone, MailingStreet, MailingCity, Estado__c, MailingPostalCode FROM Contact WHERE Id =:id];
		} else {
			cliente = new Contact();
		}
	}
	
	public String cleanFieldsValue(String field){
		if(field != null && field.length() > 2) {
			field.replaceAll(' [aA][nN][dD] ', ' ');
			field.replaceAll(' [oO][rR] ', ' ');
			return field;
		}
		return null;
	}
	
	public static testMethod void testPromotorController() {
		Propiedad__c p = new Propiedad__c();
		p.Name = 'TEST01';
		p.GeneraOferta__c = true;
		insert p;
		
		Oferta__c oferta = [Select Id, Name, Propiedad__c From Oferta__c Where Propiedad__c =: p.Id];
		
		Account a = new Account();
    	a.Name = 'Steve Jobs';
    	a.RecordTypeId = Constants.MAP_RECORDTYPES_DEVNAME.get('Promotor').Id;
    	a.Type = 'Promotor';
    	insert a;
		Contact con = new Contact();
		con.AccountId = a.Id;
		con.FirstName = 'Steve';
		con.LastName = 'Jobs';
		con.Email = 'ctc@ctc.com';
		insert con;
		
		
		Test.startTest();
		//Busca un primer promotor en la base de datos
		PromotorController promos = new PromotorController();
		promos.setIdOferta(oferta.Id);
		promos.getIdOferta();
		promos.clienteName = 'Steve';
		promos.queryClientes();
		
		//Agrega un promotor de la base de datos
		PageReference pageRef = Page.OfertaProceso;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('selectedCliente', con.id);
		promos.selectCliente();
		ApexPages.currentPage().getParameters().put('addAccountId',a.Id);
		promos.addCliente();
		promos.save();
		
		//Reinicia y busca el promotor existente eb la oferta
		promos = new PromotorController();
		promos.idOferta = null;
		promos.setIdOferta(oferta.Id);
		promos.queryClientes();
		
		//Borra el promotor existente
		ApexPages.currentPage().getParameters().put('delAccountId',promos.promotoresWrap[0].index);
		promos.delCliente();
		promos.cancel();
		promos.first();
		promos.next();
		promos.last();
		promos.previous();
		promos.save();
		
		Test.stopTest();
		//System.AssertEquals(
		//	database.countquery('SELECT COUNT()'
		//	+' FROM Documento__c Where Oferta__c = \''+oferta.Id+'\''),0
		//);
	}
}