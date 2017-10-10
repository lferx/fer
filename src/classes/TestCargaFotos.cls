@isTest(SeeAllData=true)
private class TestCargaFotos {

    static testMethod void FotosTest() {
        
        Propiedad__c prop = new Propiedad__c();
        test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(prop);
        CargaFotosController ctrprop = new CargaFotosController(sc);
        PageReference pagina = new PageReference('/apex/CargaFotos');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);
    }
}