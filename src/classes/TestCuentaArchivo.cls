@isTest(SeeAllData=true)
private class TestCuentaArchivo {

    static testMethod void CuentaTest() {
         Account cta = new Account();
        test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(cta);
        CuentaArchivosController ctrprop = new CuentaArchivosController(sc);
        PageReference pagina = new PageReference('/apex/CuentaArchivos');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);
    }
}