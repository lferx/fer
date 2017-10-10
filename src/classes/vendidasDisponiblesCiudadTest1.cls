@isTest
public class vendidasDisponiblesCiudadTest1 {

    static testMethod void vendidasDisponiblesCiudad() {

     ciudad__c equisde = new ciudad__c();
      equisde.Name= 'test';
      insert equisde;      
      equisde.Name='testazo';
      update equisde;

    }
}