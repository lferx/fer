@isTest(SeeAllData=true)
private class TestCockpitOfertas {

    static testMethod void COfertasTest() {
        CockpitOfertasController ctrCoOf = new CockpitOfertasController();
        PageReference pagina = new PageReference('/apex/ReporteEjecutivo');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);
        Test.startTest();
        ctrCoOf.filterst = 'Todos'; 
        ctrCoOf.filterzone = 'Todas'; 
        ctrCoOf.filtergte = 'Todos';
        ctrCoOf.LoadInfo();
        ctrCoOf.getlistViewOptions();
        ctrCoOf.getlistzoneoptions();
        ctrCoOf.getlistgteoptions();
        ctrCoOf.getldoc1();
        ctrCoOf.getldoc2();
        ctrCoOf.getldoc3();
        ctrCoOf.getldoc4();
        ctrCoOf.getldoc5();
        ctrCoOf.getldoc6();
        ctrCoOf.getldoc7();
        ctrCoOf.getldoc8();
        ctrCoOf.getldoc9();
        ctrCoOf.getldoc10();
        ctrCoOf.getldoc101();
        ctrCoOf.getldoc11();
        ctrCoOf.getldoc12();
        
        ctrCoOf.getldoc13();
        //ctrCoOf.Recarga();
        Test.stopTest();
    }
    static testMethod void COfertasTest2() {
        CockpitOfertasController ctrCoOf = new CockpitOfertasController();
        PageReference pagina = new PageReference('/apex/ReporteEjecutivo');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);    
        Test.startTest();
        ctrCoOf.filterst = 'Todos'; 
        ctrCoOf.filterzone = 'Todas'; 
        ctrCoOf.filtergte = 'Solcom';
        ctrCoOf.LoadInfo();
        Test.stopTest();
    }
    static testMethod void COfertasTest3() {
        CockpitOfertasController ctrCoOf = new CockpitOfertasController();
        PageReference pagina = new PageReference('/apex/ReporteEjecutivo');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);
        Test.startTest();
        ctrCoOf.filterst = 'Todos'; 
        ctrCoOf.filterzone = 'Monterrey'; 
        ctrCoOf.filtergte = 'Todos';
        ctrCoOf.LoadInfo();
        Test.stopTest();
    }
    static testMethod void COfertasTest4() {
        CockpitOfertasController ctrCoOf = new CockpitOfertasController();
        PageReference pagina = new PageReference('/apex/ReporteEjecutivo');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);
        
        Test.startTest();
        ctrCoOf.filterst = 'Oferta'; 
        ctrCoOf.filterzone = 'Todas'; 
        ctrCoOf.filtergte = 'Todos';
        ctrCoOf.LoadInfo();
        Test.stopTest();
    }
    static testMethod void COfertasTest5() {
        CockpitOfertasController ctrCoOf = new CockpitOfertasController();
        PageReference pagina = new PageReference('/apex/ReporteEjecutivo');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);  
        Test.startTest();
        ctrCoOf.filterst = 'Todos'; 
        ctrCoOf.filterzone = 'Monterrey'; 
        ctrCoOf.filtergte = 'Solcom';
        ctrCoOf.LoadInfo();
        Test.stopTest();
    }
    static testMethod void COfertasTest6() {
        CockpitOfertasController ctrCoOf = new CockpitOfertasController();
        PageReference pagina = new PageReference('/apex/ReporteEjecutivo');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);  
        Test.startTest();
        ctrCoOf.filterst = 'Oferta'; 
        ctrCoOf.filterzone = 'Monterrey'; 
        ctrCoOf.filtergte = 'Todos';
        ctrCoOf.LoadInfo();
        Test.stopTest();
    }
    static testMethod void COfertasTest7() {
        CockpitOfertasController ctrCoOf = new CockpitOfertasController();
        PageReference pagina = new PageReference('/apex/ReporteEjecutivo');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);    
        Test.startTest();
        ctrCoOf.filterst = 'Oferta'; 
        ctrCoOf.filterzone = 'Todas'; 
        ctrCoOf.filtergte = 'Solcom';
        ctrCoOf.LoadInfo();
        Test.stopTest();
    }
    static testMethod void COfertasTest8() {
        CockpitOfertasController ctrCoOf = new CockpitOfertasController();
        PageReference pagina = new PageReference('/apex/ReporteEjecutivo');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);      
        Test.startTest();
        ctrCoOf.filterst = 'Oferta'; 
        ctrCoOf.filterzone = 'Monterrey'; 
        ctrCoOf.filtergte = 'Solcom';
        ctrCoOf.LoadInfo();
        Test.stopTest();
    }
}