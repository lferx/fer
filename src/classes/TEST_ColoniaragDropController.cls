@isTest(seeAllData = true)
public class TEST_ColoniaragDropController {
    
    @isTest static void test_method_one() {
        Nombre_Colonias__c nom = new Nombre_Colonias__c();
        nom.name='hu';
        insert nom;
        Colonia__c Colonia  = new Colonia__c();
        Colonia.Avenidas_Importantes__c='A más de 1 Km';
        Colonia.Escuelas__c='A más de 1 Km a la redonda';
        Colonia.Estado__c='BajaCaliforniaSur';
        Colonia.Hospital__c='Más de 1 KM a la redonda   ';
        Colonia.Nombre_Ciudad__c='Test';
        Colonia.Nombre_Colonia1__c=nom.Id;
        Colonia.Precio_1__c=222;
        Colonia.Precio_2__c=222;
        Colonia.Precio_3__c=222;
        Colonia.Precio_M2__c=22;
        Colonia.Seguridad__c='Alta';
        Colonia.Tipo_Economico__c='Medio';
        Colonia.Ubicacion__Latitude__s=23.234;
        Colonia.Ubicacion__Longitude__s=43.3;

        insert Colonia;

        ApexPages.StandardController std = new ApexPages.StandardController(Colonia);
        ColoniaDragDropController controllertmp = new ColoniaDragDropController(std);
        PageReference prtmp = controllertmp.refreshLL();

        Colonia.Ubicacion__Latitude__s = 19.3352378054;
        Colonia.Ubicacion__Longitude__s = -99.1600018862;
        update Colonia;
        
        ColoniaDragDropController controller = new ColoniaDragDropController(std);
        PageReference pr = controller.refreshLL();

        controller.lat = 19.3352378054;
        controller.lng =  -99.1600018862;
        PageReference pr2 = controller.refreshLL();
    }
    
    
}