global class SchedulerRemoverPromotor implements Schedulable	 {
	
	global void execute(SchedulableContext sc) {
		String query =  'SELECT Id,Name,Plaza__c FROM USER WHERE Cambio_de_plaza__c = true';
		Id batchInstanceId = Database.executeBatch(new BatchRemoverPromotor(query),5);
	}
}