@isTest

public with sharing class Trigger_Recuento_Propiedades_Test {

    static testMethod void testMethod1()

    {
    	RecordType tipoReg = [SELECT Id FROM RecordType where name = 'Matriz' limit 1];

        Account cuenta1 = new Account();
        cuenta1.RecordTypeId = tipoReg.id;
        cuenta1.name ='Name Name2 last name3';
        cuenta1.phone ='1234567853';
        cuenta1.Email__c ='MOLH88013@revimex.mx';
        cuenta1.Cuenta_Matriz__c = NULL;
        INSERT cuenta1;

        Oferta__c oferta = new Oferta__c();
        oferta.name = '12345';
        oferta.ClienteFinal__c = cuenta1.id;
        INSERT oferta;

        ClienteOferta__c clienteoferta = new ClienteOferta__c();
        clienteoferta.Cuenta__c = cuenta1.id;
        clienteoferta.Oferta__c = oferta.id;
        INSERT clienteoferta;
        

        UPDATE clienteoferta;

    }
	
}