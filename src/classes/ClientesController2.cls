public with sharing class ClientesController2 {
	
	public List<Account> accounts { get; private set; }
	public List<ClienteWrapper> clientesWraps { get; private set; }
	public List<ClienteOferta__c> clienteOfertaDelete { get; private set; }
	public String clienteName { get; set; }
	public String idOferta;
	public String promotorSelected {get;set;}
	private Set<Id> accountIds;
	private Integer countNewAccounts = 0;
	private set<Id> idContactos{get;set;}
	public List<ContactoWrapper> contactos {get; private set;}
	public Contact cliente {get;set;}
	
	 
	public class ClienteWrapper {
		public ClienteOferta__c cliente { get; private set; }
		public String index { get; set; }
		public Boolean isNew;
		
		public ClienteWrapper(ClienteOferta__c cliente, String index, Boolean isNew) {
			this.cliente = cliente;
			this.index = index;
			this.isNew = isNew;
		}
	}
	
	public ClientesController2() {
		clientesWraps = new List<ClienteWrapper>();
		clienteOfertaDelete = new List<ClienteOferta__c>();
		cliente = new Contact();
		idContactos = new set<Id>();
		contactos = new List<ContactoWrapper>();
		contactos.add(new ContactoWrapper(new Contact(), true));
	}
	
	public void setIdOferta(String s){
		if(this.idOferta == null){
			this.idOferta = s;
			setClientesWraps();
		}
	}
	
	public String getIdOferta(){
		return this.idOferta;
	}
	
	private void setClientesWraps() {
		clientesWraps = new List<ClienteWrapper>();
		for(ClienteOferta__c co : [SELECT Id, Cuenta__c, Cuenta__r.Name, Cuenta__r.Contacto__c, Cuenta__r.Contacto__r.Name, Cuenta__r.Id, Contacto__r.id,Cuenta__r.RecordType.Name FROM ClienteOferta__c WHERE Oferta__c =: idOferta]) {
			if(co.Cuenta__r.Contacto__c != null){
				idContactos.add(co.Cuenta__r.Contacto__c);
			}else if(co.Contacto__c != null){
				idContactos.add(co.Contacto__c);
			}
			clientesWraps.add(new ClienteWrapper(co, co.Id, false));
		}
	}
	
	public void addCliente(){
		if(cliente.Id != null){
			ClienteOferta__c newCliente = new ClienteOferta__c();
			newCliente.Oferta__c = idOferta;
			newCliente.Contacto__r = cliente;
			newCliente.Cuenta__r = cliente.Account;
			
			clientesWraps.add(new ClienteWrapper(newCliente, cliente.Id,  false));
		}else{
			//Contacto
			Account newAccount = new Account();
			Contact newContact = new Contact();
			newContact = cliente.clone(true,false);
			newAccount.RecordTypeId = Constants.MAP_RECORDTYPES_DEVNAME.get('Cliente').Id;
			
			//Cluenta
			String nombre = (newContact.FirstName != null)? newContact.FirstName:'';
			String apellido = (newContact.LastName != null)? newContact.LastName:'';
			newAccount.Name = nombre + ' ' + apellido;
			
			//newAccount.Contacto__r = newContact; 
			
			newContact.Account = newAccount;
			
			//Oferta cliente
			ClienteOferta__c newCliente = new ClienteOferta__c();
			newCliente.Oferta__c = idOferta;
			newCliente.Contacto__r = newContact;
			newCliente.Cuenta__r = newAccount;
			
			//System.debug('NEWCLIENTE: ' + newCliente + ', Contacto__r' +  newCliente.Contacto__r);
			clientesWraps.add(new ClienteWrapper(newCliente, 'new'+countNewAccounts, true));
			countNewAccounts++;
		}
		cliente = new Contact();
	}
	
	public void delCliente() {
		String index = ApexPages.currentPage().getParameters().get('delIndex');
		for(Integer i=0; i<clientesWraps.size(); i++) {
			if(clientesWraps[i].index == index) {
				if(!clientesWraps[i].isNew) {
					clienteOfertaDelete.add(clientesWraps[i].cliente);
				}
				clientesWraps.remove(i);
				break;
			}
		}
	}
	
	public String mensajeError {get;set;}
	public void saveContacto(){
		list<ClienteOferta__c> clientesOferta =  new list<ClienteOferta__c>();
		list<Account> newCuentas =  new list<Account>();
		list<Contact> newContacts =  new list<Contact>();
		mensajeError = '';
		try{
			if(clienteOfertaDelete.size() > 0){
				delete clienteOfertaDelete;
			}
			for(ClienteWrapper aw:clientesWraps){
				//System.debug('Aw.cliente.Cuenta__r:' + aw.cliente.Cuenta__r + 'aw.cliente.Contacto__r: ' + aw.cliente.Contacto__r );
				if(aw.isNew){
					newCuentas.add(aw.cliente.Cuenta__r);
					newContacts.add(aw.cliente.Contacto__r);
				}
				clientesOferta.add(aw.cliente);
			}
			if(newCuentas.size() > 0){
				insert newCuentas;
				for(Contact con : newContacts){
					con.AccountId = con.Account.Id;
				}
				insert newContacts;
				for(Account ac : newCuentas){
					ac.Contacto__c = ac.Contacto__r.Id;
				}
				update newCuentas; 
			}
			for(ClienteOferta__c co : clientesOferta){
				co.Cuenta__c = co.Cuenta__r.Id;
				co.Contacto__c = co.Contacto__r.Id;
				co.Cuenta__r.Contacto__c = co.Contacto__r.Id;
				if(co.PromotorOferta__c == null && co.Id == null){
					co.PromotorOferta__c = promotorSelected;
				}
			}
			upsert clientesOferta;
			if(newCuentas != null){
				update newCuentas;
			}
		}catch(Exception e){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
			mensajeError = e.getMessage();
		}
		clientesWraps = new List<ClienteWrapper>();
		this.idOferta = null;
	}
	
	public void cancel(){
	
	}
	
	public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Contact.FieldSets.ClienteOferta.getFields();
    }
    
    public List<SelectOption> getPromotores() {
		List<SelectOption> options = new List<SelectOption>();
   		for(PromotorOferta__c co : [SELECT Id, Cuenta__c, Cuenta__r.Name, Cuenta__r.Contacto__c, Cuenta__r.Contacto__r.Name, Cuenta__r.Id, Contacto__r.id,Contacto__r.Name FROM PromotorOferta__c WHERE Oferta__c =: idOferta]) {
   			options.add(new SelectOption( co.Id,  co.Cuenta__r.Name));
   		}
		return options;
	}

	public void quickSearchCliente() {
		
		String queryFind = '';
		String queryReturn = '';
		String queryWhere = '(Account.Type = \'Cliente\' OR Account.Type = \'Inversionista\') AND ';
		STRING strAccountIds = '';
		
		for(Schema.FieldSetMember f : this.getFields()) {
			String campo = f.getFieldPath();
			String valor = String.valueOf(cliente.get(campo));
			String valorLimpio = cleanFieldsValue(valor);
			if(valorLimpio != null && valorLimpio.length() > 0){
				queryFind += '(*' + String.escapeSingleQuotes(valorLimpio) + '* OR ' + String.escapeSingleQuotes(valorLimpio) + '*) AND ';
				queryReturn += ', ' + campo ;
				if(campo != 'FirstName' && campo != 'LastName'){
					queryWhere += campo + ' like \'%' +valor+ '%\' AND ';
				}else{
					queryWhere += 'Name like \'%' +valor+ '%\' AND ';
				}
				
			}
			
        }
        
        if(!idContactos.isEmpty()) {
				for(Id accountId : idContactos) {
					strAccountIds += '\''+accountId+'\',';
				}
				strAccountIds = strAccountIds.substring(0, strAccountIds.length()-1);
				queryWhere += ' Id NOT IN ('+strAccountIds+')  AND ';
		}
		
		if(queryFind != ''){
			queryFind = queryFind.substring(0, queryFind.length() - 5);
			queryWhere = queryWhere.substring(0, queryWhere.length() - 5);
			String searchquery = 'FIND \'' + queryFind + '\' IN ALL FIELDS RETURNING Contact(Id, Name' + queryReturn + ' WHERE ' + queryWhere + ' ORDER BY Name)';
			system.debug('searchquery: ' + searchquery);
			List<List<SObject>> searchResutls;
			try {
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, queryFind));
				searchResutls = search.query(searchquery);
			} catch(Exception e) {
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
			}
			
			if(searchResutls != null) {
				contactos = new List<ContactoWrapper>();
				contactos.add(new ContactoWrapper(new Contact(), true));
				for(SOBject cliente : searchResutls[0]) {
					contactos.add(new ContactoWrapper((Contact)cliente, false));
				}
			}
		} else {
			contactos = null;
			contactos = new List<ContactoWrapper>();
			contactos.add(new ContactoWrapper(new Contact(), true));
		}
	}
	
	public void selectCliente() {
		String id = ApexPages.currentPage().getParameters().get('selectedCliente');
		if(id != '') {
			cliente = [SELECT Id, Name, FirstName, LastName, Email, Phone, MobilePhone, MailingStreet, MailingCity, Estado__c, MailingPostalCode, Account.Id,Account.Name FROM Contact WHERE Id =:id];
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
	
	public class ContactoWrapper {
		public Contact contacto {get; private set;}
		public Boolean selected {get; set;}
		
		private ContactoWrapper(){}
		
		private ContactoWrapper(Contact contacto, Boolean selected) {
			this.contacto = contacto;
			this.selected = selected;
		}
	}
	
	public static testMethod void testClientesController2() {
		Propiedad__c p = new Propiedad__c();
		p.Name = 'TEST01';
		p.GeneraOferta__c = true;
		insert p;
		
		Oferta__c oferta = [Select Id, Name, Propiedad__c From Oferta__c Where Propiedad__c =: p.Id];
		
		Account a = new Account();
    	a.Name = 'cuenta';
    	a.RecordTypeId = Constants.MAP_RECORDTYPES_DEVNAME.get('Cliente').Id;
    	a.Type = 'Cliente';
    	insert a;
		Contact con = new Contact();
		con.AccountId = a.Id;
		con.FirstName = 'Steve';
		con.LastName = 'Jobs';
		con.Email = 'ctc@ctc.com';
		insert con;
		
		
		Test.startTest();
		ClientesController2 clientes = new ClientesController2();
		clientes.setIdOferta(oferta.Id);
		clientes.getIdOferta();
		clientes.cliente.LastName = 'Jobs';
		clientes.cliente.FirstName = 'Steve';
		clientes.cliente.Email = 'ctc';
		
		Id [] fixedSearchResults= new Id[1];
       	fixedSearchResults[0] = con.Id;
       	Test.setFixedSearchResults(fixedSearchResults);
       
		clientes.quickSearchCliente();
		
		PageReference pageRef = Page.OfertaProceso;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('selectedCliente', con.id);
		
		clientes.selectCliente();
		clientes.addCliente();
		clientes.cliente.LastName = 'Kvothe';
		clientes.addCliente();
		clientes.saveContacto();
		
		clientes.getPromotores();
		clientes.setClientesWraps();
		clientes.quickSearchCliente();
		clientes.cancel();
		
		clientes.delCliente();
		
		Test.stopTest();
		//System.AssertEquals(
		//	database.countquery('SELECT COUNT()'
		//	+' FROM Documento__c Where Oferta__c = \''+oferta.Id+'\''),0
		//);
	}
}