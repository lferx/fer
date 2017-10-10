global class SchedulerVincularOfertasClientes implements Schedulable{
	  
	global void execute(SchedulableContext sc) {
		String query =  'SELECT Id,Name,Plaza__c,Precalificacion__c,Vincular_ofertas__c FROM Account WHERE Vincular_ofertas__c = true';
		Id batchInstanceId = Database.executeBatch(new BatchVincularOfertasClientes(query),5);
	}

}