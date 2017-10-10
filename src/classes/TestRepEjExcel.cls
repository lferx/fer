@isTest(SeeAllData=true)
private class TestRepEjExcel {

    static testMethod void RepEjExcelTest() {
        RepEjExcelController ctrRepEj = new RepEjExcelController();
        PageReference pagina = new PageReference('/apex/RepEjExcel');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);
    }
}