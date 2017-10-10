@isTest
private class CloudMobileTestRevimex {
	
	@isTest static void PropiedadDetalleTest() {
        // Propiedad 1
        Propiedad__c p = new Propiedad__c();
        p.FolioLlave__c = '999342C';
        p.Punto__Latitude__s = 19.423439;
        p.Punto__Longitude__s = -99.156659; 
        p.Plaza__c = 'Cancun';
        p.PrecioVenta__c = 200000;
        insert p;

        //Start Test
        Test.startTest();
        ApexPages.currentPage().getParameters().put('propiedad',p.Id);
        PropiedadDetalleController pdc = new PropiedadDetalleController();
        pdc.addView();
        pdc.getImages();
        pdc.getUrlImage();
        pdc.getPropiedadesCercanas();
        Decimal d1 = PropiedadDetalleController.distancia(19.423439, -99.156659, 19.389114, -99.113057);
        Decimal d2 = PropiedadDetalleController.distanciaDos(19.423439, -99.156659, 19.389114, -99.113057);
        PageReference v = pdc.vacio();
        PageReference s = pdc.doNothing();
        System.debug('### Propiedad: '+pdc.propiedad22);
        System.assertEquals(p.Id, pdc.propiedad22.Id);
        
        
        Test.stopTest();
    }

    @isTest static void MapaBusquedaTest() {
        //Start Test
        Test.startTest();
        MapaBusquedaController mbcNoParameters = new MapaBusquedaController();
        ApexPages.currentPage().getParameters().put('estado','ROO');
        ApexPages.currentPage().getParameters().put('ciudad','Cancun');
        ApexPages.currentPage().getParameters().put('tipo','Casa habitación');
        ApexPages.currentPage().getParameters().put('plaza','Cancun');
        ApexPages.currentPage().getParameters().put('centroPropiedad','19.423437,-99.156658');
        MapaBusquedaController mbc = new MapaBusquedaController();
        mbc.cp = '06500';

        //
        mbc.priceFrom = '10000';
        mbc.m2From = '10';
        mbc.m2ConstruccionFrom = '10';
        mbc.searchPropiedades();

        mbc.priceFrom = '';
        mbc.m2From = '';
        mbc.m2ConstruccionFrom = '';
        mbc.m2To = '1000';
        mbc.priceTo = '200000';
        mbc.m2ConstruccionTo = '1000';
        mbc.searchPropiedades();

        mbc.priceFrom = '10000';
        mbc.m2From = '10';
        mbc.m2ConstruccionFrom = '10';
        mbc.searchPropiedades();
        mbc.setTotalPages(10);
        mbc.first();
        mbc.pageNumber = 3;
        mbc.next();
        mbc.previous();
        mbc.last();
        PageReference sv = mbc.searchVista();
        MapaBusquedaController.getPropiedades('Cancun','Casa habitación','ROO','Cancun','0','10000000','10','10000','19.423437,-99.156658', 'En venta');
        MapaBusquedaController.getPropiedades('Cancun','Casa habitación','ROO','Cancun','','10000000','','10000','19.423437,-99.156658', 'En venta');
        MapaBusquedaController.getPropiedades('Cancun','Casa habitación','ROO','Cancun','0','','10','','19.423437,-99.156658', 'En venta');
        List<Propiedad__c> propies = mbc.propiedadesbusqueda();
        
        Test.stopTest();
    }

    @isTest static void UtilsTest() {
        String soql = Utils.getCreatableFieldsSOQL('Propiedad__c', 'Id != null', true);
        Map<String, EmailTemplate> et = Utils.MAP_EMAILTEMPLATES;
        Utils.getResourceURL('s');
    }

    @isTest static void PropiedadControllerTest() {
        //Start Test
        Test.startTest();
        // Propiedad 1
        Propiedad__c propiedad = new Propiedad__c();
        propiedad.FolioLlave__c = '999342R';
        propiedad.Punto__Latitude__s = 19.423439;
        propiedad.Punto__Longitude__s = -99.156659;
        propiedad.Plaza__c = 'Cancun';
        propiedad.Estado__c = 'ROO';
        propiedad.PrecioVenta__c = 200000;
        insert propiedad;
        PropiedadesController pc = new PropiedadesController();
        pc.refresh();
        Integer copo = pc.countProp;
        Integer copo2 = pc.countProp2;
        Integer copoall = pc.countPropAll;
        JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
        generator.writeStringField('Plaza__c', 'Todos');
        generator.writeStringField('Tipo__c', 'Todos');
        generator.writeEndObject();
        String jsonString = generator.getAsString();
        JSONGenerator generatorb = JSON.createGenerator(true);
        generatorb.writeStartObject();
        generatorb.writeStringField('Plaza__c', 'Cancun');
        generatorb.writeStringField('Tipo__c', 'Departamento');
        generatorb.writeEndObject();
        String jsonStringb = generator.getAsString();
        List<Propiedad__c> l = PropiedadesController.buscar(1, 1, jsonString);
        List<Propiedad__c> l2 = PropiedadesController.buscar(0, 0, jsonStringb);
        List<Propiedad__c> l3 = PropiedadesController.buscarAll(1, 1, jsonString);
        List<Propiedad__c> l4 = PropiedadesController.buscarAll(0, 0, jsonStringb);
        Integer la = PropiedadesController.buscarAllCount(jsonString);
        String s = pc.txtPlaza;
        List<String> p = pc.plazas;
        List<String> t = pc.tipos;
        List<String> e = pc.estados;
        map<String,String> me = pc.mapEstados;
        List<SelectOption> so = pc.estadosItems;
        map<String,list<String>> mec = pc.mapEstadoCiudad;
        List<Propiedad__c> prop = pc.propiedades;
        String pid = propiedad.Id; 
        String gp = PropiedadesController.guardarPuntoEncontrado(pid,'19.423439','-99.156659','');
        String gpf = PropiedadesController.guardarPuntoEncontrado('pid','19.423439','-99.156659','');
        
        SitioHomePageController shpc = new SitioHomePageController(pc);
        shpc.obtieneDatosHome();
        shpc.omitirSegundoPaso();
        
        shpc.prospecto.Nombre__c = 'Juan';
        try{
        shpc.guardaProspecto();
        }catch(exception exp){
        	
        }
        
        SitioHomePageController shpc2 = new SitioHomePageController();
        Test.stopTest();
        
        
    }
	
}