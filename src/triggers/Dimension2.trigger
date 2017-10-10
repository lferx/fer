trigger Dimension2 on c2g__codaDimension2__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	new TriggerDimension2Handler().run();
}