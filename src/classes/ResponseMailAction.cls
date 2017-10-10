global with sharing class ResponseMailAction { 
	
	@RemoteAction
	global static void actualizarLead(String leadId) { 
		//Mediante este query ontenemos el registro de candidato interesado
		Candidato_Interesado__c canin = [SELECT Id, Interesado__c FROM Candidato_Interesado__c WHERE Lead__c =: leadId LIMIT 1];
		
		if(canin != null){
			canin.Interesado__c = true; 
			update canin;	
		}
	}
}