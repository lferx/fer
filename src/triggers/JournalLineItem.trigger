trigger JournalLineItem on c2g__codaJournalLineItem__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	new TriggerJournalLineItemHandler().run();
}