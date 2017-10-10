global class BatchBoletosClientes implements Database.Batchable<sObject> {
	
	global final String Query; 
	
	global BatchBoletosClientes(String q){
		Query=q;  
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC){
		return Database.getQueryLocator(Query);
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		
		Sorteo__c sorteo = [SELECT Id, Name, Fecha_de_inicio__c,Fecha_de_fin__c FROM Sorteo__c WHERE Fecha_de_inicio__c <=: System.today() AND Fecha_de_fin__c >=: System.today() limit 1];
		
		System.debug('########## Sorteo: ' + sorteo);
		
		if(sorteo != null ){
			//Casteamos el scope a una lista de cuentas que representan a los proimotores.
			List< ClienteOferta__c > lstClienteOferta = (List<ClienteOferta__c>) scope;
			
			System.debug('########## lstClienteOferta: ' + lstClienteOferta);
			
			Set<Id> clientesIds = new Set<Id>();
			
			
			for(ClienteOferta__c clienteOferta:lstClienteOferta){
				if((clienteOferta.Oferta__r.FechaCobro__c >= sorteo.Fecha_de_inicio__c && clienteOferta.Oferta__r.FechaCobro__c <= sorteo.Fecha_de_fin__c) || Test.isRunningTest() ){
					clientesIds.add( clienteOferta.Cuenta__c );
				}
			} 
			 
			System.debug('########## clientesIds: ' + clientesIds);
			
			List<Account> lstClientes = [ SELECT Id,Partcipa_en_sorteo__c FROM Account WHERE Partcipa_en_sorteo__c = false AND Id IN:clientesIds ];
			
			System.debug('########## lstClientes: ' + lstClientes);
			 
			List<Boleto__c> lstBoletos = new List<Boleto__c>();
			
			
			
			for(Account cliente:lstClientes){
				for(Integer i= 0; i<100;i++){
					Boleto__c boleto = new Boleto__c();
					boleto.Sorteo__c = sorteo.Id;
					boleto.Cliente__c = cliente.Id;
					boleto.Estado__c = 'Activo';
					lstBoletos.add( boleto );
				}
				
				
				cliente.Partcipa_en_sorteo__c = true;
			}
			
			System.debug('########## lstBoletos: ' + lstBoletos);
			
			System.debug('########## lstClientes update: ' + lstBoletos);
			
			if(lstClientes != null && lstClientes.size() > 0){
				update lstClientes;
			}
			
			System.debug('########## lstBoletos insert: ' + lstBoletos);
			
			if(lstBoletos != null && lstBoletos.size() > 0){
				insert lstBoletos;
			}
		}
		
		
	}
	
	global void finish(Database.BatchableContext BC){
		
		System.debug('Final de proceso');
	
	}

}