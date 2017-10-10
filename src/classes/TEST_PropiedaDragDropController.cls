@isTest(seeAllData = true)
public class TEST_PropiedaDragDropController {
	
	@isTest static void test_method_one() {
		Propiedad__c propiedad  = new Propiedad__c();
        propiedad.Name = 'test';
        insert propiedad;

        ApexPages.StandardController std = new ApexPages.StandardController(propiedad);
        PropiedadDragDropController controllertmp = new PropiedadDragDropController(std);
        PageReference prtmp = controllertmp.refreshLL();

        propiedad.Punto__Latitude__s = 19.3352378054;
        propiedad.Punto__Longitude__s = -99.1600018862;
        update propiedad;
        
        PropiedadDragDropController controller = new PropiedadDragDropController(std);
        PageReference pr = controller.refreshLL();

        controller.lat = 19.3352378054;
        controller.lng =  -99.1600018862;
        PageReference pr2 = controller.refreshLL();
	}
	
	
}