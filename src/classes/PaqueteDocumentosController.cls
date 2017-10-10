public with sharing class PaqueteDocumentosController {
	
	private Paquete__c paquete {get;set;}
	//public list<DocumentoPaquete__c> conjuntoDocumentos {get;set;}
	public list<Documento> listaDocumentos {get;set;}
	public list<Documento__c> documentosPaquete {get;set;}
	public String subIndex {get;set;}
	public String mensajeError {get;set;}
	public map<String,wrapDocumento> mapaDocumentos{get;set;}
	
	public class Documento{
		public Documento__c documento{get;set;}
		public Attachment archivo {get;set;}
		
		public Documento(Documento__c doc, Attachment archi ){
			documento = doc;
			archivo = archi;
		}
	}
	
	public class WrapDocumento{
		public list<Documento> documentos{get;set;}
		public wrapDocumento(){
			documentos = new list<Documento>();
		}
		
		public integer getSizeDocumentos(){
			return documentos.size();
		}
	}
	
	public PaqueteDocumentosController(){
		
	}
	public PaqueteDocumentosController(ApexPages.StandardController controller){
		//conjuntoDocumentos = new list<DocumentoPaquete__c>();
		listaDocumentos = new list<Documento>();
		mapaDocumentos = new map<String,wrapDocumento>();
		paquete = [SELECT id, Name, Etapa__c FROM Paquete__c WHERE Id =: controller.getId()];
		//conjuntoDocumentos = [SELECT id,Name, Etapa__c,Etapa__r.Name, Activo__c FROM  DocumentoPaquete__c WHERE Activo__c = true];
		cargarDocumentos();
	}
	
	public  void cargarDocumentos(){
		mapaDocumentos.clear();
		listaDocumentos = new list<Documento>();
		Map<String, DocumentosPaquete__c> mapDocumentos = DocumentosPaquete__c.getAll();
		
		for(String dp: mapDocumentos.keySet()){
			if(!mapaDocumentos.containsKey(dp)){
				if(mapDocumentos.get(dp).Activo__c){
					mapaDocumentos.put(dp, new WrapDocumento());
				}
			}
		}
		
		documentosPaquete = [SELECT id,Name from Documento__c WHERE Paquete__c =: paquete.Id];
		for(Documento__c doc:documentosPaquete){
				for(Attachment att: [SELECT id,ParentId,Name,Description FROM Attachment Where ParentId =: doc.id]){
					mapaDocumentos.get(doc.Name).documentos.add(new Documento(doc,att));
					listaDocumentos.add(new Documento(doc,att));
			}
		}
	}
	
	public void delDocumento(){ 
		Documento documento = listaDocumentos.get(Integer.valueOf(subIndex));
		try{
			//Si es el ultimo archivo del documento, se elimina el documento caso contrario solo el archivo adjunto
			list<Attachment> adjuntos = [SELECT id FROM Attachment Where ParentId =: documento.documento.Id];
			if(adjuntos.size() ==1 ){
				delete documento.documento;
			}else{ 
				delete documento.archivo;
			}
		}catch(Exception e){
			mensajeError = e.getMessage();
			ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error,mensajeError );
			ApexPages.addMessage(msg);
		}
		cargarDocumentos();
		subIndex = null;
	}
}