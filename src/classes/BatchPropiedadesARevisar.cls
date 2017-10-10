global class BatchPropiedadesARevisar implements Database.Batchable<sObject>, Database.Stateful {
	
	String query;
	List<ID> idsMatrices {get;set;}
	List<Account> cuentasPorRevisar {get;set;}
	List<Account> cuentasConMatriz {get;set;}
	List<Account> listaElementoMapa {get;set;}
	Map<Id,List<Account>> mapaMatrices {get;set;}
	
	global BatchPropiedadesARevisar() {
		idsMatrices = new List<ID>();
		cuentasPorRevisar = new List<Account>();
		cuentasConMatriz = new List<Account>();
		listaElementoMapa = new List<Account>();
		mapaMatrices = new Map<Id,List<Account>>();
		query = 'SELECT Id,Cuenta_Matriz__c,name,phone,Email__c,CURP__c,RFC__c,Numero_de_Seguro_Social__c,CLABE__c,Beneficiario__c FROM Account WHERE Cuenta_Matriz__c != NULL order by name';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		
   		for(SObject cuentaGenerico: scope){
   			Account registro = (Account) cuentaGenerico;

			listaElementoMapa = new List<Account>();
			listaElementoMapa = mapaMatrices.get(registro.Cuenta_Matriz__c);

			if(listaElementoMapa == NULL){
				listaElementoMapa = new List<Account>();
			}

			listaElementoMapa.add(registro);
			mapaMatrices.put(registro.Cuenta_Matriz__c,listaElementoMapa);
		}

		for(Id registro: mapaMatrices.keyset()){

			listaElementoMapa = new List<Account>();
			listaElementoMapa = mapaMatrices.get(registro);

			if(listaElementoMapa.size()<2){
				idsMatrices.add(registro);
				continue;
			}

			Integer coincidencias = 0;
			Account cuentaAnterior = new Account();
			for(Account cuenta: listaElementoMapa){
				if(cuentaAnterior.name != NULL){

					if(Utilities.accentsRemover(cuentaAnterior.name) == Utilities.accentsRemover(cuenta.name)){
						coincidencias++;
					}
					if((cuentaAnterior.phone == cuenta.phone && cuentaAnterior.phone != NULL && cuenta.phone != NULL)||(cuentaAnterior.phone != NULL && cuenta.phone == NULL)||(cuentaAnterior.phone == NULL && cuenta.phone != NULL)){
						coincidencias++;
					}
					if((cuentaAnterior.Email__c == cuenta.Email__c && cuentaAnterior.Email__c != NULL && cuenta.Email__c != NULL)||(cuentaAnterior.Email__c != NULL && cuenta.Email__c == NULL)||(cuentaAnterior.Email__c == NULL && cuenta.Email__c != NULL)){
						coincidencias++;
					}
					if(coincidencias<2){
						idsMatrices.add(registro);
						break;
					}
					coincidencias = 0;
				}

				cuentaAnterior = cuenta;
			}
		}
		System.debug(idsMatrices);

		cuentasPorRevisar = [SELECT Revisar__c FROM Account WHERE Id IN :idsMatrices];
		for(Account cuenta: cuentasPorRevisar){
			cuenta.Revisar__c = true;
		}
		UPDATE cuentasPorRevisar;

	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}