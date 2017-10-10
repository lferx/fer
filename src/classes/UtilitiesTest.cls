@isTest

public class UtilitiesTest{

    static testMethod void testMethod1(){

    	RecordType tipoReg1 = [SELECT Id FROM RecordType where name = 'Matriz' limit 1];
    	RecordType tipoReg2 = [SELECT Id FROM RecordType where name = 'Lead Cliente' limit 1];

    	ID cuentaMatriz;
    	String cadena1 = 'canción<hola';
    	String cadena2;

    	List<Account> lstAccount= new List<Account>();

            

        Account acc = new Account();

        acc.Name ='Name 1';
        acc.Numero_de_Seguro_Social__c ='1234567891';
        acc.RFC__c ='MOLH880111';
        acc.CURP__c ='MOLH880113HDFRPC01';
        acc.Phone = '1111111111';
		acc.Fecha_Proxima_Credito_Infonavit__c = Date.today();
		acc.Total_credito_contado__c = 1;
		acc.Monto_Presupuesto_Efectivo__c = 1;
		acc.Nombre_Mancomunado__c = 'nameMancomunado2';
		acc.Fecha_de_nacimiento_Mancomunado__c = Date.today();
		acc.Numero_de_Seguro_Social_Mancomunado__c = '11111111111';
		//acc.Tipo_de_Credito_Infonavit_mancomunado__c = 'Infonavit';
		acc.Precalificacion_mancomunado__c = 1;
		acc.Total_mancomunado__c = 1;
		acc.Telefono_2__c = '1111111111';
		acc.Fecha_y_hora_de_la_cita__c = Date.today();
		acc.Email2__c = '2@a.com';
		acc.Origen__c = 'Google';
		acc.Forma_de_Pago__c = 'Infonavit';
		acc.Fecha_de_nacimiento__c = Date.today();
		acc.Tipo_de_Credito__c = 'Infonavit';
		acc.Numero_de_Seguro_Social__c = '11111111111';
		acc.Script_datos_lead__c = '';
		acc.Objeciones_datos_lead__c = '';
		acc.Fecha_de_Cita__c = Date.today();
		acc.Oferta__c = 'IF-123456';
		acc.Precalificacion__c = 1;
		acc.Fecha_de_Consulta__c = Date.today();
		acc.SubOrigen__c = 'Google';
		acc.Banco__c = '';
		acc.Monto_presupuesto__c = 1;
		acc.RecordTypeId = tipoReg1.id;
		acc.type = 'Matriz';
		acc.Cuenta_Lead__c = NULL;

        insert acc;

        Account acc3 = new Account();

        acc3.firstname ='Name';
        acc3.lastname ='3';
        acc3.Phone = '3333333333';
        acc3.Numero_de_Seguro_Social__c ='12345678933';
        acc3.RFC__c ='MOLH880133';
        acc3.CURP__c ='MOLH880113HDFRPC33';
		acc3.RecordTypeId = tipoReg2.id;
		acc3.type = 'Lead Cliente';


        insert acc3;

        Account acc2 = new Account();

        acc2.firstname ='Name';
        acc2.lastname ='2';
        acc2.Numero_de_Seguro_Social__c ='1234567892';
        acc2.RFC__c ='MOLH880112';
        acc2.CURP__c ='MOLH880113HDFRPC02';
		acc2.Email__c = '2@a.com';
		acc2.Phone = '2222222222';
		acc2.Fecha_Proxima_Credito_Infonavit__c = Date.today();
		acc2.Total_credito_contado__c = 2;
		acc2.Monto_Presupuesto_Efectivo__c = 2;
		acc2.Nombre_Mancomunado__c = 'nameMancomunado2';
		acc2.Fecha_de_nacimiento_Mancomunado__c = Date.today();
		acc2.Numero_de_Seguro_Social_Mancomunado__c = '22222222222';
		//acc2.Tipo_de_Credito_Infonavit_mancomunado__c = 'Infonavit';
		acc2.Precalificacion_mancomunado__c = 2;
		acc2.Total_mancomunado__c = 2;
		acc2.Telefono_2__c = '2222222222';
		acc2.Fecha_y_hora_de_la_cita__c = Date.today();
		acc2.Email2__c = '2@a.com';
		acc2.Origen__c = 'Google';
		acc2.Forma_de_Pago__c = 'Infonavit';
		acc2.Fecha_de_nacimiento__c = Date.today();
		acc2.Tipo_de_Credito__c = 'Infonavit';
		acc2.Numero_de_Seguro_Social__c = '22222222222';
		acc2.Script_datos_lead__c = '';
		acc2.Objeciones_datos_lead__c = '';
		acc2.Fecha_de_Cita__c = Date.today();
		acc2.Oferta__c = 'IF-123456';
		acc2.Promotor__c = NULL;
		acc2.Precalificacion__c = 2;
		acc2.Fecha_de_Consulta__c = Date.today();
		acc2.SubOrigen__c = 'Google';
		acc2.Banco__c = '';
		acc2.Monto_presupuesto__c = 2;
		acc2.RecordTypeId = tipoReg2.id;
		acc2.type = 'Lead Cliente';
		acc2.Cuenta_Lead__c = acc3.id;
		acc2.Cuenta_Matriz__c = NULL;

        insert acc2;



        Oferta__c oferta = new Oferta__c();

        oferta.Gerente_Operativo__c = acc3.id;

        insert oferta;

        Profile p = [select id from profile LIMIT 1]; 

        User us = new User(firstname = 'name',lastname ='3',Username = 'anmkjhhfghj@a.com', Email = 'a@a.com', Alias = 'a', CommunityNickname = 'a', TimeZoneSidKey = 'Asia/Shanghai', LocaleSidKey = 'en_US', EmailEncodingKey = 'UTF-8', ProfileId = p.id, LanguageLocaleKey = 'en_US');

        insert us;



    	Utilities utilidades = new Utilities();
        
        Test.startTest();
            
	        Utilities.accentsRemover(cadena1);
	        Utilities.accentsRemover(cadena2);
	        Utilities.ligarMatriz(acc2.id,cuentaMatriz);
	        cuentaMatriz = Utilities.buscaMatriz(acc2.id);
	        Utilities.buscaMatriz(NULL);
	        Utilities.ligarMatriz(acc2.id,cuentaMatriz);
	        Utilities.ligarMatriz(acc2.id,NULL);
	        Utilities.ligarMatriz(NULL,cuentaMatriz);
	        Utilities.ligarMatriz(NULL,NULL);
	        Utilities.generaCliente(acc2.id);
	        Utilities.cambiarPropietario(ID.valueOf(oferta.id),acc3.id);
	        Utilities.cambiarPropietario(NULL,NULL);

        Test.stopTest();


    }
}