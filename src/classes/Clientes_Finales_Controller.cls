public with sharing class Clientes_Finales_Controller {

	public List<Account> clintesFinales {get;set;}
	public String idPaqueteOfertas {get;set;}

	public Clientes_Finales_Controller(ApexPages.StandardController stdcontroller) {
		idPaqueteOfertas = stdcontroller.getId();
		clintesFinales = [SELECT name,phone,email__c FROM Account WHERE Id in (SELECT ClienteFinal__c FROM Oferta__c WHERE Paquete_de_Ofertas__c = :idPaqueteOfertas AND ClienteFinal__c != NULL)];
	}

 
}