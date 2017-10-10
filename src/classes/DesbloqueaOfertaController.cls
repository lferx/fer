public with sharing class DesbloqueaOfertaController {
    public String sIdDocSeleccionado {get;set;}
    public String sComentario {get; set;}
    public String retURL {get;set;}
    public list<Documento__c> ldocup {get;set;}
    ApexPages.StandardController sController; 
    public DesbloqueaOfertaController(ApexPages.Standardcontroller controlador){
        
        sController = controlador;
        sIdDocSeleccionado = controlador.getId(); 
        
        retURL = ApexPages.currentPage().getParameters().get('retURL');
        
        
    }
    
}