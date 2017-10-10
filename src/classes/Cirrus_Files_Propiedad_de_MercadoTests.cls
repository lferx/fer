/**
 * Auto Generated and Deployed by Cirrus Files
 **/
@isTest
private class Cirrus_Files_Propiedad_de_MercadoTests {
    static testMethod void test_Propiedad_de_Mercado() {
        Test.startTest();
        sObject sobj = new Propiedad_de_Mercado__c();
        /* If necessary, set fields for Propiedad_de_Mercado__c validation rules **HERE** */
        sobj = IGD.CirrusFilesTests.CreateRecord(sobj);



        ColoniaFraccionamiento__c col = new ColoniaFraccionamiento__c();
        col.name = 'ksdjk';
        col.Precio_medio_de_mercado__c = 20000;
        insert col;

        //ponle id a  sobj
        Propiedad_de_Mercado__c sO = new Propiedad_de_Mercado__c();
        sO.Colonia__c= col.id;
        insert sO;

        Test.stopTest();
    }
}