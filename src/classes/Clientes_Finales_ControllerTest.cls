@isTest

    public with sharing class Clientes_Finales_ControllerTest {

        static testMethod void testMethod1()

        {

        	RecordType tipoReg2 = [SELECT Id FROM RecordType where name = 'Cliente' limit 1];
        	List<Account> cuentas = new List<Account>();
        	
            Account nuevoLead = new Account();
            nuevoLead.Name ='Name';
            nuevoLead.phone ='1234567893';
            nuevoLead.Email__c ='MOLH880133@revimex.mx';
            nuevoLead.Cuenta_Matriz__c = NULL;
            nuevoLead.RecordTypeId = tipoReg2.id;
            cuentas.add(nuevoLead);

            Account cuentaHijo2 = new Account();
            cuentaHijo2.Name ='NameE';
            cuentaHijo2.phone ='1234567894';
            cuentaHijo2.Email__c ='MOLH880133@revimexX.mx';
            cuentaHijo2.Cuenta_Matriz__c = NULL;
            cuentaHijo2.RecordTypeId = tipoReg2.id;
            cuentas.add(cuentaHijo2);

            INSERT cuentas;

            ApexPages.StandardController stdController = new ApexPages.StandardController(nuevoLead);
            List<Account> clintesFinales = new List<Account>();
			String idPaqueteOfertas = nuevoLead.id;

            Test.startTest();
                Clientes_Finales_Controller objeto = new Clientes_Finales_Controller(stdController);
                
            Test.stopTest();
        }
    }