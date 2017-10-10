@isTest(SeeAllData=true)
private class TestReporteEjecutivo {

    static testMethod void RepEjeTest() {
        ReporteEjecutivoController ctrRepEj = new ReporteEjecutivoController();
        PageReference pagina = new PageReference('/apex/ReporteEjecutivo');
        //pagina.getParameters().put('ido', oferta.id);
        Test.setCurrentPageReference(pagina);
        ctrRepEj.getmInfoEtapa8();
        ctrRepEj.getmInfoEtapa9();
        ctrRepEj.getmInfoEtapa101();
        ctrRepEj.getmInfoEtapa10a();
        ctrRepEj.getmInfoEtapa10b();
        ctrRepEj.getmInfoEtapa11a();
        ctrRepEj.getmInfoEtapa11b();
        ctrRepEj.getmInfoEtapa11c();
        ctrRepEj.getmInfoEtapa11d();
        ctrRepEj.getmInfoEtapa12();
        ctrRepEj.getmInfoRes();
        ctrRepEj.DetalleEtapa9();
        ctrRepEj.DetalleEtapa9a();
        ctrRepEj.DetalleEtapa101();
        ctrRepEj.DetalleEtapa101a();
        ctrRepEj.DetalleEtapa101b();
        ctrRepEj.DetalleEtapa10a1();
        ctrRepEj.DetalleEtapa10a2();
        ctrRepEj.DetalleEtapa10b();
        ctrRepEj.DetalleEtapa10b1();
        ctrRepEj.DetalleEtapa10b2();
        ctrRepEj.DetalleEtapa11a();
        ctrRepEj.DetalleEtapa11a1();
        ctrRepEj.DetalleEtapa11a2();
        ctrRepEj.DetalleEtapa11b();
        ctrRepEj.DetalleEtapa11b1();
        ctrRepEj.DetalleEtapa11b2();
        ctrRepEj.DetalleEtapa11c1();
        ctrRepEj.DetalleEtapa11c2();
        ctrRepEj.DetalleEtapa11d1();
        ctrRepEj.DetalleEtapa11d2();
        ctrRepEj.DetalleEtapa12a1();
        ctrRepEj.DetalleEtapa12a2();
        ctrRepEj.DetalleEtapa13a1();
        ctrRepEj.DetalleEtapa13a2();
    
   
        
    }
}