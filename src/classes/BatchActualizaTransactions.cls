global class BatchActualizaTransactions implements Database.Batchable<sObject> {
	global final Set<String> setTransactionsIds;
	global final String paymentNumber;
	
	global BatchActualizaTransactions(Set<String> setTransactions, String paymentName){
		setTransactionsIds = setTransactions;
		paymentNumber = paymentName;
	}
	
	global Database.querylocator start(Database.BatchableContext BC){
            String query = 'SELECT '+String.join(new List<String>(SObjectType.c2g__codaTransactionLineItem__c.Fields.getMap().keySet()), ', ') +
                				' FROM c2g__codaTransactionLineItem__c '+
                				' WHERE Id IN: setTransactionsIds';
            return Database.getQueryLocator(query);
	}
	
	global void execute(Database.BatchableContext BC, List<c2g__codaTransactionLineItem__c> scope) {
		update scope;
	}
	 
	global void finish(Database.BatchableContext BC) {
		
		for(c2g__codaPayment__c payment : [Select Id From c2g__codaPayment__c Where Name =: paymentNumber]){
			payment.EstatusActualizacionGastos__c = 'Completado';
			update payment; 	
		}
		// Get the ID of the AsyncApexJob representing this batch job
	   // from Database.BatchableContext.
	   // Query the AsyncApexJob object to retrieve the current job's information.
	   AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
	      TotalJobItems, CreatedBy.Email
	      FROM AsyncApexJob WHERE Id =
	      :BC.getJobId()];
	   // Send an email to the Apex job's submitter notifying of job completion.
	   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	   String[] toAddresses = new String[] {a.CreatedBy.Email};
	   mail.setToAddresses(toAddresses);
	   mail.setSubject('Proceso de pago finalizado: Payment ' + paymentNumber);
	   mail.setPlainTextBody
	   ('El proceo de pago finalizo correctamente. Transacciones procesadas: ' + a.TotalJobItems +
	   '. Errores totales: '+ a.NumberOfErrors + ' ');
	   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}

}