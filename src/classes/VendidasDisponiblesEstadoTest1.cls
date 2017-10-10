@isTest
public class VendidasDisponiblesEstadoTest1 {

    static testMethod void VendidasDisponiblesEstado() {

     Estados__c equisde = new Estados__c();
      equisde.Name= 'test';
      insert equisde;      
      equisde.Name='testazo';
      update equisde;

    }
}