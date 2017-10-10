@isTest
private class RESTProspectoSorteoController_Test {

    static testMethod void myUnitTest() {
        Account acc = new Account();
        acc.Name = 'Erik Sergio Solís Camacho';
        acc.Numero_de_Seguro_Social__c = '123456';
        insert acc;

        Test.startTest();
            Integer cantidadBoletos = RESTProspectoSorteoController.alta('Erik Sergio Solís Camacho', '123456', '01/05/2014', 'erik.solis@bleinconsulting.com', '8183355222', 'Domicilio', Double.valueOf(10000.5));
            System.assert(cantidadBoletos > 0);
        Test.stopTest();
    }

}