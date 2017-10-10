global class BatchGenerarMatrices implements Database.Batchable<sObject>, Database.Stateful {
	//Este batch busca cuentas matriz y las liga con su cuenta lead o genera una nueva cuenta matriz y la relaciona si no existe aun
	String query;
	RecordType tipoReg;
	
	global BatchGenerarMatrices() {
		tipoReg = [SELECT Id FROM RecordType where name = 'Matriz' limit 1];
		query = 'SELECT Id,Cuenta_Matriz__c,name,phone,Email__c,CURP__c,RFC__c,Numero_de_Seguro_Social__c,CLABE__c,Beneficiario__c FROM Account WHERE Cuenta_Matriz__c = NULL AND type = \'Lead Cliente\' order by name';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}
 
   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		

   		for(SObject cuentaGenerico: scope){
   			Account registro = (Account) cuentaGenerico;

   			Account cuentaResultado = new Account();
   			
   			try{
   				cuentaResultado = [SELECT id,name FROM Account WHERE ((phone = :registro.phone AND phone != NULL) OR (Email__c = :registro.Email__c AND Email__c != NULL) OR (Curp__c =: registro.Curp__c AND Curp__c != NULL) OR (Numero_de_Seguro_Social__c = :registro.Numero_de_Seguro_Social__c AND Numero_de_Seguro_Social__c != NULL)) AND type = 'Matriz' Limit 1];

   				if(Utilities.accentsRemover(cuentaResultado.name) == Utilities.accentsRemover(registro.name)){
   					registro.Cuenta_Matriz__c = cuentaResultado.id;
   					UPDATE registro;
   				}
   				else{
	   				try{
		   				Account cuentaMatriz = new Account();

		   				cuentaMatriz.RecordTypeId = tipoReg.id;
						cuentaMatriz.type = 'Matriz';
		   				cuentaMatriz.name = registro.name;
						cuentaMatriz.Phone = registro.Phone;
						cuentaMatriz.Curp__c = registro.Curp__c;
						cuentaMatriz.Email2__c = registro.Email__c;
						cuentaMatriz.Numero_de_Seguro_Social__c = registro.Numero_de_Seguro_Social__c;
						cuentaMatriz.RFC__c = registro.RFC__c;
						cuentaMatriz.Beneficiario__c = registro.Beneficiario__c;
						
						INSERT cuentaMatriz;

						registro.Cuenta_Matriz__c = cuentaMatriz.id;
		   				UPDATE registro;
		   			}
		   			catch(exception e){

		   			}

	   			}

   			}
   			catch(exception f){
   				try{
	   				Account cuentaMatriz = new Account();

	   				cuentaMatriz.RecordTypeId = tipoReg.id;
					cuentaMatriz.type = 'Matriz';
	   				cuentaMatriz.name = registro.name;
					cuentaMatriz.Phone = registro.Phone;
					cuentaMatriz.Curp__c = registro.Curp__c;
					cuentaMatriz.Email2__c = registro.Email__c;
					cuentaMatriz.Numero_de_Seguro_Social__c = registro.Numero_de_Seguro_Social__c;
					cuentaMatriz.RFC__c = registro.RFC__c;
					cuentaMatriz.Beneficiario__c = registro.Beneficiario__c;
					
					INSERT cuentaMatriz;

					registro.Cuenta_Matriz__c = cuentaMatriz.id;
	   				UPDATE registro;
	   			}
	   			catch(exception e){

	   			}

   			}

   		}

	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}