trigger PayableInvoice on c2g__codaPurchaseInvoice__c (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {
	new TriggerPayableInvoiceHandler().run();
}