@isTest(SeeAllData=true)
private class TestGastosController {

    static testMethod void GtsoCTest() {
    	Gasto__c gasto = new Gasto__c();
        test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(gasto);
        GastosController ctrGtos = new GastosController(sc);
        PageReference pagina = new PageReference('/apex/Gastos');
        ctrGtos.getConceptoGastos();
        ctrGtos.getEtapasOferta();
        ctrGtos.obtainEtapasOferta();
        //ctrGtos.obtainGLANew();
        //ctrGtos.obtainGLA();
        //ctrGtos.addGasto();
        //ctrGtos.deleteGasto();
        ctrGtos.iniciaAgruparGastos();
    }
}