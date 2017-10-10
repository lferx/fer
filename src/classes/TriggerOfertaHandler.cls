public with sharing class TriggerOfertaHandler extends TriggerTemplate.Handler {
 
    /**CONSTRUCTOR*/
    private TriggerOfertaHandler() {
        this.add(new AfterInsertUpdateLogic());
    }

    /**LOGIC UNITS*/
    //INSERT
    private class AfterInsertUpdateLogic extends LogicUnit implements AfterInsert, AfterUpdate {
    	public List<SObject> newList;
    	public List<SObject> oldList;
    	public Map<Id, SObject> newMap;
    	public Map<Id, SObject> oldMap;
    	
    	//Before insert constructor
    	public void execute(final List<SObject> newSObjects, final Map<Id, SObject> newSObjectsMap){
            newList = newSObjects;
            newMap = newSObjectsMap;
            
            TriggerOfertaHandler.asignaUltimaOferta(newSObjectsMap.keySet());
        }
        
    	public void execute(final List<SObject> oldSObjects, final Map<Id, SObject> oldSObjectsMap,
                            final List<SObject> newSObjects, final Map<Id, SObject> newSObjectsMap){
            newList = newSObjects;
            oldList = oldSObjects;
            newMap = newSObjectsMap;
            oldMap = oldSObjectsMap;
            
            creaColaboracionManual(newList);
            eliminaColaboracionManual(newList, oldSObjectsMap);
        }
        
        
        
        private void creaColaboracionManual(List<SObject> listaOfertas){
        	List<Oferta__Share> lColaboracion = new List<Oferta__Share>();
	        List<Documento__Share> lColaboracionDocs = new List<Documento__Share>();
	        List<EtapaOferta__Share> lColaboracionEtapaOferta = new List<EtapaOferta__Share>();
	        
	        Set<String> setOfertas = new Set<String>(); 
	        for(SObject item : listaOfertas){
	        	Oferta__c p = (Oferta__c)item;
	            if(p.InversorId__c != null){
	                setOfertas.add(p.Id);
	                lColaboracion.add(new Oferta__Share(
	                    UserOrGroupId = p.InversorId__c,
	                    ParentId = p.Id,
	                    AccessLevel = 'Read'
	                ));
	            }
	        }
	        
	        for(EtapaOferta__c etapaOferta : [Select Id, Oferta__c, Oferta__r.Inversor__r.UsuarioInversor__c From EtapaOferta__c Where Oferta__c IN: setOfertas AND Oferta__r.Inversor__r.UsuarioInversor__c != null]){
	            lColaboracionEtapaOferta.add(new EtapaOferta__Share(
	                UserOrGroupId = etapaOferta.Oferta__r.Inversor__r.UsuarioInversor__c,
	                ParentId = etapaOferta.Id,
	                AccessLevel = 'Read'
	            ));
	        }
	        
	        for(Documento__c doc : [Select Id, Oferta__c, Oferta__r.Inversor__r.UsuarioInversor__c From Documento__c Where Oferta__c IN: setOfertas AND Oferta__r.Inversor__r.UsuarioInversor__c != null]){
	            lColaboracionDocs.add(new Documento__Share(
	                UserOrGroupId = doc.Oferta__r.Inversor__r.UsuarioInversor__c,
	                ParentId = doc.Id,
	                AccessLevel = 'Read'
	            ));
	        }
	        
	        if(lColaboracion != null && lColaboracion.size() > 0){
	            insert lColaboracion;
	        }
	        if(lColaboracionEtapaOferta != null && lColaboracionEtapaOferta.size() > 0){
	            insert lColaboracionEtapaOferta;
	        }
	        if(lColaboracionDocs != null && lColaboracionDocs.size() > 0){
	            insert lColaboracionDocs;
	        }
        }
        
        private void eliminaColaboracionManual(List<SObject> listaOfertas, Map<Id, SObject> mapaOfertasOld){
        	Map<String,String> mapaInversorOferta = new Map<String,String>();
        	for(SObject item : listaOfertas){
        		Oferta__c p = (Oferta__c)item;
        		Oferta__c pOld = (Oferta__c)mapaOfertasOld.get(p.Id);
	            if(p.InversorId__c != pOld.InversorId__c && pOld.InversorId__c != null){
	                mapaInversorOferta.put(p.Id, pOld.InversorId__c);
	            }
	        }
	        if(mapaInversorOferta.size() > 0){ 
	            List<Oferta__Share> itemsDelete = new List<Oferta__Share>();
	            for(Oferta__Share p : [Select Id, UserOrGroupId, ParentId From Oferta__Share Where RowCause = 'Manual' AND ParentId IN: mapaInversorOferta.keySet()]){
	                if(mapaInversorOferta.get(p.ParentId) == p.UserOrGroupId){
	                    itemsDelete.add(p);
	                }
	            }
	            delete itemsDelete;
	            
	            List<EtapaOferta__Share> itemsDeleteEtapasOferta = new List<EtapaOferta__Share>();
	            for(EtapaOferta__Share p : [Select Id, UserOrGroupId, ParentId, Parent.Oferta__c From EtapaOferta__Share Where RowCause = 'Manual' AND Parent.Oferta__c IN: mapaInversorOferta.keySet()]){
	                if(mapaInversorOferta.get(p.Parent.Oferta__c) == p.UserOrGroupId){
	                    itemsDeleteEtapasOferta.add(p);
	                }
	            }
	            delete itemsDeleteEtapasOferta;
	            
	            List<Documento__Share> itemsDeleteDocs = new List<Documento__Share>();
	            for(Documento__Share p : [Select Id, UserOrGroupId, ParentId, Parent.Oferta__c From Documento__Share Where RowCause = 'Manual' AND Parent.Oferta__c IN: mapaInversorOferta.keySet()]){
	                if(mapaInversorOferta.get(p.Parent.Oferta__c) == p.UserOrGroupId){
	                    itemsDeleteDocs.add(p);
	                }
	            }
	            delete itemsDeleteDocs;
	        }
        }
        
        
    }
    
    @future
    public static void asignaUltimaOferta(Set<Id> setOfertasId){
    	Map<Id,Propiedad__c> mapPropiedades;
		set<String> ids = new set<String>();
		
		List<Oferta__c> listaOfertas = [Select Id, Propiedad__c From Oferta__c Where Id IN: setOfertasId];
		for(Oferta__c oferta : listaOfertas){
			ids.add(oferta.Propiedad__c);
		}
		
		mapPropiedades = new Map<Id,Propiedad__c>([Select Id, Oferta__c From Propiedad__c Where Id IN: ids]);
    	
    	for(Oferta__c oferta : listaOfertas){
        	if(mapPropiedades.containsKey(oferta.Propiedad__c)){
        		Propiedad__c p = mapPropiedades.get(oferta.Propiedad__c);
        		p.Oferta__c = oferta.Id;
        	}
        }
        
        update mapPropiedades.values();
    }
}