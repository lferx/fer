@isTest
private class TestListaBoletosController {
	
	@isTest(seeAllData = true)
	static void test_method_one() {
		
		Sorteo__c sorteo = new Sorteo__c();
		sorteo.Fecha_de_inicio__c = System.today().addDays(-10);
		sorteo.Fecha_de_fin__c = System.today().addDays(10);
		sorteo.Name='La casa de tus sueños';
		
		insert sorteo;
		
		Preca_Web__c preca = new Preca_Web__c();
		
		preca.NSS__c = '12345678923';
		preca.Plaza__c = 'Dif-Mex';
		preca.Nombre__c = 'Juan';
		preca.Fecha_Nacimiento__c = system.today().format();
		preca.Apellido__c = 'juan';
		preca.Email__c = 'jjjhjh@hjhjhjh.com';
				
		insert preca;
		
		PageReference tpageRef = Page.VFListaBoletos;
		Test.setCurrentPage(tpageRef);
		ApexPages.currentPage().getParameters().put('email', 'jjjhjh@hjhjhjh.com');
		ListaBoletosController listabolClass = new ListaBoletosController();
		
		
		Lead candidato = new Lead();
		
		candidato.NSS__c = '12345338923';
		candidato.Plaza__c = 'Dif-Mex';
		candidato.FirstName = 'Juan';
		candidato.LastName = 'Loyola';
		candidato.Company ='test';
		candidato.Email = 'jjjhjh@hjhjhjhe.com';
				
		insert candidato;
		
		PageReference tpageRef2 = Page.VFListaBoletos;
		Test.setCurrentPage(tpageRef2);
		ApexPages.currentPage().getParameters().put('email', 'jjjhjh@hjhjhjhe.com');
		ListaBoletosController listabolClass2 = new ListaBoletosController();
	}

}