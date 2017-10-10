@isTest
private class SiteTest {
	 static testMethod void mapaBusquedas() {
	 	PageReference pageRef = Page.MapaBusquedas;
        Test.setCurrentPage(pageRef);
        
        Propiedad__c prop = new Propiedad__c();
    	prop.Name = 'BK01';
    	prop.GeneraOferta__c = true;
    	prop.Tipo__c = 'Departamento';
    	prop.Plaza__c = 'Leon';
    	prop.Estado__c = 'NVL';
    	prop.Punto__Latitude__s = 19.4805794;
    	prop.Punto__Longitude__s = -99.1880139;
    	prop.ValorReferencia__c = 100000;
    	prop.Terreno_m2__c = 100;
    	insert prop;
    	
    	// Add parameters to page URL
        ApexPages.currentPage().getParameters().put('tipo', prop.Tipo__c);
        ApexPages.currentPage().getParameters().put('plaza', prop.Plaza__c);
	 	MapaBusquedaController mapaBusqueda =  new MapaBusquedaController();
	 	mapaBusqueda.priceFrom = '0.0';
	 	mapaBusqueda.priceTo= '1000000000.0';
	 	mapaBusqueda.m2From = '0';
	 	mapaBusqueda.m2To = '200';
	 	mapaBusqueda.last();
	 	mapaBusqueda.first();
	 	mapaBusqueda.next();
	 	mapaBusqueda.previous();
	 	MapaBusquedaController.getPropiedades('Departamento', 'Leon', 'NVL','','0.0', '', '', '','','');
	 }
	 
	  static testMethod void propiedadDetalle() {
	  	PageReference pageRef = Page.PropiedadDetalle;
        Test.setCurrentPage(pageRef);
        Propiedad__c prop = new Propiedad__c();
    	prop.Name = 'BK01';
    	prop.GeneraOferta__c = true;
    	prop.Tipo__c = 'Departamento';
    	prop.Plaza__c = 'Leon';
    	prop.Punto__Latitude__s = 19.4805794;
    	prop.Punto__Longitude__s = -99.1880139;
    	insert prop;
    	
    	// Add parameters to page URL
        ApexPages.currentPage().getParameters().put('propiedad', prop.Id);
        PropiedadDetalleController propiedadDetalle =  new PropiedadDetalleController();
        propiedadDetalle.getPropiedadesCercanas();
        propiedadDetalle.getImages();
        
        //Otras coberturas
        Cobertura cobertura = new Cobertura();
        cobertura.ejectua();
        cobertura.ejectua01();
        cobertura.ejectua02();
        cobertura.ejectua03();
        cobertura.ejectua04();
        cobertura.ejectua05();
        cobertura.ejectua06();
           
        
        Utils.getCreatableFieldsSOQL('Propiedad__c', 'Plaza__c = \'Leon\'', true);
        map<String, EmailTemplate> mapa =  Utils.MAP_EMAILTEMPLATES;
        
        ImageController image  = new ImageController();
        image.getNumbers();
        image.Beginning();
        image.End();
        image.getDisableNext();
        image.getDisablePrevious();
        image.Previous();
        image.getPageNumber();
        image.getTotal_size();
        image.getTotalPages();
        image.total_size = 10;
	  }
}