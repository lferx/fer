trigger CashEntry on c2g__codaCashEntry__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	new TriggerCashEntryHandler().run();
}