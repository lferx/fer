@isTest

    public with sharing class BatchGenerarMatricesTest {

        static testMethod void testMethod1()

        {

        	RecordType tipoReg = [SELECT Id FROM RecordType where name = 'Matriz' limit 1];
        	RecordType tipoReg2 = [SELECT Id FROM RecordType where name = 'Cliente' limit 1];
        	List<Account> cuentas = new List<Account>();

            Account cuentaMatriz = new Account();
            cuentaMatriz.Name ='Name';
            cuentaMatriz.phone ='1234567893';
            cuentaMatriz.Email__c ='MOLH880133@revimex.mx';
            cuentaMatriz.Cuenta_Matriz__c = NULL;
            cuentaMatriz.RecordTypeId = tipoReg.id;
            INSERT cuentaMatriz;

            Account cuentaHijo1 = new Account();
            cuentaHijo1.Name ='Name';
            cuentaHijo1.phone ='1234567893';
            cuentaHijo1.Email__c ='MOLH880133@revimex.mx';
            cuentaHijo1.Cuenta_Matriz__c = NULL;
            cuentaHijo1.RecordTypeId = tipoReg2.id;
            cuentas.add(cuentaHijo1);

            Account cuentaHijo2 = new Account();
            cuentaHijo2.Name ='NameE';
            cuentaHijo2.phone ='1234567894';
            cuentaHijo2.Email__c ='MOLH880133@revimexX.mx';
            cuentaHijo2.Cuenta_Matriz__c = NULL;
            cuentaHijo2.RecordTypeId = tipoReg2.id;
            cuentas.add(cuentaHijo2);

            Account cuentaHijo4 = new Account();
            cuentaHijo4.Name ='NameE';
            cuentaHijo4.phone ='1234567893';
            cuentaHijo4.Email__c ='MOLH880133@revimexX.mx';
            cuentaHijo4.Cuenta_Matriz__c = NULL;
            cuentaHijo4.RecordTypeId = tipoReg2.id;
            cuentas.add(cuentaHijo4);

            INSERT cuentas;

            List<Account> cuentas2 = new List<Account>();

            Account cuentaMatriz2 = new Account();
            cuentaMatriz2.Name ='Name';
            cuentaMatriz2.phone ='1234567893';
            cuentaMatriz2.Email__c ='MOLH880133@revimex.mx';
            cuentaMatriz2.Cuenta_Matriz__c = NULL;
            cuentaMatriz2.RecordTypeId = tipoReg.id;
            INSERT cuentaMatriz2;

            Account cuentaHijo3 = new Account();
            cuentaHijo3.Name ='Name';
            cuentaHijo3.phone ='1234567893';
            cuentaHijo3.Email__c ='MOLH880133@revimex.mx';
            cuentaHijo3.Cuenta_Matriz__c = cuentaMatriz2.id;
            cuentaHijo3.RecordTypeId = tipoReg2.id;
            cuentas2.add(cuentaHijo3);

            INSERT cuentas2;

            
                BatchGenerarMatrices obj = new BatchGenerarMatrices();
                DataBase.executeBatch(obj,50);
            
        }
    }