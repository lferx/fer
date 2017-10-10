@isTest(seeAllData = true)
public class TEST_PropiedadDragDropControllerOferta {
  
  @isTest static void test_method_one() {
    Oferta__c propiedad  = new Oferta__c();
        propiedad.Name = 'test';
        insert propiedad;

        ApexPages.StandardController std = new ApexPages.StandardController(propiedad);
        PropiedadDragDropControllerOferta controllertmp = new PropiedadDragDropControllerOferta(std);
        PageReference prtmp = controllertmp.refreshLL();

        propiedad.Punto__Latitude__s = 19.3352378054;
        propiedad.Punto__Longitude__s = -99.1600018862;
        update propiedad;
        
        PropiedadDragDropControllerOferta controller = new PropiedadDragDropControllerOferta(std);
        PageReference pr = controller.refreshLL();

        controller.lat = 19.3352378054;
        controller.lng =  -99.1600018862;
        PageReference pr2 = controller.refreshLL();
  }
  
  
}