@isTest 
public class veCiudadTest {
static testMethod void VeCiudadTest()
{
Ciudad__c e = new Ciudad__c();
e.Name = 'edo';
insert e;
Oferta__c fer = new Oferta__c();
fer.Name='fer2';
fer.ciudad_tabla__c = e.id;
insert fer;
fer.name='fe';
update fer;
}
}