@isTest
private class SeguimientoCorreos_test {
	
	@isTest static void test_method_one() {
       
        Test.startTest();

		Contact contacto = new Contact();

		contacto.LastName='c';


		Test.stopTest();

	}

	@isTest static void test_method_two() {

        Test.startTest(); 

		Detalle_del_Carrito__C detallecar = new Detalle_del_Carrito__C();

        
        detallecar.Oferta__c='a08g0000008NAHm';
      
		Test.stopTest();
	}
	
	
}