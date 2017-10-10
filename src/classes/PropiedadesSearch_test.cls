@isTest
private class PropiedadesSearch_test {
	
	@isTest static void testInit() {
		Account acc = Leads_DataFactory.creaCuenta();
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
		PropiedadesSearch ctrl = new PropiedadesSearch(sc);
		Test.setCurrentPage(Page.PropiedadesSearch);

	}
	
	
	@isTest static void testOptions() {
		Account acc = Leads_DataFactory.creaCuenta();
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
		PropiedadesSearch ctrl = new PropiedadesSearch(sc);
		Test.setCurrentPage(Page.PropiedadesSearch);
		ctrl.getplazasOptions();
		ctrl.gethabitacionesOptions();
		ctrl.getbanosOptions();
		ctrl.gettipoPropOptions();
		ctrl.getnivPropOptions();


	}

	@isTest static void testSearch() {
		Account acc = Leads_DataFactory.creaCuenta();
		Leads_DataFactory.creaPropiedades(25);
		ApexPages.StandardController sc = new ApexPages.StandardController(acc);
		PropiedadesSearch ctrl = new PropiedadesSearch(sc);
		Test.setCurrentPage(Page.PropiedadesSearch);
		ctrl.executeSearch();

		Propiedad__c search = new Propiedad__c();
		search.Name = 'propiedad prueba';
		search.CP__c = '123456';
		search.Colonia__c = 'colonia';
		search.Municipio__c = 'municipio';
		ctrl.searchProp = search;

		ctrl.plazas = new list<String>{'Aguascalientes', 'otro'};
		ctrl.habitaciones = new list<String>{ '1 Recamara', '2 Recamaras'};
		ctrl.banos = new list<String>{ '1 Baño', '2 Baños'};
		ctrl.tipoprop = new list<String>{ 'Departamento', 'Casa'};
		ctrl.nivprop = new list<String>{ '1 Nivel', '2 Niveles'};

		ctrl.executeSearch();
		ctrl.siguiente();
		ctrl.anterior();
		ctrl.ultimo();
		ctrl.inicio();

		ctrl.getDisableNext();
		ctrl.getDisablePrevious();

		ctrl.next();
		ctrl.sendPdf();
		ctrl.sendpdffinal();
		ctrl.reset();

	}

	@isTest static void testPropiedadWrapper(){
		PropiedadWrapper wrap = new PropiedadWrapper();

	}
}