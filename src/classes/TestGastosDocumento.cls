@isTest(SeeAllData=true)
private class TestGastosDocumento {

    static testMethod void GtoDocUnitTest() {
       
		Gasto__c gasto = new Gasto__c();
        test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(gasto);
        GastosDocumentoController ctrGtosDoc = new GastosDocumentoController(sc);
        PageReference pagina = new PageReference('/apex/GastosDocumento');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);
        
       //ctrGtosDoc.getConceptoGastos();
       //ctrGtosDoc.getEtapasOferta();
       ctrGtosDoc.iniciaAgruparGastos();
        
        
        
       
       test.stopTest(); 
    }
}