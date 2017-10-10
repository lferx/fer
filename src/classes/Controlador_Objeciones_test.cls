@isTest
private class Controlador_Objeciones_test {
    
    static testmethod void test_method_one() {
        

        Objecion__c objecion = new Objecion__c(name = 'a',mensaje__c = 'b');
        INSERT objecion;

        Script__c script = new Script__c(name = 'a',mensaje__c = 'b');
        INSERT script;

        Test.startTest();

        Controlador_Objeciones objeto = new Controlador_Objeciones();
        objeto.pasoName = 'hola';
 
        Test.stopTest();

    }
    
    
}