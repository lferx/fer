@isTest(SeeAllData=true)
private class TestExRepExcel {

    static testMethod void ExRepExcelTest() {
        ExRepEjExcelController ctrCoOf = new ExRepEjExcelController();
        PageReference pagina = new PageReference('/apex/ExRepEjExcel');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);
        Test.startTest();
         
        ctrCoOf.filterzone = 'Todas'; 
        ctrCoOf.filtergte = 'Todos';
        
        ctrCoOf.getlistzoneoptions();
        ctrCoOf.getlistgteoptions();
    }
}