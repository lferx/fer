global class accountsCleanerBatchNameBenefCLABE implements Database.Batchable<sObject>, Database.Stateful {
	
	String query;
	Map<String,List<Account>> mapaCompleto;
	List<Account> listaMatchs;
	List<Account> listaValores;
	List<Account> listaUpdate;
	Account cuentaMatriz;
	RecordType tipoReg;
	
	global accountsCleanerBatchNameBenefCLABE() {

		query = 'SELECT Fecha_de_nacimiento__c, Cuenta_Matriz__c, name, phone, type, Email__c, NameMail__c, NamePhone__c, NamePhoneMail__c,NameCLABEBeneficiario__c, Numero_de_Seguro_Social__c, RFC__c, CURP__c, Estatus__c, CLABE__c, Beneficiario__c FROM Account WHERE type != \'Matriz\' AND type != \'Lead\' AND Cuenta_Matriz__c = NULL Order by name DESC';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		tipoReg = [SELECT Id FROM RecordType where name = 'Matriz' limit 1];
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		
   		mapaCompleto = new Map<String,List<Account>>();
		

		for(SObject cuentaGenerico: scope){
			Account cuenta = (Account) cuentaGenerico;

			listaMatchs = new List<Account>();
			listaMatchs = mapaCompleto.get(cuenta.NameCLABEBeneficiario__c);

			if(listaMatchs == NULL){
				listaMatchs = new List<Account>();
			}
			listaMatchs.add(cuenta);
			mapaCompleto.put(cuenta.NameCLABEBeneficiario__c,listaMatchs);

		}

		listaValores = new List<Account>();
		for(String llave: mapaCompleto.keySet()){
			listaMatchs = new List<Account>();
			listaMatchs = mapaCompleto.get(llave);
			if(listaMatchs.size()<2 || llave == NULL){
				mapaCompleto.remove(llave);
			}
		}
//		accountsCleanerBatch batchCuentas = new accountsCleanerBatch();
//Database.executeBatch(batchCuentas,100);
		
		
		for(String llave: mapaCompleto.keySet()){
			listaValores = new List<Account>(); 
			cuentaMatriz = new Account();
			cuentaMatriz.RecordTypeId = tipoReg.id;
			cuentaMatriz.type = 'Matriz';
			
			for(Account reg: mapaCompleto.get(llave)){
				if(cuentaMatriz.name == NULL){
					cuentaMatriz.name = reg.name;
				}
				if(cuentaMatriz.phone == NULL){
					cuentaMatriz.phone = reg.phone;
				}
				if(cuentaMatriz.Email__c == NULL){
					cuentaMatriz.Email__c = reg.Email__c;
				}
				if(cuentaMatriz.Fecha_de_nacimiento__c == NULL){
					cuentaMatriz.Fecha_de_nacimiento__c = reg.Fecha_de_nacimiento__c;
				}
				if(cuentaMatriz.Numero_de_Seguro_Social__c == NULL){
					cuentaMatriz.Numero_de_Seguro_Social__c = reg.Numero_de_Seguro_Social__c;
				}
				if(cuentaMatriz.CURP__c == NULL){
					cuentaMatriz.CURP__c = reg.CURP__c;
				}
				if(cuentaMatriz.Beneficiario__c == NULL){
					cuentaMatriz.Beneficiario__c = reg.Beneficiario__c;
				}
				if(cuentaMatriz.CLABE__c == NULL){
					cuentaMatriz.CLABE__c = reg.CLABE__c;
				}
				if(cuentaMatriz.Estatus__c == NULL){
					cuentaMatriz.Estatus__c = reg.Estatus__c;
				}
				else if(reg.Estatus__c == 'Activo'){
					cuentaMatriz.Estatus__c = reg.Estatus__c;
				}
			}
			INSERT cuentaMatriz;

			for(Account reg: mapaCompleto.get(llave)){
				reg.Cuenta_Matriz__c = cuentaMatriz.id;
				listaValores.add(reg); 
			}
			UPDATE listaValores;

		}

	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}