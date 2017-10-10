global class SchedulerBoletosClientes implements Schedulable{
	
	global void execute(SchedulableContext sc) {
		
		String query =  'SELECT Id,Cuenta__c,Oferta__r.FechaCobro__c FROM ClienteOferta__c WHERE Oferta__r.FechaCobro__c != null AND Estatus2__c = \'Cliente final\' AND Oferta__r.TipoOferta__c = \'Infonavit\' AND Oferta__r.Estatus__c = \'Cobrada\'';
		Id batchInstanceId = Database.executeBatch(new BatchBoletosClientes(query),5);
	}

}