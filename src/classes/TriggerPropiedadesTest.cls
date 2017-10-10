@isTest

private class TriggerPropiedadesTest {
	
	static testMethod void testMethod1(){
		
		Propiedad_de_Mercado__c propiedadMercado = new Propiedad_de_Mercado__c();

		Propiedad__c propiedadRevimex = new Propiedad__c();

		ColoniaFraccionamiento__c col = new ColoniaFraccionamiento__c();
		col.name = 'test';
		INSERT col;

		propiedadMercado.Colonia__c = col.ID;
		propiedadMercado.Precio_propiedad__c = 1;
		propiedadMercado.m2_terreno__c = 1;
		propiedadMercado.m2_construccion__c = 1;

		INSERT propiedadMercado;

		Date fecha = Date.valueOf(System.now()-2);
		Oferta__c ofer2 = new Oferta__c(
			//Name = 'test',
			PrecioVenta__c = 1,
			Propiedad__c = propiedadRevimex.id,
			Estatus__c = 'Pagada',
			FechaPago__c = fecha,
			ValorReferencia__c = 391000
			);

		INSERT ofer2;

		//SELECT id,name,Colonia_Busqueda__c,Oferta_Valor_Referencia__c,Terreno_m2__c,Construccion_m2__c FROM Propiedad__c WHERE Colonia_Busqueda__c in :allID AND Oferta__r.Estatus__c != 'Descartada' AND Oferta__r.FechaPago__c != NULL AND Colonia_Busqueda__c != NULL AND Oferta_Valor_Referencia__c != NULL AND Terreno_m2__c != NULL AND Construccion_m2__c != NULL AND Oferta_Valor_Referencia__c > 0 AND Terreno_m2__c > 0 AND Construccion_m2__c > 0

		propiedadRevimex.Name = 'test';
		propiedadRevimex.Oferta__c = ofer2.id;
		propiedadRevimex.ltima_Oferta__c = ofer2.id;
		propiedadRevimex.Colonia_Busqueda__c = col.ID;
		propiedadRevimex.Terreno_m2__c = 100;
		propiedadRevimex.Construccion_m2__c = 200;

		INSERT propiedadRevimex;


		Oferta__c ofer = new Oferta__c(PrecioVenta__c = 1, Propiedad__c = propiedadRevimex.id);

		INSERT ofer;

		Propiedad__c prop = [SELECT Oferta_Valor_Referencia__c FROM Propiedad__c WHERE id = :propiedadRevimex.id];

		UPDATE propiedadMercado;

		UPDATE prop;




		Propiedad_de_Mercado__c propiedadMercado2 = new Propiedad_de_Mercado__c();
		propiedadMercado2.Colonia__c = col.ID;
		propiedadMercado2.Precio_propiedad__c = 6;
		propiedadMercado2.m2_terreno__c = 6;
		propiedadMercado2.m2_construccion__c = 6;
		
		INSERT propiedadMercado2;

		Propiedad__c propiedadRevimex2 = new Propiedad__c();
		propiedadRevimex2.name = 'test2';
		propiedadRevimex2.Oferta__c = ofer2.id;
		propiedadRevimex2.ltima_Oferta__c = ofer2.id;
		propiedadRevimex2.Colonia_Busqueda__c = col.ID;
		propiedadRevimex2.Terreno_m2__c = 6;
		propiedadRevimex2.Construccion_m2__c = 6;

		INSERT propiedadRevimex2;
		

		Propiedad__c prop2 = [SELECT Oferta_Valor_Referencia__c FROM Propiedad__c WHERE id = :propiedadRevimex.id];

		UPDATE propiedadMercado2;

		UPDATE prop2;
	}
	
	
}