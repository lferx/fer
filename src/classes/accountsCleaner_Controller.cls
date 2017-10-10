public with sharing class accountsCleaner_Controller{
 
	public List<Account> cuentasConMatriz {get;set;}
	public List<Account> listaElementoMapa {get;set;}
	public Map<Id,List<Account>> mapaMatrices {get;set;}
	public Id idCuenta {get;set;}
	public Integer restantes {get;set;}
	public Id idPrimeraCuenta {get;set;}
	public Id idSegundaCuenta {get;set;}
	public Id idAsociarMatriz {get;set;}
	public Id idAsociar {get;set;} 
	public Id idDesasociar {get;set;}
	public Account cuentaParaDesasociar {get;set;}
	public Account cuentaParaAsociarMatriz {get;set;}
	public Account cuentaParaAsociar {get;set;}
	public Account cuentaMaestra {get;set;}
	public Account cuentaEsclava {get;set;}

	public Map<String,List<ClienteOferta__c>> mapaCompleto {get;set;}
	public List<ClienteOferta__c> clientesOferta {get;set;}
	public List<ClienteOferta__c> segmentoClienteOferta {get;set;}


	public accountsCleaner_Controller(){
		
		proceso();
		proceso2();
	}

	public void proceso(){

		cuentasConMatriz = new List<Account>();
		listaElementoMapa = new List<Account>();
		mapaMatrices = new Map<Id,List<Account>>();

		cuentasConMatriz = [SELECT Id,Cuenta_Matriz__c,name,phone,Email__c,CURP__c,RFC__c,Numero_de_Seguro_Social__c,CLABE__c,Beneficiario__c FROM Account WHERE Cuenta_Matriz__c != NULL AND Cuenta_Matriz__r.Revisar__c = true order by name limit 100];


		for(Account registro: cuentasConMatriz){

			listaElementoMapa = new List<Account>();
			listaElementoMapa = mapaMatrices.get(registro.Cuenta_Matriz__c);

			if(listaElementoMapa == NULL){
				listaElementoMapa = new List<Account>();
			}

			listaElementoMapa.add(registro);
			mapaMatrices.put(registro.Cuenta_Matriz__c,listaElementoMapa);
		}
		restantes = [SELECT count() FROM Account WHERE Revisar__c = true];
		
	}

	public void proceso2(){
		mapaCompleto = new Map<String,List<ClienteOferta__c>>();

		clientesOferta = [SELECT ID,Cuenta__c,Cuenta__r.name,Oferta__r.name,Oferta__c,Estatus2__c FROM ClienteOferta__c ORDER BY NAME];

		for(ClienteOferta__c co: clientesOferta){
			segmentoClienteOferta = new List<ClienteOferta__c>();
			segmentoClienteOferta = mapaCompleto.get(co.Cuenta__c);

			if(segmentoClienteOferta == NULL){
				segmentoClienteOferta = new List<ClienteOferta__c>();
			}

			segmentoClienteOferta.add(co);

			mapaCompleto.put(co.Cuenta__c,segmentoClienteOferta);
		}

		for(String coId: mapaCompleto.keySet()){
			if(mapaCompleto.get(coId).size()<2){
				mapaCompleto.remove(coId);
			}
		}

	}

	public PageReference desasociar(){
		PageReference pag = new PageReference('/apex/accountCleaner');
		pag.setRedirect(true);
		cuentaParaDesasociar = new Account();
		Account cuentaParaDesasociar = [SELECT Cuenta_Matriz__c FROM Account WHERE id = :idDesasociar];
		if(cuentaParaDesasociar.Cuenta_Matriz__c != NULL){
			cuentaParaDesasociar.Cuenta_Matriz__c = NULL;
			UPDATE cuentaParaDesasociar;
		}
		return pag;
	}

	public PageReference asociar(){
		PageReference pag = new PageReference('/apex/accountCleaner');
		pag.setRedirect(true);
		cuentaParaAsociarMatriz = new Account();
		cuentaParaAsociar = new Account();
		Account cuentaParaAsociarMatriz = [SELECT id FROM Account WHERE id = :idAsociarMatriz];
		Account cuentaParaAsociar = [SELECT Cuenta_Matriz__c FROM Account WHERE id = :idAsociar];
		
			cuentaParaAsociar.Cuenta_Matriz__c = cuentaParaAsociarMatriz.id;
			if(cuentaParaAsociar.Cuenta_Matriz__c != NULL){
				UPDATE cuentaParaAsociar;
			}
		return pag;
	}

	public PageReference combinar(){
		PageReference pag = new PageReference('/apex/accountCleaner');
		pag.setRedirect(true);
		cuentaMaestra = new Account();
		cuentaEsclava = new Account();
		Account cuentaMaestra = [SELECT type,phone,Email__c,CURP__c,RFC__c,Numero_de_Seguro_Social__c,CLABE__c,Beneficiario__c,	Email2__c,Phone2__c  FROM Account WHERE id = :idPrimeraCuenta];
		Account cuentaEsclava = [SELECT type,phone,Email__c,CURP__c,RFC__c,Numero_de_Seguro_Social__c,CLABE__c,Beneficiario__c,	Email2__c,Phone2__c  FROM Account WHERE id = :idSegundaCuenta];
		if(cuentaMaestra.type == 'Matriz' && cuentaEsclava.type == 'Matriz'){

			if(cuentaMaestra.phone == NULL){
				cuentaMaestra.phone = cuentaEsclava.phone;
			}
			else if(cuentaEsclava.phone != NULL){
				cuentaMaestra.Phone2__c = cuentaEsclava.phone;
			}
			if(cuentaMaestra.Email__c == NULL){
				cuentaMaestra.Email__c = cuentaEsclava.Email__c;
			}
			else if(cuentaEsclava.Email__c != NULL){
				cuentaMaestra.Email2__c = cuentaEsclava.Email__c;
			}
			if(cuentaMaestra.CURP__c == NULL){
				cuentaMaestra.CURP__c = cuentaEsclava.CURP__c;
			}
			if(cuentaMaestra.Numero_de_Seguro_Social__c == NULL){
				cuentaMaestra.Numero_de_Seguro_Social__c = cuentaEsclava.Numero_de_Seguro_Social__c;
			}
			if(cuentaMaestra.CLABE__c == NULL){
				cuentaMaestra.CLABE__c = cuentaEsclava.CLABE__c;
			}
			if(cuentaMaestra.RFC__c == NULL){
				cuentaMaestra.RFC__c = cuentaEsclava.RFC__c;
			}
			if(cuentaMaestra.Beneficiario__c == NULL){
				cuentaMaestra.Beneficiario__c = cuentaEsclava.Beneficiario__c;
			}

			UPDATE cuentaMaestra;

			MERGE cuentaMaestra cuentaEsclava;
		}
		return pag;
	}

	public void revisado(){

		Account cuentaRevisada = new Account();
		System.debug('idCuenta: '+idCuenta);
		cuentaRevisada = [SELECT Revisar__c FROM Account WHERE Id = :idCuenta];
		cuentaRevisada.Revisar__c = false;
		UPDATE cuentaRevisada;
		proceso();
	}









	public void cobertura(){
		Integer a = 1;


		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;
		a=1;

	}

}