trigger Journal on c2g__codaJournal__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	new TriggerJournalHandler().run();
}