@isTest

public with sharing class Batch_MigracionTest {

    static testMethod void testMethod1()

    {
    	RecordType tipoReg2 = [SELECT Id FROM RecordType where name = 'Lead' limit 1];
    	RecordType tipoReg = [SELECT Id FROM RecordType where name = 'Matriz' limit 1];
    	RecordType tipoReg3 = [SELECT Id FROM RecordType where name = 'Lead Cliente' limit 1];
    	//List<Account> cuentas = new List<Account>();

        Account cuenta1 = new Account();
        cuenta1.RecordTypeId = tipoReg.id;
        cuenta1.name ='Name Name2 last name3';
        cuenta1.phone ='1234567853';
        cuenta1.Email__c ='MOLH88013@revimex.mx';
        cuenta1.Cuenta_Matriz__c = NULL;
        INSERT cuenta1;

        Account cuenta2 = new Account();
        cuenta2.RecordTypeId = tipoReg2.id;
        cuenta2.name ='Name Name2 last name3';
        cuenta2.phone ='1234567493';
        cuenta2.Email__c ='MOLH80133@revimex.mx';
        cuenta2.Cuenta_Matriz__c = cuenta1.id;
        INSERT cuenta2;

        Contact contacto = new Contact();
        contacto.firstname ='Name Name2';
        contacto.lastname ='las name3';
        contacto.phone ='1234567893';
        contacto.AccountId = cuenta2.id;

        Account cuenta3 = new Account();
        cuenta3.RecordTypeId = tipoReg3.id;
        cuenta3.firstname ='Name Name2';
        cuenta3.lastname ='las name3';
        cuenta3.phone ='1234587893';
        cuenta3.Email__c ='MLH880133@revimex.mx';
        cuenta3.Cuenta_Matriz__c = NULL;
        INSERT cuenta3;

        //Account cuentaHijo1 = new Account();
        //cuentaHijo1.Name ='Name';
        //cuentaHijo1.phone ='1234567893';
        //cuentaHijo1.Email__c ='MOLH880133@revimex.mx';
        //cuentaHijo1.Cuenta_Matriz__c = cuentaMatriz.id;
        //cuentas.add(cuentaHijo1);

        //Account cuentaHijo2 = new Account();
        //cuentaHijo2.Name ='Name';
        //cuentaHijo2.phone ='1234567893';
        //cuentaHijo2.Email__c ='MOLH880133@revimex.mx';
        //cuentaHijo2.Cuenta_Matriz__c = cuentaMatriz.id;
        //cuentas.add(cuentaHijo2);

        //INSERT cuentas;

        //List<Account> cuentas2 = new List<Account>();

        //Account cuentaMatriz2 = new Account();
        //cuentaMatriz2.Name ='Name';
        //cuentaMatriz2.phone ='1234567893';
        //cuentaMatriz2.Email__c ='MOLH880133@revimex.mx';
        //cuentaMatriz2.Cuenta_Matriz__c = NULL;
        //INSERT cuentaMatriz2;

        //Account cuentaHijo3 = new Account();
        //cuentaHijo3.Name ='Name';
        //cuentaHijo3.phone ='1234567893';
        //cuentaHijo3.Email__c ='MOLH880133@revimex.mx';
        //cuentaHijo3.Cuenta_Matriz__c = cuentaMatriz2.id;
        //cuentas2.add(cuentaHijo3);

        //INSERT cuentas2;

        Test.startTest();
        	Batch_Correcion_Nombre obj4 = new Batch_Correcion_Nombre();
            DataBase.executeBatch(obj4,100);
            Batch_Migracion_Crear_Contactos obj = new Batch_Migracion_Crear_Contactos();
            DataBase.executeBatch(obj,30);
            Batch_Migracion_Leads obj2 = new Batch_Migracion_Leads();
            DataBase.executeBatch(obj2,100);
            Batch_Migracion_Crear_Matriz obj3 = new Batch_Migracion_Crear_Matriz();
            DataBase.executeBatch(obj3,100);
        Test.stopTest();
    }
	
}