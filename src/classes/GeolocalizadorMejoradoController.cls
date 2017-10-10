public with sharing class GeolocalizadorMejoradoController {
	public String colonia {get;set;}
	public String cp {get;set;}
	public String calle {get;set;}
	public String municipio {get;set;}
	public String estado {get;set;}
	public String contenCiudad3 {get;set;}
	public String direccionGoogle {get;set;}
	
	list<Propiedad__c> propiedadesUpdate = new list<Propiedad__c>();
	String sQuery = '';
	
	class GoogleGeoCodeResponse {
		public String status ;
		public results[] results ;
		public GoogleGeoCodeResponse() {

        }
	}
	
	class results{
        public String formatted_address ;
        public geometry geometry ;
        public String[] types;
        public address_component[] address_components;
    }

     class geometry{
         public bounds bounds;
        public String location_type ;
        public location location;
        public bounds viewport;
    }

     class bounds {

         public location northeast ;
         public location southwest ;
     }

     class location{
        public String lat ;
        public String lng ;
    }

     class address_component{
        public String long_name;
        public String short_name;
        public String[] types ;
    }
	
	public String getGoogleResponse(String address){
		String response = '';
		if(address != null && address != ''){
			String url = 'https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyDb0x2vtWX9TPH_shMVI0tfA6SVgwwDIpA&region=mx&sensor=true&address=';
			//String url = 'https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyBHhDL9rwv7zzz7wC-B4qB77r2wtyc_bKA&region=mx&sensor=true&address=';
			address = EncodingUtil.urlEncode(address, 'UTF-8');
			Http http = new Http();
			HttpRequest req = new HttpRequest();
			url = url + address.replace('null', '');
	    	req.setEndpoint(url);
	    	req.setMethod('GET');
	    	//System.debug('PETICION ' + url);
	    	HttpResponse res = http.send(req);
	    	if(res.getStatusCode() == 200){
	    		response = res.getBody();
	    	}else{
	    		System.debug('Error en el llamado a google: ' + res.getStatus() + ',' + res.getStatusCode());
	    	}
		}
		return response;
	}
	
	public void parseResponse(String jsonResponse){
		GoogleGeoCodeResponse geoDeserialized = (GoogleGeoCodeResponse) JSON.deserialize(jsonResponse, GoogleGeoCodeResponse.class);	
		String tipo = '';
		String numero = '';
		if(geoDeserialized.status == 'OK'){
			for(Integer i = 0; i < geoDeserialized.results.size(); i++){
				for(Integer j = 0; j < geoDeserialized.results[i].address_components.size(); j++){
					tipo = geoDeserialized.results[i].address_components[j].types[0];
					if(tipo == 'street_number'){
	                    numero = geoDeserialized.results[i].address_components[j].long_name;
	                }
	                if(tipo == 'neighborhood'){
	                    colonia = geoDeserialized.results[i].address_components[j].long_name;
	                }
	                if(tipo == 'postal_code'){
	                    cp = geoDeserialized.results[i].address_components[j].long_name;
	                }
	                if(tipo == 'route' || tipo == 'street_address'){
	                    calle = geoDeserialized.results[i].address_components[j].long_name + ' ' + numero;
	                }
	                if(tipo == 'locality'){
	                    municipio = geoDeserialized.results[i].address_components[j].long_name;
	                }
	                if(tipo == 'administrative_area_level_1'){
	                   estado = geoDeserialized.results[i].address_components[j].long_name;
	                }
	                if(tipo == 'administrative_area_level_2'){
	                	contenCiudad3 = contenCiudad3 + ','+ geoDeserialized.results[i].address_components[j].long_name;
	                }
	                if(tipo == 'administrative_area_level_3'){
	                	contenCiudad3 = contenCiudad3 + ','+ geoDeserialized.results[i].address_components[j].long_name;
	                }
				}
				direccionGoogle = geoDeserialized.results[i].formatted_address;
				//propiedad.Geolocalizada__c = 'Si';
			}
		}
	}
	
	public Propiedad__c parseResponse(String jsonResponse, Propiedad__c propiedad){
		GoogleGeoCodeResponse geoDeserialized = (GoogleGeoCodeResponse) JSON.deserialize(jsonResponse, GoogleGeoCodeResponse.class);	
		String tipo = '';
		String numero = '';
		if(geoDeserialized.status == 'OK'){
			for(Integer i = 0; i < 1; i++){
				for(Integer j = 0; j < geoDeserialized.results[i].address_components.size(); j++){
					tipo = geoDeserialized.results[i].address_components[j].types[0];
					if(tipo == 'street_number'){
	                    numero = geoDeserialized.results[i].address_components[j].long_name;
	                }
	                if(tipo == 'neighborhood'){
	                    propiedad.Colonia3__c = geoDeserialized.results[i].address_components[j].long_name;
	                }
	                if(tipo == 'postal_code'){
	                    propiedad.cp3__c = geoDeserialized.results[i].address_components[j].long_name;
	                }
	                if(tipo == 'route' || tipo == 'street_address'){
	                    propiedad.Calle3__c = geoDeserialized.results[i].address_components[j].long_name + ' ' + numero;
	                }
	                if(tipo == 'locality'){
	                    propiedad.Municipio3__c = geoDeserialized.results[i].address_components[j].long_name;
	                }
	                if(tipo == 'administrative_area_level_1'){
	                   propiedad.Estado3__c = geoDeserialized.results[i].address_components[j].long_name;
	                }
	                if(tipo == 'administrative_area_level_2'){
	                	if(geoDeserialized.results[i].address_components[j].long_name != null && geoDeserialized.results[i].address_components[j].long_name != 'null'){
	                		propiedad.Ciudad3__c = propiedad.Ciudad3__c + ','+ geoDeserialized.results[i].address_components[j].long_name;
	                	}
	                }
	                if(tipo == 'administrative_area_level_3'){
	                	propiedad.Ciudad3__c = propiedad.Ciudad3__c + ','+ geoDeserialized.results[i].address_components[j].long_name;
	                }
				}
				propiedad.Geolocalizada__c = '';
				propiedad.DirMaps__c = geoDeserialized.results[i].formatted_address;
				propiedad.Punto__Latitude__s = Decimal.valueOf(geoDeserialized.results[i].geometry.location.lat);
				propiedad.Punto__Longitude__s = Decimal.valueOf(geoDeserialized.results[i].geometry.location.lng);
			}
		}else if(geoDeserialized.status == 'ZERO_RESULTS'){
			propiedad.Punto__Latitude__s  = 0;
			propiedad.Punto__Longitude__s = 0;
			propiedad.DirMaps__c = '';
			propiedad.Geolocalizada__c = 'No';
		}else{
			propiedad = null;
			System.debug('Error: ' + geoDeserialized.status );
		}
		return propiedad;
	}
	
	public void procesarPropiedades(){
		sQuery = 'SELECT Id, Name, Punto__Latitude__s, Punto__Longitude__s, Calle__c, Colonia__c, Municipio__c, EstadoCompleto__c, CP__c, Geolocalizada__c, CodigoPostalBusqueda__r.CP__c ' +
				 ' FROM Propiedad__c';
		list<Propiedad__c> propiedades ;
		try{
            propiedades = Database.query(sQuery);
            for(Propiedad__c propiedad : propiedades){
            	String direccion = '';
            	if(propiedad.Geolocalizada__c == '' || propiedad.Geolocalizada__c != null){
            		propiedad.TipoGeolocalizacion__c = 'Dirección completa';
            		direccion = propiedad.Calle__c +','+ propiedad.Colonia__c + ','+ propiedad.Municipio__c + ',' + propiedad.EstadoCompleto__c +',' + propiedad.CP__c;
            	}
            }
        }catch(QueryException e){
        	propiedades = new List<Propiedad__c>();
            sQuery = e.getMessage() + ' sQuery:' + sQuery;
            System.debug(sQuery);
        } 
        
        try{
        	update propiedadesUpdate;
        }catch(Exception e){
        
        }
	}
	
}