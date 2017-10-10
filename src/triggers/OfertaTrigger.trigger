trigger OfertaTrigger on Oferta__c (after update) {

	new OfertaTriggerHandler().run();

}