trigger TransactionLineItem on c2g__codaTransactionLineItem__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	new TriggerTransactionLineItemHandler().run();
}