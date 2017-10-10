@isTest
private class Test_UtilidadMenuRapido {
	private static final String NOMBRE_LEAD_PRUEBA = 'Nombre';
	private static final String APELLIDO_LEAD_PRUEBA = 'Apellido';
	private static final String EMAIL_LEAD_PRUEBA = 'prueba@gmail.com';

	@isTest static void testCrearEstado() {
		Estado_Menu_Rapido__c estadoMenu = UtilidadMenuRapido.crearEstado();
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_ROJO, estadoMenu.Semaforo_Autorizacion__c);
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_ROJO, estadoMenu.Semaforo_Carrito__c);
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_ROJO, estadoMenu.Semaforo_Cita__c);
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_ROJO, estadoMenu.Semaforo_Datos_Iniciales__c);
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_ROJO, estadoMenu.Semaforo_Precalificacion__c);
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_ROJO, estadoMenu.Semaforo_Stock__c);
	}

	@isTest static void testObtenerEstadoSinIdCuenta() {
		Estado_Menu_Rapido__c estadoMenu = UtilidadMenuRapido.obtenerEstado(null);
		System.assertEquals(null, estadoMenu.Cuenta__c);
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_ROJO, estadoMenu.Semaforo_Autorizacion__c);
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_ROJO, estadoMenu.Semaforo_Carrito__c);
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_ROJO, estadoMenu.Semaforo_Cita__c);
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_ROJO, estadoMenu.Semaforo_Datos_Iniciales__c);
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_ROJO, estadoMenu.Semaforo_Precalificacion__c);
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_ROJO, estadoMenu.Semaforo_Stock__c);
	}

	@isTest static void testObtenerEstadoConIdCuenta() {
		Account cuenta = obtenerCuentaDePrueba();
		System.assertNotEquals(null, cuenta);

		Estado_Menu_Rapido__c estadoMenu = UtilidadMenuRapido.obtenerEstado(cuenta.Id);
		System.assertEquals(cuenta.Id, estadoMenu.Cuenta__c);
		System.assertEquals(UtilidadMenuRapido.SEMAFORO_VERDE, estadoMenu.Semaforo_Datos_Iniciales__c);
	}

	@isTest static void testGuardarEstadoNuevo() {
		Account cuenta = obtenerCuentaDePrueba();
		System.assertNotEquals(null, cuenta);

		Estado_Menu_Rapido__c estadoMenu = UtilidadMenuRapido.crearEstado();
		estadoMenu.Cuenta__c = cuenta.Id;
		estadoMenu.Semaforo_Datos_Iniciales__c = UtilidadMenuRapido.SEMAFORO_VERDE;
		UtilidadMenuRapido.guardarEstado(estadoMenu);

		Integer countEstadosMenu = [SELECT COUNT() FROM Estado_Menu_Rapido__c WHERE Cuenta__c =:cuenta.Id];
		System.assert(countEstadosMenu > 1);
	}

	@isTest static void testGuardarEstadoExistente() {
		Account cuenta = obtenerCuentaDePrueba();
		System.assertNotEquals(null, cuenta);

		Estado_Menu_Rapido__c estadoMenu = UtilidadMenuRapido.obtenerEstado(cuenta.Id);
		estadoMenu.Semaforo_Precalificacion__c = UtilidadMenuRapido.SEMAFORO_AMARILLO;
		UtilidadMenuRapido.guardarEstado(estadoMenu);

		Integer countEstadosMenu = [SELECT COUNT() FROM Estado_Menu_Rapido__c WHERE Cuenta__c =:cuenta.Id];
		System.assert(countEstadosMenu == 1);
}

	@testSetup
	private static void testSetup()
	{
		Account cuenta = new Account(
			RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Lead Cliente').getRecordTypeId(),
			FirstName = NOMBRE_LEAD_PRUEBA,
			LastName = APELLIDO_LEAD_PRUEBA,
			Phone = '1234567890',
			Email__c = EMAIL_LEAD_PRUEBA
		);
		insert cuenta;

		Estado_Menu_Rapido__c estadoMenu = UtilidadMenuRapido.crearEstado();
		estadoMenu.Cuenta__c = cuenta.Id;
		estadoMenu.Semaforo_Datos_Iniciales__c = UtilidadMenuRapido.SEMAFORO_VERDE;
		insert estadoMenu;
	}

	private static Account obtenerCuentaDePrueba() {
		return [SELECT Id, Name FROM Account WHERE Email__c = :EMAIL_LEAD_PRUEBA LIMIT 1];
	}
}