public with sharing class CargaDocumentosController {
	public String idParent {get;set;}
	public String campoRelacion {get;set;}
	public String tipo{get;set;}
	//AQUI INICIA EL CAMBIO
	public String Beneficiario{get; set;}
	public String NSS{get; set;}
	public String RFC{get; set;}
	public String Tel{get; set;}
	public String NombreBanco{get; set;}
	public String Cuenta{get; set;}
	public String TipodePersona{get; set;}
	public String CLABE{get; set;}
	public String clientefinal2{get; set;}
	public String Nombre{get; set;}
	public String CURP{get; set;}
	//AQUI FINALIZA EL CAMBIO
	
	public list<Documento> listaDocumentos {get;set;}
	public list<Documento__c> documentosActuales {get;set;}
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
	
	public CargaDocumentosController(){
		listaDocumentos = new list<Documento>();
		mapaDocumentos = new map<String,wrapDocumento>();
	}
	
	public CargaDocumentosController(ApexPages.StandardController controller){
		listaDocumentos = new list<Documento>();
		mapaDocumentos = new map<String,wrapDocumento>();
		cargarDocumentos();
		cargardatos();
	}
	
	public void getStartComponent(){
		if(idParent != null && campoRelacion != null && tipo != null){
			cargarDocumentos();
			cargardatos();
		}
	}
	
	public  void cargarDocumentos(){
		mapaDocumentos.clear();
		listaDocumentos = new list<Documento>();
		Map<String, DocumentosPaquete__c> mapDocumentos = DocumentosPaquete__c.getAll();
		
		for(String dp: mapDocumentos.keySet()){
			if(!mapaDocumentos.containsKey(dp)){
				if(mapDocumentos.get(dp).Activo__c && mapDocumentos.get(dp).Tipo__c == tipo){
					mapaDocumentos.put(dp, new WrapDocumento());
				}
			}
		}
		
		String whereClause = ' ' + campoRelacion + ' = \'' + idParent + '\''; 
		String soql = Utils.getCreatableFieldsSOQL('Documento__c', whereClause, true);
		system.debug('soql:' + soql);
		system.debug('mapDocumentos: ' + mapDocumentos);
		documentosActuales = Database.query(soql);
		
		for(Documento__c doc:documentosActuales){
			for(Attachment att: [SELECT id,ParentId,Name,Description FROM Attachment Where ParentId =: doc.id]){
				if(mapaDocumentos.containsKey(doc.Name)){
					mapaDocumentos.get(doc.Name).documentos.add(new Documento(doc,att));
					listaDocumentos.add(new Documento(doc,att));
				} 
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
	public void cargardatos(){
		try{
	 	
			Account a = new Account();
			a= [SELECT Banco__c,Name,CURP__c,RFC__c,Beneficiario__c,CLABE__c,Phone,Numero_de_Seguro_Social__c,Cuenta_bancaria__c,Id,TipoPersona__c FROM Account WHERE Id =:clientefinal2];
			NombreBanco=a.Banco__c==''? '':a.Banco__c;
			Beneficiario=a.Beneficiario__c==''?'':a.Beneficiario__c;
			CLABE=a.CLABE__c==''?'':a.CLABE__c;
			Cuenta=a.Cuenta_bancaria__c==''?'':a.Cuenta_bancaria__c;
			TipodePersona=a.TipoPersona__c==''?'':a.TipoPersona__c;
			NSS=a.Numero_de_Seguro_Social__c==''?'':a.Numero_de_Seguro_Social__c;
			tel=a.Phone==''?'':a.Phone;
			CURP=a.CURP__c==''?'':a.CURP__c;
			RFC=a.RFC__c==''?'':a.RFC__c;
			
			
		}catch(exception x){
			
		}
	}
	
	public PageReference guardarDatos(){
		system.debug('QUe pedo');
		try{
	 	if(NombreBanco!=''&&Beneficiario!= ''&&CLABE !=''&&Cuenta!=''&&TipodePersona!=''){
			Account a = new Account();
			a= [SELECT Banco__c,Name,CURP__c,RFC__c,Beneficiario__c,CLABE__c,Phone,Numero_de_Seguro_Social__c,Cuenta_bancaria__c,Id,TipoPersona__c FROM Account WHERE Id =:clientefinal2];
			a.Banco__c = NombreBanco;
			a.Beneficiario__c=Beneficiario;
			a.CLABE__c= CLABE;
			a.Cuenta_bancaria__c= Cuenta;
			a.TipoPersona__c= TipodePersona;
			a.Numero_de_Seguro_Social__c=NSS;
			a.Phone=tel;
			a.CURP__c=CURP;
			a.RFC__c=RFC;
			PageReference pageRef= new PageReference('/a08/o');
            pageRef.setredirect(false);
             
			system.debug('El nombre'+a.Name+' el nombre es '+nombre);
			if(a.Name==nombre){
				update a;
				system.debug('funciono');
				
			}}
			else{
				ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Se ha producido un en el cliente final');
				system.debug('fallo');
            ApexPages.addMessage(errormsg);
			}		
			return null;
		}catch(exception x){
			ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Se ha producido un error actualizar los datos');
            ApexPages.addMessage(errormsg);
            return null;
		}
	} 
	
	public static testMethod void testCargaDocs() {
		Propiedad__c p = new Propiedad__c();
		p.Name = 'TEST01';
		p.GeneraOferta__c = true;
		insert p;
		    Account lstAccount = new Account();
		    lstAccount.Name='asdad';
		    lstAccount.Email__c='juan@juan.com';
		    lstAccount.Numero_de_Seguro_Social__c='234324324';
		    lstAccount.Plaza__c='Puebla';
		    insert lstAccount;
		Oferta__c oferta = [Select Id, Name, Propiedad__c From Oferta__c Where Propiedad__c =: p.Id];
		Documento__c doc = new Documento__c();
		doc.Tipo__c = 'TEST';
		doc.Oferta__c = oferta.Id;
		doc.Name = 'IFE';
		insert doc;
		Attachment attach = new Attachment();
    	attach.Name = 'Nuevo';
    	attach.ParentId = doc.Id;
    	attach.Body = Blob.valueOf('body');
    	insert attach;
    	DocumentosPaquete__c setting = new DocumentosPaquete__c();
		setting.Name = 'IFE';
		setting.Activo__c = true;
		setting.Tipo__c = 'TEST';
		insert setting;
		Test.startTest();
		CargaDocumentosController carga = new CargaDocumentosController();
		carga.clientefinal2=(String)lstAccount.id;
			carga.cargardatos();
		    carga.Nombre=lstAccount.Name;
		    carga.guardarDatos();
		carga.idParent = oferta.Id;
		carga.tipo = 'TEST';
		carga.campoRelacion = 'Oferta__c';
		carga.getStartComponent();
		carga.subIndex = '0';
		carga.delDocumento();
		Test.stopTest();
		System.AssertEquals(
			database.countquery('SELECT COUNT()'
			+' FROM Documento__c Where Oferta__c = \''+oferta.Id+'\''),0
		);
	}
}