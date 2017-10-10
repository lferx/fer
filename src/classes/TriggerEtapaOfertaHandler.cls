public class TriggerEtapaOfertaHandler extends TriggerTemplate.Handler {
    /**CONSTRUCTOR*/
    private TriggerEtapaOfertaHandler() {
        this.add(new BeforeInsertLogic());
    }
    
    private class BeforeInsertLogic extends LogicUnit implements BeforeInsert {
    	//Before Insert
	    public void execute(final List<EtapaOferta__c> sObjectsList) {
	    	cargaDocsFaltantes(sObjectsList);
	    }
	    
	    private void cargaDocsFaltantes(List<EtapaOferta__c> sObjectsList){
	    	for(EtapaOferta__c eOferta : sObjectsList){
	    		if(Constants.MAP_DOCUMENTOS_ETAPA.containsKey(eOferta.Etapa__c)){
	    			String documentosFaltantes = '';
	    			for(DocumentoEtapa__c doc : Constants.MAP_DOCUMENTOS_ETAPA.get(eOferta.Etapa__c).values()){
	    				documentosFaltantes += doc.NombreUsuario__c+';';
	    			}
	    			eOferta.DocumentosFaltantes__c = documentosFaltantes;
	    		}
	    	}
	    }
    }
}