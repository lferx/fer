global class BatchPropiedadCP implements Database.Batchable<sObject>{
	
	global final String query = 'select Id, CP__c, Colonia__c, EstadoCompleto__c, Municipio__c from Propiedad__c where CP__c=\'\' order by EstadoCompleto__c,Municipio__c,Colonia__c';
	
	global BatchPropiedadCP(){
		
	} 
	
	global BatchPropiedadCP(String q) {
		if(!q.equals('')){
			query = q;
		}
	}
	global Database.QueryLocator start(Database.BatchableContext BC){
		System.debug('buscaCPEnMunicipios start');
		return Database.getQueryLocator(query);
	}
	
	global void execute(Database.BatchableContext BC, List<Propiedad__c> scope){
		System.debug('buscaCPEnMunicipios execute');
		List<Propiedad__c> updProp = new List<Propiedad__c>();
		for(Propiedad__c p : scope){
			try{
				String estadoP = removeAcentos(removeReservedCharacters(p.EstadoCompleto__c));
				String municipioP = removeAcentos(removeReservedCharacters(p.Municipio__c));
				String coloniaP = removeAcentos(removeReservedCharacters(p.Colonia__c));
				
				String qString ='';
				if(!String.isEmpty(estadoP)){
					if(!String.isEmpty(coloniaP)){
						qString = estadoP+ '* AND ' + coloniaP + '*';
					}
				}
				//El estado es requerido para la busqueda
			
				if(qString!=''){
					List<CodigoPostal__c> valMunicipio = new List<CodigoPostal__c>();
					System.debug(qString);
					List<List<SObject>> searchResults = [FIND :qString IN ALL FIELDS RETURNING CodigoPostal__c(Id, Name, CP__c, Colonia__c, Municipio__c, Estado__c)];
					System.debug(p);
					
					if(searchResults[0].size()==1){
						CodigoPostal__c cp = (CodigoPostal__c)searchResults[0].get(0);
						p.CP__c = (''+cp.CP__c).removeEnd('.0');
						p.CPBusqueda__c=cp.Id;
						p.CPEstatusBusqueda__c='Estado y Colonia';
						updProp.add(p);
						continue;
					}else{
						for(SOBject record : searchResults[0]) {
							if(record != null) {
								System.debug(record);
								CodigoPostal__c cp = (CodigoPostal__c)record;
								if(removeAcentos(removeReservedCharacters(cp.Estado__c)).equals(estadoP)){
									System.debug('Estado igual');
									String coloniaCP = removeAcentos(removeReservedCharacters(cp.Colonia__c));
									if(coloniaCP.equals(coloniaP)){
										System.debug('Colonia igual');
										p.CP__c = (''+cp.CP__c).removeEnd('.0');
										p.CPBusqueda__c=cp.Id;
										p.CPEstatusBusqueda__c='Estado, Municipio y Colonia';
										updProp.add(p);
										break;
									}else if(coloniaP.contains(coloniaCP)){
										System.debug('Contiene colonia');
										valMunicipio.add(cp);
									}else if(coloniaCP.contains(coloniaP)){
										System.debug('Contiene colonia el cp');
										valMunicipio.add(cp);
									}
								}else{
									System.debug('ERROR Debe coincidir el estado');
									//Debe coincidir el estado
								}
							}					
						}
					}
					
					if(valMunicipio.size()>0 && (p.CP__c==null || ''.equals(p.CP__c))){
						System.debug(valMunicipio);
						for(CodigoPostal__c cp : valMunicipio){
							System.debug(cp);
							String munCP = removeAcentos(removeReservedCharacters(cp.Municipio__c));
							if(munCP.equals(municipioP)){
								System.debug('Mismo Municipio cp');
								p.CP__c = (''+cp.CP__c).removeEnd('.0');
								p.CPBusqueda__c=cp.Id;
								p.CPEstatusBusqueda__c='Estado, Municipio y Colonia parcial';
								updProp.add(p);
								break;
                            }else if(municipioP.equals(munCP)){
								System.debug('Mismo Municipio prop');
								p.CP__c = (''+cp.CP__c).removeEnd('.0');
								p.CPBusqueda__c=cp.Id;
								p.CPEstatusBusqueda__c='Estado, Municipio y Colonia parcial';
								updProp.add(p);
								break;
                            }
						}
						
						System.debug(p.CP__c);
						if(p.CP__c==null || ''.equals(p.CP__c)){
							p.CP__c=(''+valMunicipio.get(0).CP__c).removeEnd('.0');
							p.CPBusqueda__c=valMunicipio.get(0).Id;
							p.CPEstatusBusqueda__c='Estado, Municipio parcial y Colonia parcial';
							updProp.add(p);
							continue;
						}
					}
				}
			}catch(Exception e){
				System.debug(e);
			}
		}
		//System.debug(updProp);
		if(updProp.size()>0){
			update updProp;
		}
	}
	
	global String removeReservedCharacters(String s){
		if(!String.isEmpty(s)){
			return s.toLowerCase()
			.replace(';',' ')
			.replace('?',' ')
			.replace('&',' ')
			.replace('|',' ')
			.replace('!',' ')
			.replace('{',' ')
			.replace('}',' ')
			.replace('[',' ')
			.replace(']',' ')
			.replace('(',' ')
			.replace(')',' ')
			.replace('^',' ')
			.replace('~',' ')
			.replace('*',' ')
			.replace(':',' ')
			.replace('\\',' ')
			.replace('"',' ')
			.replace('\'',' ')
			.replace('+',' ')
			.replace('-',' ');
		}else{
			return s;
		}
	}
	global String removeAcentos(String s){
		if(!String.isEmpty(s)){
			return s.toLowerCase()
			.replace('á','a')
			.replace('é','e')
			.replace('í','i')
			.replace('ó','o')
			.replace('ú','u');
		}else{
			return s;
		}
	}
	
	global void finish(Database.BatchableContext BC){
		System.debug('buscaCPEnMunicipios finish');
	}
}