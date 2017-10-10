/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class UnitTest {

    static testMethod void myUnitTest() {
    	Paquete__c p = new Paquete__c();
    	insert p;
    	update p;
    	
    	Account a = new Account();
    	a.Name = 'cuenta';
    	insert a;
    	update a;
    	
    	Propiedad__c prop = new Propiedad__c();
    	prop.Name = 'BK01';
    	prop.GeneraOferta__c = true;
    	insert prop;
    	
    	Oferta__c oferta = [Select Id From Oferta__c Where Propiedad__c =: prop.Id];
    	
    	Account acc = new Account();
    	acc.Name = 'Prueba';
    	insert acc;
    	
    	 
    	Contact c = new Contact(LastName='Prueba');
    	c.AccountId = acc.Id;
    	insert c;
    	update c;
    	
    	PromotorOferta__c po = new PromotorOferta__c();
    	po.Cuenta__c = acc.Id;
    	po.Contacto__c = c.Id;
    	po.Oferta__c = oferta.Id;
    	insert po; 
    	delete po;
    	
    	ClienteOferta__c co = new ClienteOferta__c();
    	co.Cuenta__c = acc.Id;
    	co.Contacto__c = c.Id;
    	co.Oferta__c = oferta.Id;
    	insert co; 
    	delete co;
    	
    	
    	
    	
    	Documento__c d = new Documento__c();
    	insert d;
    	
    	Attachment attach = new Attachment();
    	attach.Name = 'Nuevo';
    	attach.ParentId = d.Id;
    	attach.Body = Blob.valueOf('body');
    	insert attach;
    	
    	Desalojo__c desalojo = new Desalojo__c();
    	desalojo.Oferta__c = oferta.id;
    	insert desalojo;
    }
}