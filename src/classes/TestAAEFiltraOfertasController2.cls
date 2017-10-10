@isTest
   private class TestAAEFiltraOfertasController2{

	@isTest
	static void test_method_two() {
		Account acc = new Account();
        acc.Name = 'test';
        acc.Usuario__c = 'test';
        acc.Password__c = '12345';
        acc.Plaza__c = 'Dif-Mex';
        acc.Phone = '5123354555';
        insert acc;

        Estados__c edo = new Estados__c();
        edo.Name = 'aguas';
        insert edo;

        Ciudad__c cd = new Ciudad__c();
        cd.name = 'testCiudad';
        insert cd;

        ColoniaFraccionamiento__c col = new ColoniaFraccionamiento__c();
        col.name = 'ksdjk';
        col.Precio_medio_de_mercado__c = 20000;
        insert col;

        Campa_as_Comerciales__c campa = new Campa_as_Comerciales__c();
        campa.name='todas';
        campa.Promocion_desalojadas__c ='promo desalojo';
        campa.Devoluci_n__c ='Mas 5 mil';
        campa.Dias_en_stock_max__c = 10000;
        campa.Dias_en_stock_min__c = 1;

        insert campa;

        Propiedad__c propiedad  = new Propiedad__c();
        propiedad.Name = 'test';
        propiedad.Punto__Latitude__s = 19.3352378054;
        propiedad.Punto__Longitude__s = -99.1600018862;
        propiedad.Plaza__c = 'Dif-Mex';
        Propiedad.Collection_Id__c = 'udfgsjkdimkbjgy';
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
        Propiedad.Estado__c = edo.id;

        insert propiedad;

        Datetime currTime = System.now();

        //condiciones=' TiempoOferta__c >= :dis AND PrecioVenta__c <= :prs AND Estatus__c != \'Descartada\' AND FechaCobro__c = Null AND FechaPago__c != Null AND ((Etapa__c IN (\'Compilación expediente compra\',\'Compra final\',\'Escrituras en proceso registro\',\'Compilación expediente cliente\')) OR (Etapa__c IN (\'Rehabilitación\') AND Estatus_de_Invasion__c = \'Invadida\')) AND (NOT Inversor2__c LIKE \'Regeneradora%\')';
        
        Oferta__c oferta = new Oferta__c();
        oferta.Name = 'test';
        //oferta.Promotor__c = promotor.Id;
        oferta.Propiedad__c = propiedad.Id;
        oferta.ValorReferencia__c = 100000;
        oferta.Campa__c = campa.id;
        oferta.Estatus_de_invasion__c = 'Desalojada';
        oferta.FechaPago__c = Date.newInstance(currTime.year(), currTime.month(), currTime.day()-10);
        oferta.FechaCobro__c = null;
        oferta.Colonia_busqueda__c = col.id;
        oferta.Ciudad_Tabla__c = cd.id;
        oferta.Oferta_Cargada__c = true;
        oferta.Etapa__c = 'Compilación expediente compra';
        oferta.Gerente_Comercial__c = acc.id;
        oferta.Gerente_Operativo__c = acc.id;
        oferta.Gerente_Escrituras__c = acc.id;
        oferta.Precio_Original__c = 3000000;

        insert oferta;

        ClienteOferta__c cof  =new ClienteOferta__c();
        cof.Cuenta__c = acc.Id;
        cof.Oferta__c = oferta.Id;
        insert cof;
        
        Desalojo__c desa = new Desalojo__c();
        desa.Oferta__c = oferta.Id;
        desa.Estatus__c= 'Completado';
        insert desa;
        
        
        test.startTest();

        AAEFiltraOfertasController2 clsOfertas = new AAEFiltraOfertasController2();
        PageReference pagina = new PageReference('/apex/AAEFitlraOfertas2');
        Test.setCurrentPageReference(pagina);

        clsOfertas.Reset2();

       	//corre las listas
       	clsOfertas.getGeLst();
        clsOfertas.getEdoLst();
        clsOfertas.getCdLst();
        clsOfertas.getColLst();
        clsOfertas.getprlst();
        clsOfertas.getetlst();
        clsOfertas.getoflst();
        clsOfertas.geteslst();
        clsOfertas.getinlst();
        clsOfertas.getdilst();
        clsOfertas.getrehalst();

        clsOfertas.exportar();

        //corre los metodos que se mandan a traer de la pagina
        clsOfertas.editarComentarios();
        clsOfertas.cancelarComentarios();
        clsOfertas.guardarComentarios();
        clsOfertas.next();
        clsOfertas.previous();

        clsOfertas.cambiarofertas();

        clsOfertas.cobertura();
	  
	}


}