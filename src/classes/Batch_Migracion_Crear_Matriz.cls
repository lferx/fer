global class Batch_Migracion_Crear_Matriz implements Database.Batchable<sObject>, Database.Stateful {
	
	String query;
	RecordType tipoReg2;
	Account nuevaMatriz;
	Map<String,Account> mapaCuentas;
	
	global Batch_Migracion_Crear_Matriz() {
		tipoReg2 = [SELECT Id FROM RecordType where name = 'Matriz' limit 1];
		query = 'SELECT ID, RecordTypeId,type,firstname,lastname,Email__c,Phone,Curp__c,Origen__c,Fecha_de_nacimiento__c,Numero_de_Seguro_Social__c,SubOrigen__c FROM Account WHERE RecordType.name = \'Lead Cliente\' AND Cuenta_Matriz__c = NULL';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {

   		List<Account> asignaMatriz = new List<Account>();
   		Map<String,Account> mapaCuentas = new Map<String,Account>();

		for(SObject cuentaGenerico: scope){
   			Account registro = (Account) cuentaGenerico;
   			nuevaMatriz = new Account();
			nuevaMatriz.RecordTypeId = tipoReg2.id;
			nuevaMatriz.type = 'Matriz';

			nuevaMatriz.name = registro.firstname+' '+registro.lastname;
	
			nuevaMatriz.Email__c = registro.Email__c;
			nuevaMatriz.Phone = registro.Phone;
			nuevaMatriz.Curp__c = registro.Curp__c;
			nuevaMatriz.Origen__c = registro.Origen__c;
			nuevaMatriz.Fecha_de_nacimiento__c = registro.Fecha_de_nacimiento__c;
			nuevaMatriz.Numero_de_Seguro_Social__c = registro.Numero_de_Seguro_Social__c;
			nuevaMatriz.SubOrigen__c = registro.SubOrigen__c;
			
			mapaCuentas.put(registro.id,nuevaMatriz);

	   			
   		}

   		Database.INSERT(mapaCuentas.values(),false);

   		for(SObject cuentaGenerico: scope){
   			Account registro = (Account) cuentaGenerico;

   			registro.Cuenta_Matriz__c = mapaCuentas.get(registro.id).id;
   			registro.type = 'Lead Cliente';
   			asignaMatriz.add(registro);
   		}

   		Database.UPDATE(asignaMatriz,false);
			
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}