public with sharing class PublicacionPropiedadController {
	public Propiedad__c propiedad {get;set;}
	public List<Oferta__c> listaOfertas {get;set;}
	public List<Documento__c> listaDocumentos {get;set;}
	public List<AttachmentWrapper> listaAttachments {get;set;}
	
	//public List<FotoWeb__c> listaFotosWeb {get;set;}
	
	public PublicacionPropiedadController(){
		String propiedadId = ApexPages.currentPage().getParameters().get('Id');
		propiedad = [Select Id From Propiedad__c Where Id =: propiedadId];
		listaOfertas = [Select Id From Oferta__c Where propiedad__c =: propiedadId];
		listaDocumentos = [Select Id, (Select Id From Attachments) From Documento__c Where Oferta__c IN: listaOfertas AND Tipo__c = 'Fotografia'];
		//listaFotosWeb = [Select Id, (Select Id From Attachments) From FotoWeb__c Where propiedad__c =: propiedadId];
		listaAttachments= new List<AttachmentWrapper>();
		for(Documento__c doc : listaDocumentos){
			for(Attachment attachDoc : doc.Attachments){
				AttachmentWrapper attachWrapper = new AttachmentWrapper();
				attachWrapper.attach = attachDoc;
				attachWrapper.seleccionado = false;
				listaAttachments.add(attachWrapper);
			}
			
		}
	}
	
	public class AttachmentWrapper{
		public Attachment attach {get;set;}
		public Boolean seleccionado {get;set;}
	}
}