//Fer //modificacion edgar
trigger Feer on Oferta__c (after update) {
	//codigo de edgar
	//list<Integer> init1 = new list<Integer>{0,0}; //numeros en 0 posicion 0 para vendidas y 1 para disponibles
	//list<Integer> init2 = new list<Integer>{0,0}; 
	//list<Integer> init3 = new list<Integer>{0,0}; 
	Map<Id,list<Integer>> mapaEstados = new Map<Id,list<Integer>>();
	Map<Id,list<Integer>> mapaCiudades = new Map<Id,list<Integer>>();
	Map<Id,list<Integer>> mapaColonia = new Map<Id,list<Integer>>();

	for(Oferta__c c:Trigger.new){
		if(String.isNotBlank(c.Estado__c)){
			mapaEstados.put(c.Estado__c,new list<Integer>{0,0});
		}
		if(String.isNotBlank(c.Ciudad_Tabla__c)){
			mapaCiudades.put(c.Ciudad_Tabla__c,new list<Integer>{0,0});
		}
		if(String.isNotBlank(c.Colonia_busqueda__c)){
			mapaColonia.put(c.Colonia_busqueda__c,new list<Integer>{0,0});
		}
	}

	if(mapaEstados != null && mapaEstados.size() > 0){
		system.debug('Encontro listas de Estado');
		List<Oferta__c> lstOferta = [SELECT id,Name,Estatus__c,FechaCobro__c,FechaPago__c,Etapa__c,Estatus_de_invasion__c,Estado__c,Ciudad_tabla__c,Colonia_busqueda__c FROM Oferta__c WHERE FechaPago__c != Null AND Estatus__c != 'Descartada' AND Estado__c IN:mapaEstados.keyset()];
		//Database.query(campos+condiciones+'Estado__c IN '+mapaEstados.keyset());
		for(Oferta__c x : lstOferta){
			/*if(String.isBlank(x.FechaPago__c){
				system.debug('oferta descartada');
				//pendientes de adquirir
			}else  if(x.Etapa__c == 'Oferta' || x.Etapa__c == 'Oferta en proceso' || x.Etapa__c == 'Oferta aprobada' || x.Etapa__c == 'Antecedentes completados' || x.Etapa__c == 'Aprobada internamente'){
				system.debug('oferta en espera');
				//pendientes de adquirir
			}else */
			if(x.FechaCobro__c != null){
				//vendidas [0]
				mapaEstados.get(x.Estado__c)[0] +=1;
			}/*else if(x.Etapa__c == 'Aprobada internamente'){
				//pendientes de adquirir
			}*/
			else if(x.Etapa__c == 'Compilación expediente compra' || x.Etapa__c == 'Compra final' || x.Etapa__c == 'Escrituras en proceso registro' || x.Etapa__c == 'Compilación expediente cliente' || x.Etapa__c == 'Rehabilitación' || x.Etapa__c == 'Compilación expediente crediticio' || x.Etapa__c == 'Expediente aprobado' || x.Etapa__c == 'Cierre oferta'){
				//en venta
				mapaEstados.get(x.Estado__c)[1] +=1;
			}else if(x.Etapa__c == 'Finalizada'){
				//vendidas [0]
				mapaEstados.get(x.Estado__c)[0] +=1;
			}
		}
		List<Estados__c> estados = new List<Estados__c>();
		for(id y : mapaEstados.keyset()){
			Integer v = mapaEstados.get(y)[0];//vendidas
			Integer d = mapaEstados.get(y)[1];//disponibles
			Estados__c edo = new Estados__c(id=y,vendidas__c=v,Propiedades_Disponibles__c=d);
			estados.add(edo);
		}
		if(estados.size() > 0){
			system.debug('Estados: '+estados);
			update estados;
		}
	}
	if(mapaCiudades != null && mapaCiudades.size() > 0){
		system.debug('Encontro listas de Estado');
		List<Oferta__c> lstOferta = [SELECT id,Name,Estatus__c,FechaCobro__c,FechaPago__c,Etapa__c,Estatus_de_invasion__c,Estado__c,Ciudad_tabla__c,Colonia_busqueda__c FROM Oferta__c WHERE FechaPago__c != Null AND Estatus__c != 'Descartada' AND Ciudad_tabla__c IN:mapaCiudades.keyset()];
		//Database.query(campos+condiciones+'Ciudad_tabla__c IN '+mapaEstados.keyset());

		for(Oferta__c x : lstOferta){
			/*if(String.isBlank(x.FechaPago__c){
				system.debug('oferta descartada');
				//pendientes de adquirir
			}else  if(x.Etapa__c == 'Oferta' || x.Etapa__c == 'Oferta en proceso' || x.Etapa__c == 'Oferta aprobada' || x.Etapa__c == 'Antecedentes completados' || x.Etapa__c == 'Aprobada internamente'){
				system.debug('oferta en espera');
				//pendientes de adquirir
			}else */
			if(x.FechaCobro__c != null){
				//vendidas [0]
				mapaCiudades.get(x.Ciudad_tabla__c)[0] +=1;
			}/*else if(x.Etapa__c == 'Aprobada internamente'){
				//pendientes de adquirir
			}*/
			else if(x.Etapa__c == 'Compilación expediente compra' || x.Etapa__c == 'Compra final' || x.Etapa__c == 'Escrituras en proceso registro' || x.Etapa__c == 'Compilación expediente cliente' || x.Etapa__c == 'Rehabilitación' || x.Etapa__c == 'Compilación expediente crediticio' || x.Etapa__c == 'Expediente aprobado' || x.Etapa__c == 'Cierre oferta'){
				//en venta
				mapaCiudades.get(x.Ciudad_tabla__c)[1] +=1;
			}else if(x.Etapa__c == 'Finalizada'){
				//vendidas [0]
				mapaCiudades.get(x.Ciudad_tabla__c)[0] +=1;
			}
		}
		List<Ciudad__c> ciudades = new List<Ciudad__c>();
		for(id y : mapaCiudades.keyset()){
			Integer v = mapaCiudades.get(y)[0];//vendidas
			Integer d = mapaCiudades.get(y)[1];//disponibles
			Ciudad__c cd = new Ciudad__c(id=y,Propiedades_vendidas__c=v,Propiedades_Disponibles__c=d);
			ciudades.add(cd);
		}
		if(ciudades.size() > 0){
			system.debug('Ciudades: '+ciudades);
			update ciudades;
		}
		
	}
	if(mapaColonia != null && mapaColonia.size() > 0){
		system.debug('Encontro listas de Ciudad');
		List<Oferta__c> lstOferta = [SELECT id,Name,Estatus__c,FechaCobro__c,FechaPago__c,Etapa__c,Estatus_de_invasion__c,Estado__c,Ciudad_tabla__c,Colonia_busqueda__c FROM Oferta__c WHERE FechaPago__c != Null AND Estatus__c != 'Descartada' AND Colonia_busqueda__c IN:mapaColonia.keyset()];
		//Database.query(campos+condiciones+'Colonia_busqueda__c IN '+mapaEstados.keyset());
		//query('Colonia_busqueda__c',mapaColonia.keyset());
		for(Oferta__c x : lstOferta){
			/*if(String.isBlank(x.FechaPago__c){
				system.debug('oferta descartada');
				//pendientes de adquirir
			}else  if(x.Etapa__c == 'Oferta' || x.Etapa__c == 'Oferta en proceso' || x.Etapa__c == 'Oferta aprobada' || x.Etapa__c == 'Antecedentes completados' || x.Etapa__c == 'Aprobada internamente'){
				system.debug('oferta en espera');
				//pendientes de adquirir
			}else */
			if(x.FechaCobro__c != null){
				//vendidas [0]
				mapaColonia.get(x.Colonia_busqueda__c)[0] +=1;
			}/*else if(x.Etapa__c == 'Aprobada internamente'){
				//pendientes de adquirir
			}*/
			else if(x.Etapa__c == 'Compilación expediente compra' || x.Etapa__c == 'Compra final' || x.Etapa__c == 'Escrituras en proceso registro' || x.Etapa__c == 'Compilación expediente cliente' || x.Etapa__c == 'Rehabilitación' || x.Etapa__c == 'Compilación expediente crediticio' || x.Etapa__c == 'Expediente aprobado' || x.Etapa__c == 'Cierre oferta'){
				//en venta
				mapaColonia.get(x.Colonia_busqueda__c)[1] +=1;
				system.debug('ofertas: '+ x.name);
			}else if(x.Etapa__c == 'Finalizada'){
				//vendidas [0]
				mapaColonia.get(x.Colonia_busqueda__c)[0] +=1;
			}
		}
		List<ColoniaFraccionamiento__c> colonias = new List<ColoniaFraccionamiento__c>();
		for(id y : mapaColonia.keyset()){
			Integer v = mapaColonia.get(y)[0];//vendidas
			Integer d = mapaColonia.get(y)[1];//disponibles
			ColoniaFraccionamiento__c col = new ColoniaFraccionamiento__c(id=y,vendidas__c=v,Propiedades_Disponibles__c=d);
			colonias.add(col);
		}
		if(colonias.size() > 0){
			system.debug('Colonias: '+colonias);
			update colonias;
		}
		
	}

	Set<Id> idOfertas = new Set<Id>();

	if(trigger.isAfter && trigger.isUpdate){
		for(Oferta__c ofer:Trigger.new){
			idOfertas.add(ofer.id);
		}

		List<ClienteOferta__c> co = [SELECT id FROM ClienteOferta__c WHERE Oferta__c in :idOfertas];
		if(co.size() > 0){
			UPDATE co;
		}

	}



/*

	IF(ISBLANK(Ultima_fecha_de_pago__c),'3-Descartada', 
IF(Etapa_Oferta__c ='Descartada','3-Descartada', 
IF(Etapa_Oferta__c ='Oferta','0-En espera', 
IF(Etapa_Oferta__c ='Oferta en proceso','0-En espera', 
IF(Etapa_Oferta__c ='Oferta aprobada','0-En espera', 
IF(Etapa_Oferta__c ='Antecedentes completados','0-En espera', 
IF(NOT(ISBLANK(Ultima_fecha_de_cobro__c)),'2-Vendida', 
IF(Etapa_Oferta__c ='Aprobada internamente','0-En espera', 
IF(Etapa_Oferta__c ='Compilación expediente compra','1-En venta', 
IF(Etapa_Oferta__c ='Compra final','1-En venta', 
IF(Etapa_Oferta__c ='Escrituras en proceso registro','1-En venta', 
IF(Etapa_Oferta__c ='Compilación expediente cliente','1-En venta', 
IF(Etapa_Oferta__c ='Rehabilitación','1-En venta', 
IF(Etapa_Oferta__c ='Compilación expediente crediticio','1-En venta', 
IF(Etapa_Oferta__c ='Expediente aprobado','1-En venta', 
IF(Etapa_Oferta__c ='Cierre oferta','1-En venta', 
IF(Etapa_Oferta__c ='Finalizada','2-Vendida', 
'3-Descartada')))))))))))))))))

*/


	/*
		

Map<Integer, List<integer>> map1 = new Map<Integer, List<integer>> {};

map1.put(1,null);
map1.put(2,null);
map1.put(3, null);
map1.put(4,null);
map1.put(5,null);
map1.put(6, null);
List<integer> algo = new List<integer>{0,0};
map1.put(1,algo);
system.debug(map1.keyset());
system.debug(map1.values());
system.debug(map1);
map1.get(1)[0] +=1;

system.debug(map1);
	*/
	
	
	//codigo de fer
	//for (Oferta__c c:Trigger.new){
	//	system.debug('trigger');
	//	oferta__c v=trigger.oldMap.get(c.id);
	//	if (v.fechacobro__c!=c.fechacobro__c){
	//		system.debug('ejecuto query');
	//		if (c.Estado__c!=null){

	//			integer i=[select count() from oferta__c where FechaCobro__c != null AND Estado__c =:c.Estado__c];
	//			//Estados__c objEstado=[select id, vendidas__c, Propiedades_Disponibles__c from Estados__c where id=:c.Estado__c];
	//			//objEstado.vendidas__c=i;
		 
	//			integer d=[SELECT count() FROM Oferta__c WHERE Estatus__c != 'Descartada' AND FechaCobro__c = Null AND FechaPago__c != Null AND ((Etapa__c IN ('Compilación expediente compra','Compra final','Escrituras en proceso registro','Compilación expediente cliente')) OR (Etapa__c IN ('Rehabilitación') AND Estatus_de_invasion__c = 'Invadida')) AND Estado__c =:c.Estado__c ];
	//			//objEstado.Propiedades_Disponibles__c=d;
	//			Estados__c objEstado =new Estados__c(id=c.Estado__c,vendidas__c=i,Propiedades_Disponibles__c=d);
	//			update objEstado;
	//		}

	//		if (c.Ciudad_tabla__c !=null){
	//			integer x=[select count() from oferta__c where FechaCobro__c != null AND Ciudad_tabla__c =:c.Ciudad_tabla__c];
	//			//Ciudad__c objCiudad=[select id, Propiedades_Disponibles__c,Propiedades_vendidas__c from Ciudad__c where id=:c.Ciudad_tabla__c];
	//			//objCiudad.Propiedades_vendidas__c=x;
	//			integer s=[SELECT count() FROM Oferta__c WHERE Estatus__c != 'Descartada' AND FechaCobro__c = Null AND FechaPago__c != Null AND ((Etapa__c IN ('Compilación expediente compra','Compra final','Escrituras en proceso registro','Compilación expediente cliente')) OR (Etapa__c IN ('Rehabilitación') AND Estatus_de_invasion__c = 'Invadida')) AND Ciudad_tabla__c =:c.Ciudad_tabla__c];
	//			//objCiudad.Propiedades_Disponibles__c=s; 
	//			Ciudad__c objCiudad= new Ciudad__c(id=c.Ciudad_tabla__c,Propiedades_vendidas__c = x,Propiedades_Disponibles__c=s);
	//			update objCiudad;
	//		}

	//		if (c.Colonia_busqueda__c!=null){
	//			integer y=[select count() from oferta__c where FechaCobro__c != null AND Colonia_busqueda__c =:c.Colonia_busqueda__c];
	//			//ColoniaFraccionamiento__c objColonia=[select id, vendidas__c, Propiedades_Disponibles__c from ColoniaFraccionamiento__c where id=:c.Colonia_busqueda__c];
	//			//objColonia.vendidas__c=y;
 
	//			integer k=[SELECT count() FROM Oferta__c WHERE Estatus__c != 'Descartada' AND FechaCobro__c = Null AND FechaPago__c != Null AND ((Etapa__c IN ('Compilación expediente compra','Compra final','Escrituras en proceso registro','Compilación expediente cliente')) OR (Etapa__c IN ('Rehabilitación') AND Estatus_de_invasion__c = 'Invadida')) AND Colonia_busqueda__c =:c.Colonia_busqueda__c ];
	//			//objColonia.Propiedades_Disponibles__c=k;
	//			ColoniaFraccionamiento__c objColonia=new ColoniaFraccionamiento__c(id=c.Colonia_busqueda__c,vendidas__c=y,Propiedades_Disponibles__c=k);     
	//			update objColonia; 
	//		}
 //  		}
	//}
}