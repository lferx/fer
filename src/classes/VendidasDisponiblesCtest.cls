@isTest
public class VendidasDisponiblesCtest {
static testMethod void VendidasDisponiblesEstado() {
     ColoniaFraccionamiento__c equisde = new ColoniaFraccionamiento__c();
      equisde.Name= 'test';
      insert equisde;      
      equisde.Name='testazo';
      update equisde;

    }
}