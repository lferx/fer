trigger Trigger_Recuento_Propiedades on ClienteOferta__c (after insert, after update) {

	Map<String,List<ClienteOferta__c>> mapaClientes;
	List<Account> listaCuentas;
	List<ClienteOferta__c> listaClienteOferta;
	List<String> cuentas;
	List<ClienteOferta__c> segmentoClienteOferta;
	Integer total;
	Integer cerrados;
	Integer participante;

	Integer contados;

	cuentas = new List<String>();
	mapaClientes = new Map<String,List<ClienteOferta__c>>();

	for(ClienteOferta__c co: Trigger.new){
		cuentas.add(co.Cuenta__c);
	}


	listaCuentas = [SELECT Id, Registros_Totales__c, Cerrado__c, Activos__c, Target__c, type FROM Account WHERE id IN :cuentas ];
	listaClienteOferta = [SELECT Id,Estatus2__c,Cuenta__c,Oferta__r.Paquete_de_Ofertas__c, Oferta__r.TipoOferta__c, Oferta__r.Total_cobrado__c FROM ClienteOferta__c WHERE Cuenta__c IN :cuentas];
	System.debug('listaCuentas: '+listaCuentas);
	System.debug('listaClienteOferta: '+listaClienteOferta);
	
	for(ClienteOferta__c clientOfer: listaClienteOferta){

		if(mapaClientes.get(clientOfer.Cuenta__c) == NULL){
			segmentoClienteOferta = new List<ClienteOferta__c>();
		}
		else{
			segmentoClienteOferta = mapaClientes.get(clientOfer.Cuenta__c);
		}
		segmentoClienteOferta.add(clientOfer);

		mapaClientes.put(clientOfer.Cuenta__c,segmentoClienteOferta);

	}
	System.debug('mapaClientes: '+mapaClientes);
	for(Account cuenta: listaCuentas){
		total = 0;
		cerrados = 0;
		contados = 0;
		participante = 0;

		for(ClienteOferta__c reg: mapaClientes.get(cuenta.id)){
			if(reg.Estatus2__c == 'Cliente final'){
				cerrados++;
				if(reg.Oferta__r.TipoOferta__c == 'Contado'){
					contados++;
				}
				if(reg.Oferta__r.Paquete_de_Ofertas__c != NULL || (reg.Oferta__r.TipoOferta__c == 'Contado' && contados > 1)){
					cuenta.Target__c = '1';
				}
				else if(reg.Oferta__r.TipoOferta__c == 'Contado' && reg.Oferta__r.Total_cobrado__c >= 500000){
					cuenta.Target__c = '2';
				}
			}
			else{
				participante++;
			}

			if(cuenta.Target__c == NULL && participante > 1){
				cuenta.Target__c = '3';
			}
			else if(cuenta.Target__c == NULL && cuenta.type == 'Inversionista'){
				cuenta.Target__c = '3';
			}
			total++;
			System.debug('cerrados: '+cerrados);
			System.debug('total: '+total);
		}

		cuenta.Registros_Totales__c = total;
		cuenta.Cerrado__c = cerrados;
		System.debug('cuenta.Registros_Totales__c: '+cuenta.Registros_Totales__c);
		System.debug('cuenta.Cerrado__c: '+cuenta.Cerrado__c);

	}
	System.debug('mapaClientes: '+mapaClientes);
	System.debug('listaCuentas: '+listaCuentas);

	UPDATE listaCuentas;

}