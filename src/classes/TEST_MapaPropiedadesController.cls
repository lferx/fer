@isTest(seeAllData = true)
public class TEST_MapaPropiedadesController {
    
    @isTest static void test_method_one() {
        Propiedad__c propiedad  = new Propiedad__c();
        propiedad.Name = 'test';
        propiedad.Calle__c = 'Tejamanil';
        propiedad.Colonia__c = 'Santo Domingo';
        propiedad.Municipio__c = 'Coyoacan';
        propiedad.Punto__Latitude__s = 19.3352378054;
        propiedad.Punto__Longitude__s = -99.1600018862;
        insert propiedad;
        PageReference pageRef = Page.MapaPropiedades;
        MapaPropiedadesController controllertmp = new MapaPropiedadesController();
        pageRef.getParameters().put('idp',propiedad.Id);
        pageRef.getParameters().put('name',propiedad.Name);
        MapaPropiedadesController controller = new MapaPropiedadesController();
        SelectOption[] s = controller.getPropiedadExistingViews();
        List<Propiedad__c> lp = controller.getPropiedades();
        PageReference pr = controller.resetFilter();
        controller.firstPage();
        controller.next();
        controller.lastPage();
        controller.prev();
        controller.idPropiedad = (String) propiedad.Id;
        controller.cargarPropiedad();
        controller.guardar();
    }
    
    
}