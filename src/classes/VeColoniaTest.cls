@isTest 
public class VeColoniaTest {
static testMethod void VeColoniaTest()
{
ColoniaFraccionamiento__c e = new ColoniaFraccionamiento__c();
e.Name = 'edo';
insert e;
Oferta__c fer = new Oferta__c();
fer.Name='fer2';
fer.colonia_busqueda__c = e.id;
insert fer;
fer.name='fe';
update fer;
}
}