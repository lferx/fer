trigger CashEntryLineItem on c2g__codaCashEntryLineItem__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	new TriggerCashEntryLineItemHandler().run();
}