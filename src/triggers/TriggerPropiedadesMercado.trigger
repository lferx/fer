trigger TriggerPropiedadesMercado on Propiedad_de_Mercado__c (after insert,after update) {

	Map<ID,List<Propiedad_de_Mercado__c>> mapaCompleto = new Map<ID,List<Propiedad_de_Mercado__c>>();
	List<ColoniaFraccionamiento__c> listaColonias = new List<ColoniaFraccionamiento__c>();
	List<Propiedad_de_Mercado__c> listaPropiedad = new List<Propiedad_de_Mercado__c>();
	List<Propiedad_de_Mercado__c> listaTodasPropiedad = new List<Propiedad_de_Mercado__c>();
	List<ID> allID = new List<ID>();



	for(Propiedad_de_Mercado__c registro:Trigger.new){
		allID.add(registro.Colonia__c);
	}

	//listaTodasPropiedad = [SELECT id,name,Colonia__c,Precio_propiedad__c,m2_terreno__c,	m2_construccion__c FROM Propiedad_de_Mercado__c WHERE Colonia__c in :allID AND Colonia__c != NULL AND Precio_propiedad__c != NULL AND m2_terreno__c != NULL AND m2_construccion__c != NULL AND Precio_propiedad__c > 0 AND m2_terreno__c > 0 AND m2_construccion__c > 0];
	listaTodasPropiedad = [SELECT id,name,Colonia__c,Precio_propiedad__c,m2_terreno__c,	m2_construccion__c FROM Propiedad_de_Mercado__c WHERE Colonia__c in :allID AND Colonia__c != NULL AND Precio_propiedad__c != NULL AND m2_construccion__c != NULL AND Precio_propiedad__c > 0 AND m2_construccion__c > 0];
	for(Propiedad_de_Mercado__c registro:listaTodasPropiedad){
		
		listaPropiedad = new List<Propiedad_de_Mercado__c>();
		listaPropiedad = mapaCompleto.get(registro.Colonia__c);

		if(listaPropiedad == NULL){
			listaPropiedad = new List<Propiedad_de_Mercado__c>();
		}
		listaPropiedad.add(registro);
		mapaCompleto.put(registro.Colonia__c,listaPropiedad);
	}

	for(ID idColonia: mapaCompleto.keySet()){
		Double precioMinMercado = 0;
		Double precioMaxMercado = 0;
		Double precioMedio = 0;
		Double metroTerrenoMedio = 0;
		Double metroConstruccionMedio = 0;

		Integer precioMedioCount = 0;
		Integer metroTerrenoMedioCount = 0;
		Integer metroConstruccionMedioCount = 0;

		Boolean bandera = true;
		for(Propiedad_de_Mercado__c propiedadMercado: mapaCompleto.get(idColonia)){

			if(bandera){
				precioMinMercado = propiedadMercado.Precio_propiedad__c;
				precioMaxMercado = propiedadMercado.Precio_propiedad__c;
				bandera = false;
			}
			else{
				if(propiedadMercado.Precio_propiedad__c < precioMinMercado){
					precioMinMercado = propiedadMercado.Precio_propiedad__c;
				}
				if(propiedadMercado.Precio_propiedad__c > precioMaxMercado){
					precioMaxMercado = propiedadMercado.Precio_propiedad__c;
				}
			}
			if(propiedadMercado.Precio_propiedad__c != null && propiedadMercado.Precio_propiedad__c > 0){
				precioMedio += propiedadMercado.Precio_propiedad__c;
				precioMedioCount ++;
			}
			if(propiedadMercado.m2_terreno__c != null && propiedadMercado.m2_terreno__c > 0){
				metroTerrenoMedio += propiedadMercado.m2_terreno__c;
				metroTerrenoMedioCount ++;
			}
			if(propiedadMercado.m2_construccion__c != null && propiedadMercado.m2_construccion__c > 0){
				metroConstruccionMedio +=  propiedadMercado.m2_construccion__c;
				metroConstruccionMedioCount ++;
			}
		}
		//precioMedio /= mapaCompleto.get(idColonia).size();
		//metroTerrenoMedio /= mapaCompleto.get(idColonia).size();
		//metroConstruccionMedio /= mapaCompleto.get(idColonia).size();
		if(precioMedioCount > 0)
			precioMedio /= precioMedioCount;
		if(metroTerrenoMedioCount > 0)
			metroTerrenoMedio /= metroTerrenoMedioCount;
		if(metroConstruccionMedioCount > 0)
			metroConstruccionMedio /= metroConstruccionMedioCount;

		ColoniaFraccionamiento__c colonia = new ColoniaFraccionamiento__c(id=idColonia,Precio_minimo_mercado__c=precioMinMercado,Precio_maximo_mercado__c=precioMaxMercado,Precio_medio_de_mercado__c=precioMedio,m2_construccion_medio_mercado__c=metroConstruccionMedio,m2_terreno_medio_mercado__c=metroTerrenoMedio);

		listaColonias.add(colonia);
	}

	UPDATE listaColonias;

}