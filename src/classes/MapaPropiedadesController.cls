public with sharing class MapaPropiedadesController {

	public String baseQuery = 'SELECT ID, Name,Plaza__c,Geolocalizada__c, CalidadGeo_Manual__c, ComentariosGeo__c FROM Propiedad__c ORDER BY NAME ASC LIMIT 5000';
	public String propieadFilterId
	{
	   get
	    {
	       if(propieadFilterId == null){
	           propieadFilterId = (String)ApexPages.currentPage().getParameters().get('fcf');
	           propieadFilterId = propieadFilterId == null ? '00Bi0000004XY9FEAW' : propieadFilterId;
	           if(propieadFilterId.length() == 15){
	           	propieadFilterId = convertId(propieadFilterId	);
	           }
	       }
	       return propieadFilterId;
	    }
	set;
	}
	 public String idPropiedad {get;set;}
	 public Propiedad__c  propiedad {get;set;}
	 public List<SelectOption> direcciones {get;set;}
	 
	 public String calle {get;set;}
	 public String colonia {get;set;}
	 public String municipio {get;set;}
	 public String estado {get;set;}
	 public String cp {get;set;}
	 public String lote {get;set;}
	 public String manzana {get;set;}
	  
	 private Integer pageSize = 22;
	 public String namePropiedad {get;set;}
	 
	 public MapaPropiedadesController(){
	 	propieadFilterId = null;
	 	idPropiedad = (String)ApexPages.currentPage().getParameters().get('idp');
        namePropiedad = (String)ApexPages.currentPage().getParameters().get('name');
        cargarPropiedad();
	 }
	 public MapaPropiedadesController(ApexPages.StandardSetController c){
	 }
  
	 public SelectOption[] getPropiedadExistingViews(){
	     return PropiedadSetController.getListViewOptions();
	 }
	 
	 public List<Propiedad__c> getPropiedades(){
	     return (List<Propiedad__c>)PropiedadSetController.getRecords();
	 }
	    
	 public PageReference resetFilter(){
	     PropiedadSetController = null;
	     PropiedadSetController.setPageNumber(1);	
	     return null;
	 }
	
	public void firstPage(){
	  PropiedadSetController.first();
	}
	
	public void lastPage(){
	  PropiedadSetController.last();
	}
	
	public void next(){
	  if(PropiedadSetController.getHasNext()){
	    PropiedadSetController.next();
	  }
	}
	
	public void prev(){
	  if(PropiedadSetController.getHasPrevious()){
	    PropiedadSetController.previous();
	  }
	}
		 
	 
	public ApexPages.StandardSetController PropiedadSetController {
	 	 get{
	 	 	if(PropiedadSetController == null){
	 	 		PropiedadSetController = new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery));
	 	 		PropiedadSetController.setPageSize(pageSize);
	 	 		if(propieadFilterId != null){
	 	 			 PropiedadSetController.setFilterId(propieadFilterId);
	 	 		}
	 	 	}
	 	 	return PropiedadSetController;
	 	 }
	 	 set;
	 }
		
	
	
	public void cargarPropiedad(){
		if(idPropiedad != null && idPropiedad != ''){
				propiedad = [SELECT Id,Name,Plaza__c,Lote__c,Manzana__c,Estado__c,Estado2__c,EstadoCompleto__c,Municipio__c,Municipio2__c,Colonia__c,Colonia2__c,Calle__c,Calle2__c,CP__c,CP2__c,
								ValorCompra__c,ValorReferencia__c, Tipo__c,Punto__c,Punto__Latitude__s,Punto__Longitude__s,Geolocalizada__c, TipoGeolocalizacion__c, CalidadGeo_Manual__c, ComentariosGeo__c
								FROM Propiedad__c WHERE Id =: idPropiedad];
		}else if(namePropiedad != null && namePropiedad != ''){
				propiedad = [SELECT Id,Name,Plaza__c,Lote__c,Manzana__c,Estado__c,Estado2__c,EstadoCompleto__c,Municipio__c,Municipio2__c,Colonia__c,Colonia2__c,Calle__c,Calle2__c,CP__c,CP2__c,
								ValorCompra__c,ValorReferencia__c, Tipo__c,Punto__c,Punto__Latitude__s,Punto__Longitude__s,Geolocalizada__c, TipoGeolocalizacion__c, CalidadGeo_Manual__c, ComentariosGeo__c
								FROM Propiedad__c WHERE Name =: namePropiedad];
		}
		if(propiedad!=null){
			calle = removeReservedCharacters(propiedad.Calle__c);
            colonia = removeReservedCharacters(propiedad.Colonia__c);
            municipio = removeReservedCharacters(propiedad.Municipio__c);
            estado = removeReservedCharacters(propiedad.EstadoCompleto__c);
            lote = removeReservedCharacters(propiedad.Lote__c);
            manzana = removeReservedCharacters(propiedad.Manzana__c);
            if(String.isBlank(propiedad.CP__c))
                cp = obtenerCP(propiedad.Calle__c);
            else
                cp = propiedad.CP__c;
            calle = calle.replace(cp, '');
		}else{
			calle='';
			colonia='';
			municipio='';
			estado='';
			cp='';
			lote='';
			manzana='';
			propiedad = new Propiedad__c();
		}
	}
	public void guardar(){
		try{
			if(propiedad.Punto__Latitude__s != null){
				propiedad.Geolocalizada__c = 'Si';
                propiedad.TipoGeolocalizacion__c = 'Manual';
			}
			upsert propiedad;
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Registro guardado'));
		}catch(Exception e){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,e.getMessage()));
		}
	}
	
	private  String convertId(String inputId){
        string suffix = '';
        integer flags;
        try{
            for (integer i = 0; i < 3; i++) {
                flags = 0;
                for (integer j = 0; j < 5; j++) {
                    string c = inputId.substring(i * 5 + j,i * 5 + j + 1);
                    if (c.toUpperCase().equals(c) && c >= 'A' && c <= 'Z') {
                        flags = flags + (1 << j);
                    }
                }
                if (flags <= 25) {
                    suffix += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.substring(flags,flags+1);
                }else{
                    suffix += '012345'.substring(flags - 26, flags-25);
                }
            }
        }
        catch(Exception exc){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Por favor ingresar un id valido'));
        }
        String outputId = inputId+suffix;
        return outputId;
    }

	
	private String obtenerCP(String calle){
		String tmpCP = '';
		if(calle.length()>=5){
			for(integer i=0 ; i < (calle.length()-4) ; i++){
				tmpCP = calle.substring(i, i+5);
				Integer fNaN = 0;
				for(integer j = 0 ; j < tmpCP.length() ; j++){
					String s = tmpCP.substring(j, j+1);
					if(s.isNumeric()==false){
						fNaN = 1;
						break;
					}
				}
				if(fNaN==0){
					break;
				}
			}
		}
		Pattern isnumbers = Pattern.Compile('^[0-9]+$');
		Matcher postalMatch = isnumbers.matcher(tmpCP);
		if(!postalMatch.Matches()){
			tmpCP = '';
		}
		return tmpCP;
	}
    
    
    private String removeReservedCharacters(String s){
    	try{
	        return s.replace(';',' ')
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
	        .replace('-',' ')
	        .replace('#',' ')
	        .replace('  ',' ');
    	}catch(Exception e){
    		System.debug(e);
    		return '';
    	}
    }
	 
}