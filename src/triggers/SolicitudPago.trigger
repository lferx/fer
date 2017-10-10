trigger SolicitudPago on SolicitudPago__c (after delete, after insert, after undelete, 
							  after update, before delete, before insert, before update) {
	ffirule.IntegrationRuleEngine.triggerHandler();
	new TriggerSolicitudPagoHandler().run();
}