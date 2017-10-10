global class SchedulerEnvioMailPromotor implements Schedulable {
	
	global void execute(SchedulableContext sc) {
		
		Id devRecordTypeIdCliente = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
		
		String query =  ' SELECT ' 
		               +' Id, '
		               +' Name, '
					   +' Promotor__c, '
					   +' Precalificacion__c, '
					   +' Email__c, '
					   +' Phone, '
					   +' Notificado_al_promotor__c  '
		               +' FROM Account WHERE Notificado_al_promotor__c = false AND RecordTypeId =\''+devRecordTypeIdCliente+'\'';
		              
		Id batchInstanceId = Database.executeBatch(new BatchEnvioMailPromotor(query),5);
	}

}