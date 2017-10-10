public with sharing class ModCierreController {
	public String sIdDocSeleccionado {get;set;}
    public String sComentario {get; set;}
    public String retURL {get;set;}
    public list<Documento__c> ldocup {get;set;}
    ApexPages.StandardController sController; 
    public ModCierreController(ApexPages.Standardcontroller controlador){
        
        sController = controlador;
        sIdDocSeleccionado = controlador.getId(); 
        
        retURL = ApexPages.currentPage().getParameters().get('retURL');
        
        
    }
    public PageReference salvar()
    {
    	PageReference pr = sController.save();
    	DateTime dt = system.now();
    	ComentarioDocumento__c comdoc = new ComentarioDocumento__c();
    	comdoc.Documento__c = sIdDocSeleccionado;
    	comdoc.Comentario__c = sComentario;
    	comdoc.Fecha_Comentario__c = dt;
    	upsert comdoc; 
    	
    	return null;
    }

}