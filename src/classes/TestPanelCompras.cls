@isTest
private class TestPanelCompras {
	
	@isTest static void startPanelCompras() {

		Etapa__c tstetapas = new Etapa__c();
		tstetapas.NumEtapa__c = 4;
		insert tstetapas;

		EtapaOferta__c tstetpofertas = new EtapaOferta__c();
		//tstetpofertas.Oferta__r.FechaCobro__c = NULL;
		//tstetpofertas.Oferta__r.FechaPago__c = Date.today();
		tstetpofertas.HoraInicial__c = Date.today();
		//insert tstetpofertas;

		//WHERE FechaCobro__c = null AND FechaPago__c != null
		//AND Estatus__c != NULL AND  Gerente_Escrituras__r.Name =:asignacion 
		//AND (NOT Inversor2__c LIKE 'Regeneradora%') AND Estatus__c != 'Descartada' 
		//AND Etapa__c IN ('Antecedentes','Aprobada internamente','Compilación expediente compra',
		//'Compra final','Escrituras en proceso registro')

		Account tstcuentas = new Account();
		tstcuentas.Name = 'cuentas';
		insert tstcuentas;
		//Empresas_Grupo__c tstempresasgrupo = new Empresas_Grupo__c();
		//insert tstempresasgrupo;
		Paquete__c tstpaquetes = new Paquete__c();
		tstpaquetes.Name = 'nombres';
		//tstpaquetes.Empresas_Grupo__c = tstpaquetes.Id;
		insert tstpaquetes;

		Oferta__c testoftcompras = new Oferta__c();
		//update testoftcompras;
		testoftcompras.Name = 'IF-676766';
		testoftcompras.FechaPago__c = Date.today();
		testoftcompras.Etapa__c = 'Antecedentes';
		testoftcompras.Estatus__c = 'En proceso';
		testoftcompras.Paquete__c = tstpaquetes.Id;
		testoftcompras.Gerente_Escrituras__c = tstcuentas.Id;

		insert testoftcompras;

		//testoftcompras.Inversor2__c = 'cuenta';
		//update testoftcompras;

		test.startTest();

			panel_compras_controller tstPanelCompras = new panel_compras_controller();

			panel_compras_controller.wrapperOferta wrappercompras = new panel_compras_controller.wrapperOferta();

	    	tstPanelCompras.porcentajeDia = 7.52/30;
	    	//tstPanelCompras.map_etp_ofert.put('IF-676766', tstetpofertas.HoraInicial__c.date());

			//wrappercompras.wrapperOferta();
		    tstPanelCompras.panel_oferta_compras();
		    tstPanelCompras.asignacion = 'hh';
		    tstPanelCompras.panel_oferta_compras();
		    tstPanelCompras.listOfertas.add(testoftcompras);
		    tstPanelCompras.getListaAsignacion();
	    	PageReference paginacompras = new PageReference('/apex/panel_compras');
	        Test.setCurrentPageReference(paginacompras);

		test.stopTest(); 
	}

}