@isTest

    public with sharing class BatchPropiedadesARevisarTest {

        static testMethod void testMethod1()

        {
        	List<Account> cuentas = new List<Account>();

            Account cuentaMatriz = new Account();
            cuentaMatriz.Name ='Name';
            cuentaMatriz.phone ='1234567893';
            cuentaMatriz.Email__c ='MOLH880133@revimex.mx';
            cuentaMatriz.Cuenta_Matriz__c = NULL;
            INSERT cuentaMatriz;

            Account cuentaHijo1 = new Account();
            cuentaHijo1.Name ='Name';
            cuentaHijo1.phone ='1234567893';
            cuentaHijo1.Email__c ='MOLH880133@revimex.mx';
            cuentaHijo1.Cuenta_Matriz__c = cuentaMatriz.id;
            cuentas.add(cuentaHijo1);

            Account cuentaHijo2 = new Account();
            cuentaHijo2.Name ='Name';
            cuentaHijo2.phone ='1234567893';
            cuentaHijo2.Email__c ='MOLH880133@revimex.mx';
            cuentaHijo2.Cuenta_Matriz__c = cuentaMatriz.id;
            cuentas.add(cuentaHijo2);

            INSERT cuentas;

            List<Account> cuentas2 = new List<Account>();

            Account cuentaMatriz2 = new Account();
            cuentaMatriz2.Name ='Name';
            cuentaMatriz2.phone ='1234567893';
            cuentaMatriz2.Email__c ='MOLH880133@revimex.mx';
            cuentaMatriz2.Cuenta_Matriz__c = NULL;
            INSERT cuentaMatriz2;

            Account cuentaHijo3 = new Account();
            cuentaHijo3.Name ='Name';
            cuentaHijo3.phone ='1234567893';
            cuentaHijo3.Email__c ='MOLH880133@revimex.mx';
            cuentaHijo3.Cuenta_Matriz__c = cuentaMatriz2.id;
            cuentas2.add(cuentaHijo3);

            INSERT cuentas2;

            Test.startTest();
                BatchPropiedadesARevisar obj = new BatchPropiedadesARevisar();
                DataBase.executeBatch(obj,100);
            Test.stopTest();
        }
    }