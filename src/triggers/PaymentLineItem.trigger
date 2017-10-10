trigger PaymentLineItem on c2g__codaPaymentLineItem__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	new TriggerPaymentLineItemHandler().run();
}