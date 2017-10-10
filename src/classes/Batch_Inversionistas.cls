global class Batch_Inversionistas implements Database.Batchable<sObject> {
	
	String query;
	Map<String,List<ClienteOferta__c>> mapaCompleto;
	List<ClienteOferta__c> clientesOferta;
	List<ClienteOferta__c> segmentoClienteOferta;
	List<Account> cuentas;
	Map<String,Account> mapaCuentas;
	List<String> paquetesOfertas;
	String conca;
	Integer cont;
	Integer ind;
	List<Account> cuentasActualizar;
	RecordType tipoReg;
	
	global Batch_Inversionistas() {
		query = 'SELECT ID,Cuenta__c,Cuenta__r.name,Oferta__r.name,Oferta__c,Estatus2__c,Oferta__r.Paquete_de_Ofertas__c,Oferta__r.Paquete_de_Ofertas__r.name FROM ClienteOferta__c ORDER BY NAME';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		mapaCompleto = new Map<String,List<ClienteOferta__c>>();
		mapaCuentas = new Map<String,Account>();


		for(SObject cuentaGenerico: scope){
   			ClienteOferta__c co = (ClienteOferta__c) cuentaGenerico;

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
				for(ClienteOferta__c reg: mapaCompleto.get(coId)){
					if(reg.Estatus2__c != 'Cliente final' || reg.Oferta__r.Paquete_de_Ofertas__c == NULL){
						mapaCompleto.remove(coId);
					}
				}
			}
		}

		cuentas = [SELECT id, name, phone, Email__c,type FROM Account WHERE id IN :mapaCompleto.keySet()];

		for(Account reg: cuentas){
			mapaCuentas.put(reg.id,reg);
			if(reg.type != 'Inversionista'){
				reg.RecordTypeId = tipoReg.id;
				cuentasActualizar.add(reg);
			}
		}
		UPDATE cuentasActualizar;
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}