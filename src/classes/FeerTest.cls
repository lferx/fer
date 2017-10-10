@isTest
public class FeerTest {
	static testMethod void VeEstadoTest(){
		Estados__c edo = new Estados__c();
		edo.Name = 'edo';
		insert edo;

		ColoniaFraccionamiento__c col = new ColoniaFraccionamiento__c();
		col.Name = 'edo';
		insert col;

		Ciudad__c cd = new Ciudad__c();
		cd.Name = 'edo';
		insert cd;


		Oferta__c oferta = new Oferta__c();
		oferta.Name='oferta2';
		oferta.Estado__c = edo.id;
		oferta.ciudad_tabla__c = cd.id;
		oferta.colonia_busqueda__c = col.id;
		oferta.FechaPago__c = system.today();
		insert oferta;
		oferta.Etapa__c = 'Compilación expediente compra';
		update oferta;
		oferta.Etapa__c = 'Finalizada';
		update oferta;
		oferta.FechaCobro__c=system.today();
		update oferta;
	}
}