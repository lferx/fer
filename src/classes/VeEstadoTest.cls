@isTest 
public class VeEstadoTest {  
static testMethod void VeEstadoTest()
{
Estados__c e = new Estados__c();
e.Name = 'edo';
insert e;
Oferta__c fer = new Oferta__c();
fer.Name='fer2';
fer.Estado__c = e.id;
insert fer;
fer.name='fe';
update fer;
}
}