@isTest
private class Google_JSONWebToken_Test {
	
	@isTest static void testInit() {
		Test.setMock(HttpCalloutMock.class, new Mock_JSONAuth());
		Google_JSONWebToken cls = new Google_JSONWebToken();
		cls.init();
	}

	@isTest static void testList() {
		Test.setMock(HttpCalloutMock.class, new Mock_DriveList());
		Google_JSONWebToken cls = new Google_JSONWebToken();
		cls.enlistarArchivos('test');
	}
	
	@isTest static void testArchivos(){
		Test.setMock(HttpCalloutMock.class, new Mock_DriveList());
		Google_JSONWebToken cls = new Google_JSONWebToken();
		cls.obtenerUrls('test');
		cls.obtenerDatosArchivos('test');
	}
	@isTest static void testuserList(){
		
		Google_JSONWebToken.Archivo pr = new Google_JSONWebToken.Archivo();
		pr.name = 'Fototset';
		pr.url = 'urltest';
		//pr.datos = 'dtest';
		//pr.salesforceId = 'tesdfg';
	}
}