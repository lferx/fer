trigger PayebleCreditNoteExpLineItem on c2g__codaPurchaseCreditNoteExpLineItem__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	new TriggerPayableCreditNoteLineItemHandler().run();
}