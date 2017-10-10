public with sharing class ComentariosDocumentoController {
	 public list<ComentarioDocumento__c> listaComentarios{get;set;}
	 private string doccom;
     public ComentariosDocumentoController(ApexPages.StandardController stdController)
     {
     	doccom = ApexPages.currentPage().getParameters().get('ido');
     	listaComentarios = [SELECT Comentario__c, Fecha_Comentario__c, CreatedBy.Name FROM ComentarioDocumento__c WHERE Documento__c = : doccom];
     }
     
     
}