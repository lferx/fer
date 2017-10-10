global with sharing class BatchGeolocalizadorMejorado  implements Database.Batchable<sObject>,Schedulable, Database.AllowsCallouts{
	public String sQuery {get;set;}
	list<Propiedad__c> propiedadesUpdate = new list<Propiedad__c>();
	GeolocalizadorMejoradoController gmc = new GeolocalizadorMejoradoController();
	
	global Database.QueryLocator start(Database.BatchableContext BC){
		sQuery = 'SELECT Id,Name,Plaza__c,Estado__c,Estado2__c,EstadoCompleto__c,Municipio__c,Municipio2__c,Colonia__c,Colonia2__c,Calle__c,Calle2__c,CP__c,CP2__c,' +
							 'ValorCompra__c,ValorReferencia__c, Tipo__c,Punto__c,Punto__Latitude__s,Punto__Longitude__s,Geolocalizada__c,Terreno_m2__c, ' +
							 'FechaPublicacionWeb__c, Construccion_m2__c, EstatusVenta2__c, FolioWeb__c '+
				 ' FROM Propiedad__c WHERE ' +
				 ' Punto__latitude__s = null';
				 //' Where TipoGeolocalizacion__c = null';
		return Database.getQueryLocator(sQuery);
	}
	
	global void execute(Database.BatchableContext BC, List<Propiedad__c> propiedades){
		try{
			Propiedad__c propResult = null;
            for(Propiedad__c propiedad : propiedades){
	            	String direccion = '';
	            	String response = '';
	            	boolean bEstadoIgual = false;
	            	boolean bMunicipioIgual = false;
	            	boolean bGeolocalizada = false;
	            	Integer intentos = 0;
	        		propiedad.TipoGeolocalizacion__c = 'Dirección completa';
	        		direccion = propiedad.Calle__c +','+ propiedad.Colonia__c + ','+ propiedad.Municipio__c + ',' + propiedad.EstadoCompleto__c +',' + propiedad.CP__c;
	        		do{
	        			response = gmc.getGoogleResponse(direccion);
	        			propResult = gmc.parseResponse(response,propiedad);
	        			if(propResult != null){
	        				String estado = regresaCadenaLimpia(propResult.EstadoCompleto__c);
							String estado3 = regresaCadenaLimpia(propResult.Estado3__c);
							String municipio = regresaCadenaLimpia(propResult.Municipio__c);
							String municipio3 = regresaCadenaLimpia(propResult.Municipio3__c);
							String resultadoGeolocalizacion = propResult.Geolocalizada__c; //Si encontro algo con la direccion;

							if(estado.contains(estado3) || estado3.contains(estado)  ){
								bEstadoIgual = true;
							}
							
							if(municipio3.length() > 1){
								if(municipio.contains(municipio3) || municipio3.contains(municipio)  ){
									bMunicipioIgual = true;
								} 
							}

							if(resultadoGeolocalizacion.equals('No') || (!bEstadoIgual || !bMunicipioIgual)){
								intentos = intentos + 1;
								propResult  = null;
								direccion = 'Mexico';
								if(intentos == 1){
									propiedad.TipoGeolocalizacion__c ='Dirección colonia municipio estado cp';
		        					direccion = propiedad.Colonia__c + ','+ propiedad.Municipio__c + ',' + propiedad.EstadoCompleto__c +',' + propiedad.CP__c;
								}else if(intentos == 2){
									propiedad.TipoGeolocalizacion__c ='Dirección Colonia municipio estado';
			        				direccion = propiedad.Colonia__c + ','+ propiedad.Municipio__c + ',' + propiedad.EstadoCompleto__c;										
								}else {
									propiedad.TipoGeolocalizacion__c = 'Dirección municipio estado';
		        					direccion = propiedad.Municipio__c + ',' + propiedad.EstadoCompleto__c +',Mexico'; 
								}
							}else{
								bGeolocalizada = true;
								propResult.Geolocalizada__c = 'Si';
							}

							if(propResult != null){
								propiedadesUpdate.add(propResult);
							}
							
	        			}else{
	        				System.debug('ERROR LOCALIZANOD PROPIEDAD' + propiedad.name );
	        			}
	        			

	        		}while(!bGeolocalizada && intentos <= 3);
	        		
            }
            update propiedadesUpdate;
        }catch(QueryException e){
        	propiedades = new List<Propiedad__c>();
            sQuery = e.getMessage() + ' sQuery:' + sQuery;
            System.debug(sQuery);
        } 
	}
	
	private string regresaCadenaLimpia(String cadena){
		String cadenaLimpia = '';
	    if(cadena != null){
			cadenaLimpia = cadena.toLowerCase().replace(' ', '').trim();
			cadenaLimpia  = cadenaLimpia.replace('á','a');
			cadenaLimpia  = cadenaLimpia.replace('é','e');
			cadenaLimpia  = cadenaLimpia.replace('í','i');
			cadenaLimpia  = cadenaLimpia.replace('ó','o');
			cadenaLimpia  = cadenaLimpia.replace('ú','u');
			cadenaLimpia = cadenaLimpia.replace('?','ñ');
		}
		return cadenaLimpia;
	}
	global void finish(Database.BatchableContext BC){
		System.debug('BatchGeolocalizadorMejorado - Finish');
	}
	global void execute(SchedulableContext sc){
	   ID id = Database.executeBatch(new BatchGeolocalizadorMejorado(),5);
	}
}