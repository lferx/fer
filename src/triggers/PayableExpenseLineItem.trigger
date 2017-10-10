trigger PayableExpenseLineItem on c2g__codaPurchaseInvoiceExpenseLineItem__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	new TriggerPayableExpenseLineItemHandler().run();
}