global class  BatchRemoverPromotor implements Database.Batchable<sObject> {
	
	global final String Query;
	
	global BatchRemoverPromotor(String q){
		Query=q;
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC){
		return Database.getQueryLocator(Query);
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		
		Profile perfilGerenteVentas = [SELECT Id FROM Profile WHERE Name = 'Gerente de Ventas' LIMIT 1];
		
		Id devRecordTypeIdCliente = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
		
		String plazas = '';
		
		//Casteamos el scope a una lista de cuentas que representan a los proimotores.
		List<User> lstGerente = (List<User>) scope;
		
		//El siguiente conjunto contendra los Ids de los promotores que evaluaremos.
		Set<Id> setGerentesIds = new Set<Id>();
		
		//El siguiente conjunto contendra los Ids de los promotores que evaluaremos.
		Set<String> setPlazas = new Set<String>();
		
		//recorremos el scope
		for(User gerente: lstGerente ){
			setGerentesIds.add( gerente.Id  );
			gerente.Cambio_de_plaza__c = false;
		}
		List<Account> lstClientes = [SELECT Id, Name, Plaza__c FROM Account WHERE RecordTypeId =: devRecordTypeIdCliente AND OwnerId IN:setGerentesIds ];
		
		for( Account cliente:lstClientes ){
			setPlazas.add( cliente.Plaza__c );	
			
			if(String.isEmpty(plazas)){
				plazas = cliente.Plaza__c+'\'';
			}else{
				if(!( plazas.indexOf(cliente.Plaza__c) >= 0 )){
					plazas += ',\''+cliente.Plaza__c + '\'';
				}
			}
					
		}
		
		plazas = plazas.removeEnd('\'');
		
		List<User> lstGerentesNuevos = (List<User>)Database.query('SELECT Id,Plaza__c FROM User WHERE ProfileId = \''+perfilGerenteVentas.Id+'\' AND Plaza__c INCLUDES(\''+plazas+'\') AND User.IsActive = true');
		
		//Recorremos las cuentas que ya habiamos creado para asignar los gerentes
		for( Account cliente:lstClientes  ){
			for(User userGerente:lstGerentesNuevos){
				String plazaGerente = userGerente.Plaza__c;
				if( plazaGerente.indexOf( cliente.Plaza__c ) >= 0 ){
					cliente.OwnerId = userGerente.Id;
				}
			}
		}
		
		if(lstClientes != null && lstClientes.size() >0){
			update lstClientes;
		}
		
		if(lstGerente != null && lstGerente.size() >0){
			update lstGerente;
		}
		
		
		
	}
	
	global void finish(Database.BatchableContext BC){
	
	}

}