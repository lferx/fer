global class Batch_Correcion_Nombre implements Database.Batchable<sObject> {
	
	String query; 
	List<Account> matrices;
	
	global Batch_Correcion_Nombre() {
		query = 'SELECT CreatedDate,Name,id FROM Account WHERE (CreatedDate > 2017-06-21T18:40:04.000Z AND CreatedDate < 2017-06-21T20:05:02.000Z AND RecordType.name = \'Matriz\') OR (phone = \'1234567853\')';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {

   		matrices = (List<Account>) scope;
   		Map<String,Account> mapaCuentas = new Map<String,Account>();

   		for(Account acc: matrices){
   			mapaCuentas.put(acc.id,acc);
   		}

   		List<Account> leads = new List<Account>();

   		leads = [SELECT firstname,lastname,id,Cuenta_Matriz__c FROM Account WHERE Cuenta_Matriz__c in :mapaCuentas.keyset()];

		for(Account reg: leads){

			mapaCuentas.get(reg.Cuenta_Matriz__c).name = reg.firstname+' '+reg.lastname;
   		}

   		UPDATE mapaCuentas.values();
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}