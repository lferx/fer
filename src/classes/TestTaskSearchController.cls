@isTest
public class TestTaskSearchController {

	static testMethod void startTaskSearch() {	

		// Get record type
		String rcId;
		for(RecordType objRc: [SELECT Id from RecordType WHERE SObjectType = 'Account' AND DeveloperName = 'Lead_Cliente']){
			rcId = objRc.Id;
		}

		// Get User Id.
		String userid = UserInfo.getUserId();
			
		// Insert data.
		Account testLead = new Account();
		testLead.FirstName = 'asdasdasdasd';
		testLead.LastName = 'asdasdasdasd';
		testLead.RecordTypeId = rcId;
		insert testLead;
		//testLead.

		Task tstTask1 = new Task();
		//tstTask1.Name = 'testtask';
		tstTask1.Subject = 'testtask';
		tstTask1.Description = 'testtask|CreacionCUentaTipoLead|'+testLead.Id;
		tstTask1.OwnerId = userid;
		tstTask1.Comentarios__c = 'testtask';
		tstTask1.Status = 'No Iniciada';
		tstTask1.Fecha__c = Date.today();
		Insert tstTask1;

		Task tstTask2 = new Task();
		//tstTask1.Name = 'testtask';
		tstTask1.Subject = 'testtask2';
		tstTask1.Description = 'testtask2|CreacionCUentaTipoLead|'+testLead.Id;
		tstTask1.OwnerId = userid;
		tstTask1.Comentarios__c = 'testtask2';
		tstTask1.Status = 'No Iniciada';
		tstTask1.Fecha__c = Date.today();
		Insert tstTask2;

		// Start test.
		test.startTest();

		// Get task search controller.
		TaskSearchController tstTaskSearch = new TaskSearchController();
		tstTaskSearch.list_size=1;
		PageReference pagina = new PageReference('/apex/CreacionCUentaTipoLead');
		
		Test.setCurrentPageReference(pagina);
		tstTaskSearch.busqueda='testtask';
		tstTaskSearch.Inicio();    
		tstTaskSearch.Siguiente();
		tstTaskSearch.Previo();
		tstTaskSearch.Fin();
		// End test.
		test.stopTest(); 
	}
}