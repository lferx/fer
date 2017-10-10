global class Batch_Migracion_Leads implements Database.Batchable<sObject>, Database.Stateful  {
	
	String query;
	RecordType tipoReg;
	List<Account> cuentas;
	
	global Batch_Migracion_Leads() {
		tipoReg = [SELECT Id FROM RecordType where name = 'Lead Cliente' limit 1];
		query = 'SELECT ID, RecordTypeId FROM Account WHERE RecordType.name = \'Lead\' AND Owner.IsActive = true';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {

   		List<Account> cuentas = new List<Account>();

		for(SObject cuentaGenerico: scope){
   			Account registro = (Account) cuentaGenerico;
			registro.RecordTypeId = tipoReg.id;
			System.debug('registro: '+registro);
   			cuentas.add(registro);
   		}

   		Database.UPDATE(cuentas,false); 

	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}