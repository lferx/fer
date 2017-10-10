@isTest
private class TestResponseMailAction {
	
	@isTest(seeAllData = true)
	static void test_method_one() {
		
		Profile perfilGerenteVentas = [SELECT Id FROM Profile WHERE Name = 'Gerente de Ventas' LIMIT 1];
		
		User u = new User(Alias = 'standtst', Email='standardusertst@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = perfilGerenteVentas.Id, 
            Plaza__c = 'Dif-Mex',
            TimeZoneSidKey='America/Los_Angeles', UserName='standardusertst@testorg.com');
       
       insert u;
		
		
		Lead lead = new Lead();
		lead.FirstName = 'Juan';
		lead.Credito__c = 500000;
		lead.Plaza__c = 'Dif-Mex';
		lead.LastName = 'Loyola';
		lead.Company ='SNK';
		lead.NSS__c ='12345678901';
		
		insert lead;
		
		
		ResponseMailAction.actualizarLead(lead.Id);
	
	}
}