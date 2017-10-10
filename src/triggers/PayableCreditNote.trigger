trigger PayableCreditNote on c2g__codaPurchaseCreditNote__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	new TriggerPayableCreditNoteHandler().run();
}