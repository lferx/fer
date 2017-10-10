@isTest
private class Detalle_de_colonia_Controller_TEST {
	
	@isTest static void test_method_one() {
		//Etapa__c etapa = new Etapa__c();
  //      etapa = [Select id From Etapa__c Where NumEtapa__c =: 9];
        
  //      Etapa__c etapaVenta = new Etapa__c();
  //      etapaVenta = [Select id From Etapa__c Where NumEtapa__c =: 13];
        
  //      DocumentoEtapa__c de = new DocumentoEtapa__c();
  //      de = [Select id, name From DocumentoEtapa__c Where Etapa__c =: etapa.id and Orden__c =: 2 ];

        ColoniaFraccionamiento__c col = new ColoniaFraccionamiento__c();
        col.name = 'ksdjk';
        col.Precio_medio_de_mercado__c = 200000;
        col.m2_construccion_medio_mercado__c = 90;
        col.Calificacion_centros_comerciales__c = '1';
        col.Calificacion_escuelas__c = '1';
        col.Calificacion_hospitales__c= '1';
        col.Calificacion_parques__c= '1';
        col.Calificacion_restaurantes__c= '1';
        col.Calificacion_super__c= '1';
        col.Punto__Latitude__s = 19.432632;
        col.Punto__Longitude__s = -99.133298;
        //-99.133298
        insert col;

        
        Propiedad__c p = new Propiedad__c();
        p.Name = 'PTEST999';
        p.GeneraOferta__c = true;
        p.Colonia_busqueda__c = col.id;
        p.Terreno_m2__c = 12;
        p.Construccion_m2__c = 12;
        //p.ltima_Oferta__c =
        insert p;
        
        //Oferta__c oferta = [Select Id, Name, Propiedad__c From Oferta__c Where Propiedad__c =: p.Id];
        Oferta__c oferta = new Oferta__c();
        oferta.Propiedad__c  = p.id;
        oferta.Precio_Original__c = 1000;
        oferta.PrecioCompra__c = 1000;
        oferta.PrecioVenta__c = 1000;
        oferta.ValorReferencia__c = 1000;
        oferta.FechaCobro__c = system.today();
        insert oferta;

        p.Oferta__c = oferta.id;
        p.ltima_Oferta__c = oferta.id;
        update p;
        
        test.startTest();
        ApexPages.StandardController scColonia = new ApexPages.StandardController(col);
        Detalle_de_Colonia_Controller controllerColonia = new  Detalle_de_Colonia_Controller(scColonia);
        //controllerColonia.obtenerPuntuacion();
        //controllerColonia.propiedades = controllerColonia.obtenerPropiedades(col.id);
        //controllerColonia.getCalcular();
        controllerColonia.guardar();
        //controllerColonia.getPrecioPorM2();
        controllerColonia.actualizar();
        system.debug('Hola: '+controllerColonia.propiedades);
        
        test.stopTest();
	}
	
	//@isTest static void test_method_two() {
	//	// Implement test code
	//}
	
}