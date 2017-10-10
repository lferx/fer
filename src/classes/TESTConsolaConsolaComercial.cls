@isTest(SeeAllData=false)
private class TESTConsolaConsolaComercial {

    static public Account acc;
    static public Account acc2;
    static public Oferta__c oferta;
    static public Oferta__c oferta2;
    static public Estados__c edo;
    static public Ciudad__c ciudad;
    static public ColoniaFraccionamiento__c col;
    static public Campa_as_Comerciales__c campa;
    static public Propiedad__c propiedad; 
    static public ClienteOferta__c cof;
    static public Desalojo__c desa;
    static public carrito__c car;
    static public Detalle_del_Carrito__c dcar;
    static public carrito__c car2;
    static public cita__c cita;
    //static public list<Oferta__c> lstOfertas;

    //static public ConsolaComercialController clc;



    //static public ConsolaComercialController clc2;
    //static public ConsolaComercialController clc3;
    
    @isTest
    static public void initData(){
        RecordType tipoReg2 = [SELECT Id FROM RecordType where name = 'Cliente' limit 1];

        acc = new Account();
        //acc.firstname = 'test';
        acc.name = 'test2';
        acc.Usuario__c = 'test';
        acc.Password__c = '12345';
        acc.Plaza__c = 'Dif-Mex';
        acc.Phone = '5123354555';
        acc.Email__c = 'aaa@www.com';
        acc.Precalificacion__c = 5000000;
        acc.RecordTypeId = tipoReg2.id;
        acc.Ciudad_Plaza__c = 'ciudadtest';

        insert acc;

        acc2 = new Account();
        acc2.Name = 'test223';
        acc2.Usuario__c = 'te23st';
        acc2.Password__c = '1232345';
        acc2.Plaza__c = 'Dif-Mex';
        acc2.Phone = '5123344555';
        acc2.Email2__c = 'aeaa@wwew.com';
        acc2.Precalificacion__c = 4000000;
        acc2.RecordTypeId = tipoReg2.id;
        acc2.Ciudad_Plaza__c = 'ciudadtest';
        insert acc2;

        edo = new Estados__c();
        edo.Name = 'aguas';
        insert edo;

        col = new ColoniaFraccionamiento__c();
        col.name = 'ksdjk';
        col.Precio_medio_de_mercado__c = 20000;
        insert col;

        ciudad = new Ciudad__c();
        ciudad.name = 'ciudadtest';
        insert ciudad;


        campa = new Campa_as_Comerciales__c();
        campa.name='todas';
        campa.Promocion_desalojadas__c ='promo desalojo';
        campa.Devoluci_n__c ='Mas 5 mil';
        campa.Dias_en_stock_max__c = 10000;
        campa.Dias_en_stock_min__c = 1;

        insert campa;

        propiedad  = new Propiedad__c();
        propiedad.Name = 'test';
        propiedad.Punto__Latitude__s = 19.3352378054;
        propiedad.Punto__Longitude__s = -99.1600018862;
        propiedad.Plaza__c = 'Dif-Mex';
        Propiedad.Collection_Id__c = 'udfgsjkdimkbjgy';
        propiedad.Tipo_de_calle__c = 'calle';
        Propiedad.Calle__c = 'sdf';
        Propiedad.NumeroExterior__c = '123';
        Propiedad.NumeroInterior__c = '345';
        Propiedad.Lote__c = '12345';
        Propiedad.Manzana__c = '45';
        Propiedad.CP__c = '01234';
        Propiedad.Tipo_de_colonia__c = 'Avenida';
        Propiedad.Colonia__c = col.id;
        Propiedad.Municipio__c = 'Municipio';
        Propiedad.Estado__c = edo.id;

        insert propiedad;

        Datetime currTime = System.now();

        oferta = new Oferta__c();
        oferta.Name = 'oferta1';
        //oferta.Promotor__c = promotor.Id;
        oferta.Propiedad__c = propiedad.Id;
        oferta.ValorReferencia__c = 300000;
        oferta.Campa__c = campa.id;
        oferta.Estatus_de_invasion__c = 'Desalojada';
        oferta.Precio_Original__c = 500000;

        oferta.Estatus__c = 'Pagada';
        oferta.FechaPago__c = Date.newInstance(currTime.year(), currTime.month(), currTime.day()-10);
        oferta.FechaCobro__c = null;
        oferta.Etapa__c = 'Compilación expediente compra';

        insert oferta;
        
        //lstOfertas = new list<Oferta__c>();
        //lstOfertas.add(oferta);
        //lstOfertas.add(oferta2);

        //insert lstOfertas;

        //cof  =new ClienteOferta__c();
        //cof.Cuenta__c = acc.Id;
        //cof.Oferta__c = oferta.Id;
        //insert cof;
        
        desa = new Desalojo__c();
        desa.Oferta__c = oferta.Id;
        desa.Estatus__c= 'Completado';
        insert desa;

        car = new carrito__c(
            Cuenta__c =acc.id
            );
        insert car;

        dcar = new Detalle_del_Carrito__c(
            Carrito__c = car.id,
            Oferta__c = oferta.id

            );
        insert dcar;

        car2 = new carrito__c(
            Cuenta__c =acc.id,
            Fecha_de_envio_pdf__c = System.now()
            );
        insert car2;

        cita = new cita__c(
            promotor__c= acc2.id,
            fecha__c = '20/02/2016',
            hora__c = '03:59',
            Oferta__c = oferta.id,
            lead__c = acc.id
            );
        insert cita;


    }

    //@isTest
    static testMethod void TESTConsola_Leads() {
        
        
        test.startTest();
        initData();
        
        Test.setCurrentPageReference(new PageReference('Page.ConsolaComercial'));
        System.currentPageReference().getParameters().put('id', acc.id);
        //ApexPages.StandardController sc = new ApexPages.StandardController(oferta);
        ConsolaComercialController clc = new ConsolaComercialController();
        //clc.ConsolaComercialController();

        //clc.Reset();

        clc.cobertura();
        
        clc.tipoDeOrden = 'ASC';
        clc.campoOrden = 'Name';
        clc.ordenar();

        //seccion de listas---------------
        clc.getEdoLst();
        clc.getCdLst();
        clc.getColLst();
        clc.geteslst();
        clc.getinlst();
        clc.getrehalst();
        clc.gettplst();
        clc.getnhlst();
        clc.getprlst();
        clc.getprlst2();
        clc.getdilst();
        clc.getetlst();
        clc.getoflst();
        //seccion de listas---------------

        clc.aumentarcampos();
        
        clc.checkEmail();

        clc.email01 = 'test';
        clc.email02 = 'test';
        clc.email03 = 'test';

        clc.checkEmail();

        clc.email01 = 'test@test.com';
        clc.email02 = 'test@test.com';
        clc.email03 = 'test@test.com';

        clc.checkEmail();

        clc.citalead();

        clc.agregar();
        clc.ofertaId= oferta.id;
        clc.agregar();

        clc.precalificacion();
        clc.esCuentaPersonal=true;
        clc.precalificacion();
        clc.cancelarLead();
        clc.envioficha();
        clc.stock();
        
        


        ////clc.validarcarrito();
        clc.buscar();
        clc.folioOferta= oferta.Name;
        clc.buscar();

        ////clc.llenadoPaginas();

        clc.next();
        clc.previous();

        //clc.ofertaId = oferta.id;
        //clc.agregar();
        clc.guardar();
        clc.idDetalleDelete = dcar.id;
        clc.eliminar();

       
        

        ////clc.validarCliente(acc.id);
        clc.crearCarrito(acc.id);

        
        clc.pdf();
        clc.sendPdf();
        clc.modificarDatosPdf();

        clc.exportar();
        clc.enviarexcel();
        clc.modificarDatosExcel();
        

        clc.obtenerUltimoCarritoLleno();


        

        

        test.stopTest();
    }
    static testMethod void fichaTecnicaCliente(){
        test.startTest();
        initData();
        ficha_cliente_Pdf ft = new ficha_cliente_Pdf();
        ft.listaCarro = [SELECT Oferta__r.Propiedad__r.Collection_Id__c, Oferta__r.Name, Precio_Negociado__c FROM Detalle_del_Carrito__c where carrito__c =:car.id];

        Test.setCurrentPageReference(new PageReference('Page.ficha_cliente_Pdf'));
        System.currentPageReference().getParameters().put('id', dcar.id);
        ft.guardarFotosComoAdjuntos();
        ft.sinFoto();
        ft.obtenerfoto('');
        ft.cobertura();
        

        test.stoptest();

    }

    static testMethod void crearLeadtest(){
        test.startTest();
        initData();
        Crear_Lead_controller clc = new Crear_Lead_controller();
        Test.setCurrentPageReference(new PageReference('Page.CreacionCuentaTipoLead'));
        System.currentPageReference().getParameters().put('id', acc.id);


        clc.nombre = 'tester';
        clc.apellido = 'testerlast';


        clc.idcita = dcar.id;

        clc.nuevoLead.Precalificacion__c = 250001;//-----426
        clc.nuevoLead.Fecha_de_nacimiento__c = Date.valueOf(System.now());//----301

        clc.nuevoLead.PersonEmail = 'test@test.com';
        clc.nuevoLead.firstname = 'tester';
        clc.nuevoLead.lastname='testerlast';
        clc.nuevoLead.type = 'invasor';//----543
        clc.nuevoLead.Email__c = 'test@prueba.com';

        //clc.crearLead();
        

        clc.quit();
        clc.Addcita();
        clc.getpro();
        clc.citas();

        clc.idc= cita.id;
        clc.asistio();
        //clc.noasistio();
        clc.guardarp();
        //clc.idcarrito = dcar.id;//----250
        //clc.guardarcita();
        clc.getdc();
        //clc.saveall();


        String x = 'testplaza';
        //clc.plazas2 = new List<String>();//------365
        clc.plazas2.add(x);
        clc.validaplaza2();
        clc.validaplaza();
        //clc.crearLead();
        clc.getOptions();
        

        clc.cancelarLead();
        clc.datoslead();
        clc.precalificacion();
        clc.stock();
        clc.envioficha();
        clc.citalead();
        clc.citalead2();
        clc.autorizacion();
        clc.guardarIrDatosLead();
        clc.guardarIrStock();
        
        clc.irPrecalificacion();
        clc.irStock();
        //clc.guardarcitalead();
        clc.buscaCarrito();
        clc.sumar();
        clc.fechaHoy();
        clc.validaciones();
        clc.cambioTipoCredito();
        clc.cita();

        

        clc.cobertura();


        test.stopTest();





    }

    static testMethod void seguimientoCorreosTest(){
        test.startTest();

        SeguimientoCorreos sc = new SeguimientoCorreos();
        sc.cobertura();

        test.stopTest();

    }

    //@isTest
    /*static testMethod void testSubMethodf(){
        
        test.startTest();
        
        //Test.setCurrentPageReference(new PageReference('Page.ConsolaComercial').put('id',acc2.id));
        

        //clc2 = new ConsolaComercialController();
        //clc2.cancelarLead();
        
        //String [] cd2 = new String[]{ciudad.name};
        
        //clc.setCiudadSelec(cd2);
        //clc.actualizar2();



        test.stopTest();

        
    }*/
}