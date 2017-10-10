@isTest(SeeAllData=true)
private class TestReporteEjDet {

    static testMethod void RepEjeDetTest() {
        ReporteEjDetController ctrRepEj = new ReporteEjDetController();
        PageReference pagina = new PageReference('/apex/ReporteEjDet');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);
        
        
    }
}