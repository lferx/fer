global class BatchVincularOfertasClientes implements Database.Batchable<sObject> { 
	
	global final String Query; 
	
	global BatchVincularOfertasClientes(String q){
		Query=q;	
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC){
		return Database.getQueryLocator(Query);
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		
		
		//Se transforma el scope en nuna lista de clientes,
		
		List<Account> lstClientes = (List<Account>)scope;
		
		//En el siguiente conjunto insertaremos todas las plazas en las que se encuentren nuestros clientes
		Set<String> setPlazas = new Set<String>();
		
		
		//Se necesitara saber el rango maximo nuestra lista de clientes por lo que declaramos una variable en donde almacenaremos ese dato
		Decimal decCreditoMaximo = (lstClientes != null && lstClientes.size() != null && lstClientes.size() > 0 )?lstClientes[0].Precalificacion__c:0;
		
		//Esta lista almacenara las ofertas que vincularemos a los clientes
		List<Oferta__c> lstOfertas = new List<Oferta__c>();
		
		//Esta lista sera la lista de clientesOferta que insertaremos
		List<ClienteOferta__c> lstClienteOfreta = new List<ClienteOferta__c>();
		 
		for(Account cliente:lstClientes){
			//Insertamos la plaza del lead al conjunto
			setPlazas.add( cliente.Plaza__c );			
		}
		
				
		//De aqui savaremos las etapas de las ofertas que buscaremos
		Map<String, Configuracion_Etapa_Lead__c> mapConfiguracionEtapaLead = Configuracion_Etapa_Lead__c.getAll();
				
		Set<String> setEtapas = new Set<String>();
		
		for( Configuracion_Etapa_Lead__c configuarcioEtapa : mapConfiguracionEtapaLead.values() ){
			setEtapas.add( configuarcioEtapa.Name );
		}
				
		//Consultamos las ofertas con los anteriores parametros aprovechandonos de la lupa de propiedades en el objeto.
			lstOfertas = [
						SELECT Id,Name,Etapa__c,PrecioVenta__c,Plaza__c, Propiedad__r.Estatus__c ,Propiedad__c,Propiedad__r.Oferta_Valor_Referencia__c,Propiedad__r.Plaza__c 
						FROM Oferta__c 
						WHERE Propiedad__r.Plaza__c IN :setPlazas 
						AND PrecioVenta__c <= :decCreditoMaximo 
						AND Etapa__c IN :setEtapas
						AND Estatus__c != 'Descartada' ];

		
						
		Integer	numLeads = 0;			
		
		for( Account cliente:lstClientes){ 
			
			cliente.Vincular_ofertas__c = false;
			
			numLeads = 0;
			
			for(Oferta__c oferta:lstOfertas){
				
				if( oferta.Plaza__c == cliente.Plaza__c ){							
					if( oferta.PrecioVenta__c <= cliente.Precalificacion__c ){
						ClienteOferta__c co = new ClienteOferta__c();
						co.Oferta__c = oferta.Id;
						co.Cuenta__c = cliente.Id;
						co.Contacto__c = cliente.Contacto__c;
						
						if( numLeads < 10 ){
							lstClienteOfreta.add( co );
							numLeads++;
						}
					}
				}
				
			}
		}
		
		
		if(!lstClienteOfreta.isEmpty()){
			insert lstClienteOfreta;
		}
		
		
		if(!lstClientes.isEmpty()){
			
			update lstClientes;
			
		}
		

	}
	
	global void finish(Database.BatchableContext BC){
	
	}
	

}