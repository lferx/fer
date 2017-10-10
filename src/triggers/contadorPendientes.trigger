trigger contadorPendientes on Documento__c (after update) {

	Map <Id,Id> docs = new Map <Id,Id>();

	for(Documento__c reg: Trigger.New){
		docs.put (reg.Id,reg.Oferta__r.Gerente_Operativo__c);
	}

}