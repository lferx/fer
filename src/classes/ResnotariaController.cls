public with sharing class ResnotariaController {
	public Oferta__c oferta { get;  set; }
	
	public ResnotariaController() {
		String idOferta = Apexpages.currentPage().getParameters().get('id');
		if(idOferta != null){
			oferta = [Select Id, Name, EstatusCorreoNotaria__c, EnviosNotaria__c From Oferta__c Where Id =: idOferta];
		}
	}
	
	public void accept() {
		oferta.EstatusCorreoNotaria__c = 'Aprobado';
		update oferta;
	}
	
	public void decline() {
		oferta.EstatusCorreoNotaria__c = 'Rechazado';
		update oferta;
	}
}