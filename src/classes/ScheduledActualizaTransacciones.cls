global class ScheduledActualizaTransacciones implements Schedulable {

	global final Set<String> setTransactionsIds;
	global final String paymentNumber;
	
	global ScheduledActualizaTransacciones(Set<String> setTransactions, String paymentName){
		setTransactionsIds = setTransactions;
		paymentNumber = paymentName;
		
	}
	
	global void execute(SchedulableContext sc) {
      	BatchActualizaTransactions batch1 = new BatchActualizaTransactions(setTransactionsIds,paymentNumber);
		Database.executeBatch(batch1,5);
		
		try {
			CronTrigger ct = [SELECT id,CronExpression,TimesTriggered, NextFireTime 
			       	       FROM CronTrigger WHERE id = :sc.getTriggerId()];
			if (ct != null){
				System.abortJob(ct.Id);
			}
		} catch (Exception e) {
			System.debug('There are no jobs currently scheduled.'); 
		}
	}   
}