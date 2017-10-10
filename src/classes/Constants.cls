global without sharing class Constants {
	/*Mapa de los tipos de registro existentes en el sistema*/
    /*
		*	Key		-	DeveloperName del tipo de registro
		*	Value	-	Instancia del tipo de registro 
	*/
    global static map<String,RecordType> MAP_RECORDTYPES_DEVNAME {
    	get {
    		if(MAP_RECORDTYPES_DEVNAME == null) {
    			MAP_RECORDTYPES_DEVNAME = new map<string,RecordType>();
    			for(RecordType recordType : [Select Id, DeveloperName, Name, SobjectType From RecordType]) {
    				MAP_RECORDTYPES_DEVNAME.put(recordType.DeveloperName,recordType);
    			}
    		}
    		return MAP_RECORDTYPES_DEVNAME;
    	}
    	private set;
    }
    
    /*Mapa de los tipos de registro existentes en el sistema*/
    /*
		*	Key		-	Id del tipo de registro
		*	Value	-	Instancia del tipo de registro 
	*/
    global static map<String,RecordType> MAP_RECORDTYPES_ID {
    	get {
    		if(MAP_RECORDTYPES_ID == null) {
    			MAP_RECORDTYPES_ID = new map<string,RecordType>();
    			for(RecordType recordType : [Select Id, DeveloperName, Name, SobjectType From RecordType]) {
    				MAP_RECORDTYPES_ID.put(recordType.Id,recordType);
    			}
    		}
    		return MAP_RECORDTYPES_ID;
    	}
    	private set;
    }
    
    global final static string INVERSOR_PROFILE_ID = '00ei0000000gaTpAAI';
    
    global final static string INVERSORFF_PROFILE_ID = '00ei0000001JIJ1AAO';
    
    public static Map<String,Map<String,DocumentoEtapa__c>> MAP_DOCUMENTOS_ETAPA {
    	get{
	    	if(MAP_DOCUMENTOS_ETAPA == null){
	    		MAP_DOCUMENTOS_ETAPA = new Map<String,Map<String,DocumentoEtapa__c>>();
	    		for(DocumentoEtapa__c doc : [Select Id, Etapa__c, Name, NombreUsuario__c, Obligatorio__c From DocumentoEtapa__c]){
	    			if(!MAP_DOCUMENTOS_ETAPA.containsKey(doc.Etapa__c)){
	    				MAP_DOCUMENTOS_ETAPA.put(doc.Etapa__c, new Map<String, DocumentoEtapa__c>());
	    			}
	    			MAP_DOCUMENTOS_ETAPA.get(doc.Etapa__c).put(doc.Id,doc);
	    		}
	    	}
	    	return MAP_DOCUMENTOS_ETAPA;
	    }
	    private set;
    }
}