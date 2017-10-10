public class TriggerDocumentoHandler extends TriggerTemplate.Handler {

    /**CONSTRUCTOR*/
    private TriggerDocumentoHandler() {
        this.add(new AfterInsertUpdateDeleteUndeleteLogic());
    }
    
    private class AfterInsertUpdateDeleteUndeleteLogic extends LogicUnit implements AfterInsert, AfterUpdate, AfterDelete, AfterUndelete {
    	//After Insert, delete and undelete
	    public void execute(final List<Documento__c> sObjectsList, final Map<Id, SObject> sObjectsMap) {
	        List<EtapaOferta__c> parts = this.getEtapas4Update(sObjectsList);
	    	if(parts.size()>0){
                update parts;
	    	}
	    }
	    //After update
	    public void execute(final List<Documento__c> oldSObjects, final Map<Id, SObject> oldSObjectsMap,
	                        final List<Documento__c> newSObjects, final Map<Id, SObject> newSObjectsMap) {
	    	this.execute(newSObjects, newSObjectsMap);
	    }
	    
	    public List<EtapaOferta__c> getEtapas4Update(final List<Documento__c> listDetails){
	    	List<EtapaOferta__c> listEtapaOferta = new List<EtapaOferta__c>();
	    	Map<EtapaOferta__c, Map<String, Documento__c>> documentosEtapaMap = new Map<EtapaOferta__c, Map<String, Documento__c>>();
	        Set<Id> setParents = new Set<Id>();
	        for(Documento__c item : listDetails){
	            if(item.EtapaOferta__c != null){
	            	setParents.add(item.EtapaOferta__c);
	            }
	        }
	        if(setParents.size()>0){
	            for(Documento__c doc : [Select Id, EtapaOferta__r.Id, EtapaOferta__r.Etapa__c, EtapaOferta__c, DocumentoEtapa__c, DocumentoEtapa__r.Name From Documento__c Where EtapaOferta__c IN: setParents]){
	            	EtapaOferta__c etapaOferta = doc.EtapaOferta__r; 
	            	if(!documentosEtapaMap.containsKey(etapaOferta)){
	            		documentosEtapaMap.put(etapaOferta, new Map<String, Documento__c>());
	            	}
	            	documentosEtapaMap.get(etapaOferta).put(doc.DocumentoEtapa__c, doc);
	            }
	            for(EtapaOferta__c etapaOferta : documentosEtapaMap.keySet()){
	            	String documentosFaltantes = '';
	            	for(DocumentoEtapa__c docEtapa : Constants.MAP_DOCUMENTOS_ETAPA.get(etapaOferta.Etapa__c).values()){
	            		if(!documentosEtapaMap.get(etapaOferta).containsKey(docEtapa.Id)){
	            			documentosFaltantes += docEtapa.NombreUsuario__c + ';';
	            		}	
	            	}
	            	etapaOferta.DocumentosFaltantes__c = documentosFaltantes;
	            	listEtapaOferta.add(etapaOferta);
	            }
	        }
	        return listEtapaOferta;
	    }
    }
}