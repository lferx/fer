@isTest
private class borrarFotos_TEST {
	
	@isTest static void test_method_one() {
		// Implement test code  Select Id, Name, Keywords from Document where folder.DeveloperName = 'Imagenes_de_Propiedades'
		Document document;

		document = new Document();

		document.Body = Blob.valueOf('Some Text');
		document.ContentType = 'application/pdf';

		document.DeveloperName = 'my_document';

		document.IsPublic = true;

		document.Name = 'My Document';

		document.FolderId = [select id from folder where name = 'Imagenes_de_Propiedades'].id;

		insert document;

		test.startTest();
		//FichaTecnica_Controller controller = new FichaTecnica_Controller;
		BorrarFotos controller = new BorrarFotos();
 		test.stopTest();

	}
	
	@isTest static void test_method_two() {
		// Implement test code
	}
	
}