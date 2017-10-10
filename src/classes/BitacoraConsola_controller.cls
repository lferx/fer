public with sharing class BitacoraConsola_controller {
	public Bitacora_Oferta__c bitacora {get; set;}
	public Documento__c documento {get;set;}
	public Boolean casoEspecial {get;set;}
	public Id docId {get; set;}
	public String dictamen {get; set;}
	public String comentarios {get; set;}
	public DateTime recordatorio {get; set;}

	public BitacoraConsola_controller() {
		bitacora = new Bitacora_Oferta__c(); 
		documento = new Documento__c();
		casoEspecial = false;
	}

	public void guardar(){

		documento = [SELECT Fecha_Com_Controller__c FROM Documento__c WHERE ID = :docId];
		if(bitacora.Recordatorio__c > documento.Fecha_Com_Controller__c){
			casoEspecial = true;
		} 
		
		bitacora.Documento__c = docId;
		bitacora.Recordatorio__c = recordatorio;
		bitacora.Comentarios__c = comentarios;
		bitacora.Dictamen_Consola__c = dictamen;
		System.debug('bitacora componente: ' + bitacora);
		insert bitacora;
		bitacora = new Bitacora_Oferta__c();
	}
}