@isTest
private class authcontrollertest {

    static testMethod void test_method_one()
    {

		Estados__c e = new Estados__c();
		e.Name = 'edo';
		insert e;

		Ciudad__c c = new Ciudad__c();
		e.Name = 'edo';
		insert c;



    	oferta__c oferta=new oferta__c ();
    	oferta.name='prueba';
    	oferta.CosteDesalojo2__c=1000;
    	oferta.ValorReferencia__c=199999;
    	oferta.montocredito__c=10000;
    	oferta.estado__c=e.id;
    	oferta.ciudad_tabla__c=c.id;

    	insert oferta;

    	autorizacion__c auto=new autorizacion__c();
    	auto.ofertas__c=oferta.id;
    	auto.broker__c=0.02;
    	auto.tipo__c='ofertas';
    	auto.preciov__c=1000;
    	auto.montocarta__c=10;
    	auto.tipo__c='Carta de Instrucción';
    	auto.montoeditado__c=1000;
    	insert auto;



    	Test.startTest();

    	PageReference pageRef = Page.auth;
        pageRef.getParameters().put('idx', String.valueOf(auto.id));
        Test.setCurrentPage(pageRef);


        authcontroller fertest = new authcontroller();
        fertest.abrir();
        fertest.dat();

        fertest.busqueda=oferta.id;
        fertest.search();
        fertest.obt();
        fertest.obs();
        fertest.obd();
        fertest.mine();
        fertest.idauto=auto.id;
        fertest.autorizar();
        fertest.noautorizar();
        fertest.validar();
        fertest.descartar();

        Test.stopTest();

    }

}