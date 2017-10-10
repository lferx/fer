trigger TriggerPropiedadesRevimex on Propiedad__c (after insert,after update) {
	System.debug('comiensa a correr trigger de propiedad que modifica la colonia con el precio medio');
	Map<ID,List<Propiedad__c>> mapaCompleto = new Map<ID,List<Propiedad__c>>();
	List<ColoniaFraccionamiento__c> listaColonias = new List<ColoniaFraccionamiento__c>();
	List<Propiedad__c> listaPropiedad = new List<Propiedad__c>();
	List<Propiedad__c> listaTodasPropiedad = new List<Propiedad__c>();
	List<ID> allID = new List<ID>();

	Boolean bandera;
	//Boolean error = false;

	for(Propiedad__c registro:Trigger.new){
		if(String.isNotEmpty(registro.Colonia_Busqueda__c)){
			allID.add(registro.Colonia_Busqueda__c);
			System.debug('Ids Insertados: ' + registro.Colonia_Busqueda__c);
		}
	}

	try{
		system.debug('Entro a hacer la query');
		listaTodasPropiedad = [SELECT id,name,Colonia_Busqueda__c,Oferta_Valor_Referencia__c,ltima_Oferta__r.Total_cobrado__c,ltima_Oferta__r.FechaCobro__c,Terreno_m2__c,Construccion_m2__c FROM Propiedad__c WHERE Colonia_Busqueda__c in :allID AND ltima_Oferta__r.Estatus__c != 'Descartada' AND Oferta__r.FechaPago__c != NULL AND Colonia_Busqueda__c != NULL];
		system.debug('Entro a hacer la query2: '+listaTodasPropiedad);
	}catch(exception e){
		listaTodasPropiedad.clear();
		system.debug('Algo salio mal al buscar la query: '+ listaTodasPropiedad +' Error: '+ e);
		//error = true;
	}
	
	//AND Oferta_Valor_Referencia__c != NULL AND Terreno_m2__c != NULL AND Construccion_m2__c != NULL AND Oferta_Valor_Referencia__c > 0 AND Terreno_m2__c > 0 AND Construccion_m2__c > 0
	system.debug('codigo 100');
	for(Propiedad__c registro:listaTodasPropiedad){
		system.debug('codigo 101');
		listaPropiedad = new List<Propiedad__c>();
		listaPropiedad = mapaCompleto.get(registro.Colonia_Busqueda__c);

		if(listaPropiedad == NULL){
			listaPropiedad = new List<Propiedad__c>();
		}
		listaPropiedad.add(registro);
		mapaCompleto.put(registro.Colonia_Busqueda__c,listaPropiedad);
	}
	system.debug('codigo 200');
	for(ID idColonia: mapaCompleto.keySet()){
		system.debug('codigo 201');
		Double precioMinRevimex = 0;
		Double precioMaxRevimex = 0;
		Double precioMedio = 0;
		Double metroTerrenoMedio = 0;
		Double metroConstruccionMedio = 0;
		Integer contadorMedio = 0;


		//cobradas
		Double precioMedioCobradas = 0;
		Double consVendidas = 0;
		Integer contadorMedioCobradas = 0;
		//fin cobradas
		bandera = true;
		system.debug('codigo 300');
		for(Propiedad__c propiedadRevimex: mapaCompleto.get(idColonia)){
			system.debug('codigo 301');
			if(propiedadRevimex.Oferta_Valor_Referencia__c != NULL && propiedadRevimex.Terreno_m2__c != NULL && propiedadRevimex.Construccion_m2__c != NULL && propiedadRevimex.Oferta_Valor_Referencia__c > 0 && propiedadRevimex.Terreno_m2__c > 0 && propiedadRevimex.Construccion_m2__c > 0){
				if(bandera){
					precioMinRevimex = propiedadRevimex.Oferta_Valor_Referencia__c;
					precioMaxRevimex = propiedadRevimex.Oferta_Valor_Referencia__c;
					bandera = false;
				}
				else{
					if(propiedadRevimex.Oferta_Valor_Referencia__c < precioMinRevimex){
						precioMinRevimex = propiedadRevimex.Oferta_Valor_Referencia__c;
					}
					if(propiedadRevimex.Oferta_Valor_Referencia__c > precioMaxRevimex){
						precioMaxRevimex = propiedadRevimex.Oferta_Valor_Referencia__c;
					}
				}

				precioMedio += propiedadRevimex.Oferta_Valor_Referencia__c;
				metroTerrenoMedio += propiedadRevimex.Terreno_m2__c;
				metroConstruccionMedio +=  propiedadRevimex.Construccion_m2__c;
				contadorMedio +=1;
			}
			if( propiedadRevimex.ltima_Oferta__r.Total_cobrado__c != null && propiedadRevimex.ltima_Oferta__r.Total_cobrado__c > 0 && propiedadRevimex.ltima_Oferta__r.FechaCobro__c != null && propiedadRevimex.Construccion_m2__c != NULL && propiedadRevimex.Construccion_m2__c > 0){
				precioMedioCobradas += propiedadRevimex.ltima_Oferta__r.Total_cobrado__c;
				consVendidas += propiedadRevimex.Construccion_m2__c;
				contadorMedioCobradas ++;
			}
		}
		if(contadorMedio > 0){
			system.debug('codigo 400');
			precioMedio /= contadorMedio;
			metroTerrenoMedio /= contadorMedio;
			metroConstruccionMedio /= contadorMedio;
		}
		if(contadorMedioCobradas > 0){
			system.debug('codigo 500');
			precioMedioCobradas /= contadorMedioCobradas;
			consVendidas /= contadorMedioCobradas;
		}
		if(contadorMedioCobradas > 0 || contadorMedio > 0){
			system.debug('codigo 600');
			ColoniaFraccionamiento__c colonia = new ColoniaFraccionamiento__c();
			colonia.id=idColonia;

			colonia.Precio_minimo_revimex__c=precioMinRevimex;
			colonia.Precio_maximo_revimex__c=precioMaxRevimex;
			colonia.Precio_medio_de_revimex__c=precioMedio;
			colonia.m2_construccion_medio_revimex__c=metroConstruccionMedio;
			colonia.m2_terreno_medio_revimex__c=metroTerrenoMedio;
			colonia.Precio_medio_vendido__c = precioMedioCobradas;
			colonia.m2_construccion_medio_vendido__c = consVendidas;
			
			system.debug('Colonia: '+colonia);

			listaColonias.add(colonia);

		}
		//ColoniaFraccionamiento__c colonia = new ColoniaFraccionamiento__c(
		//	id=idColonia,
		//	Precio_minimo_revimex__c=precioMinRevimex,
		//	Precio_maximo_revimex__c=precioMaxRevimex,
		//	Precio_medio_de_revimex__c=precioMedio,
		//	m2_construccion_medio_revimex__c=metroConstruccionMedio,
		//	m2_terreno_medio_revimex__c=metroTerrenoMedio,
		//	Precio_medio_vendido__c = precioMedioCobradas,
		//	m2_construccion_medio_vendido__c = consVendidas
		//);
		//system.debug('Colonia: '+colonia);

		//listaColonias.add(colonia);
	}
	if(!listaColonias.isEmpty()){
		system.debug('si actualizo: '+listaColonias);
		UPDATE listaColonias;
		system.debug('si actualizo2: '+listaColonias);
		
	}
	
}