global class BatchCargas implements Database.Batchable<sObject> {
	global Database.querylocator start(Database.BatchableContext BC){
            String query = 'SELECT '+String.join(new List<String>(SObjectType.Gasto__c.Fields.getMap().keySet()), ', ') +
                	' FROM Gasto__c '+
                	'WHERE Estatus2__c = null OR (Estatus2__c = \'Nuevo\')';
            return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext BC, List<Gasto__c> scope) {
		update scope;
	}

	global void finish(Database.BatchableContext BC) {
	}

}