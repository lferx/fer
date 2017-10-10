@isTest
private class TestFichaTecnica {

	static testMethod void test_ExhibitAadminTier(){

		ColoniaFraccionamiento__c col = new ColoniaFraccionamiento__c();
		col.name = 'ksdjk';
		col.Precio_medio_de_mercado__c = 200000;
		col.m2_construccion_medio_mercado__c = 90;

		insert col;

		Propiedad__c propiedad  = new Propiedad__c();
		propiedad.Name = 'test';
		propiedad.Punto__Latitude__s = 19.3352378054;
		propiedad.Punto__Longitude__s = -99.1600018862;
		propiedad.Plaza__c = 'Dif-Mex';
		Propiedad.Collection_Id__c = 'test';
		propiedad.Tipo_de_calle__c = 'calle';
		Propiedad.Calle__c = 'sdf';
		Propiedad.NumeroExterior__c = 'ewf';
		Propiedad.NumeroInterior__c = '345';
		Propiedad.Lote__c = 'rth';
		Propiedad.Manzana__c = 'fefd';
		Propiedad.CP__c = '01234';
		Propiedad.Tipo_de_colonia__c = 'tipo de calle';
		Propiedad.Colonia__c = col.id;
		Propiedad.Municipio__c = 'edoruab';
		propiedad.Construccion_m2__c = 80;
		//Propiedad.Estado__c = edo.id;

		insert propiedad;

		Campa_as_Comerciales__c campa = new Campa_as_Comerciales__c();
		campa.name='todas';
		campa.Promocion_desalojadas__c ='promo desalojo';
		campa.Extras__c = 'A/C';
		campa.Devoluci_n__c ='Mas 5 mil';
		campa.Dias_en_stock_max__c = 100;
		campa.Dias_en_stock_min__c = 1;

		insert campa;

		Datetime currTime = System.now();
		//col = [SELECT id,Name, Precio_medio_de_mercado__c,Precio_por_m2_construccion_mercado__c,m2_construccion_medio_mercado__c FROM ColoniaFraccionamiento__c WHERE id = :col.id];

		Oferta__c oferta3 = new Oferta__c(
			Name = 'test1234',
			Propiedad__c = propiedad.Id,
			ValorReferencia__c = 100000,
			Colonia_busqueda__c = col.id,
			Campa__c = campa.id,
			Estatus_de_invasion__c = 'Desalojada',
			FechaPago__c = Date.newInstance(currTime.year(), currTime.month(), currTime.day()-10)
		);
		insert oferta3;

		test.startTest();

		FichaTecnica_Controller controller = new FichaTecnica_Controller();

		PageReference pageRef = Page.FichaTecnica; // Adding VF page Name here
		ApexPages.currentPage().getParameters().put('id',oferta3.id);
		
		
		controller.s=oferta3.id;
		Test.setCurrentPage(pageRef);
		controller.obtenerFicha(oferta3.id);

		campa.Dias_en_stock_max__c = null;
		update campa;

		controller.obtenerFicha(oferta3.id);

		campa.Dias_en_stock_max__c = 100;
		campa.Dias_en_stock_min__c = null;
		update campa;

		controller.obtenerFicha(oferta3.id);


		test.stopTest();
	}

	
}