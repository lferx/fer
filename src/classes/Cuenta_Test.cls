@isTest

public with sharing class Cuenta_Test {

    static testMethod void testMethod1()

    {

    	RecordType tipoReg = [SELECT Id FROM RecordType where name = 'Matriz' limit 1];
    	RecordType tipoReg2 = [SELECT Id FROM RecordType where name = 'Lead Cliente' limit 1];
    	Profile p = [select id from profile LIMIT 1]; 

    	User us = new User(firstname = 'name',lastname ='3',Username = 'anmkjhhfghj@a.com', Email = 'a@a.com', Alias = 'a', CommunityNickname = 'a', TimeZoneSidKey = 'Asia/Shanghai', LocaleSidKey = 'en_US', EmailEncodingKey = 'UTF-8', ProfileId = p.id, LanguageLocaleKey = 'en_US');
        INSERT us;


        Account cuenta1 = new Account();
        cuenta1.RecordTypeId = tipoReg.id;
        cuenta1.name ='Name Name2 last name3';
        cuenta1.phone ='1234567853';
        cuenta1.Email__c ='MOLH88013@revimex.mx';
        cuenta1.Cuenta_Matriz__c = NULL;
        cuenta1.Estatus__c = NULL;
        cuenta1.UsuarioInversor__c = us.id;
        INSERT cuenta1;


        Test.startTest();

        
        Account acc3 = new Account();

        acc3.firstname ='Name';
        acc3.lastname ='3';
        acc3.Phone = '3333333333';
        acc3.Numero_de_Seguro_Social__c ='12345678933';
        acc3.RFC__c ='MOLH880133';
        acc3.CURP__c ='MOLH880113HDFRPC33';
		acc3.RecordTypeId = tipoReg2.id;
		acc3.type = 'Lead Cliente';
		acc3.Cuenta_Matriz__c = cuenta1.Id;

        INSERT acc3;

		cuenta1.Estatus__c = 'Activo'; 
		cuenta1.UsuarioInversor__c = NULL;       

		UPDATE cuenta1;

		cuenta1.UsuarioInversor__c = NULL;  

		UPDATE cuenta1;
        	
        Test.stopTest();
    }
	
}