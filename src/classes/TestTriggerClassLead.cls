@isTest
private class TestTriggerClassLead {
	@isTest 
	static void test_method_one() {
		
		Sorteo__c sorteo = new Sorteo__c();
		sorteo.Fecha_de_inicio__c = System.today().addDays(-10);
		sorteo.Fecha_de_fin__c = System.today().addDays(10);
		sorteo.Name='La casa de tus sueños';
		
		insert sorteo;
		
		System.debug('##### sorteo Id: '+sorteo.Id);
		
		Sorteo__c sorteoPrueba = [SELECT Id, Name FROM Sorteo__c WHERE Fecha_de_inicio__c <=: System.today() AND Fecha_de_fin__c >=: System.today() ];
		
		System.debug('##### sorteoPrueba: '+sorteoPrueba);
		
		TriggerClassLead triggerClassLead = new TriggerClassLead();
		
		Configuracion_Etapa_Lead__c configuracion = new Configuracion_Etapa_Lead__c();
		
		Id promotorRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Promotor').getRecordTypeId();
		
		Account promotor = new Account();
		promotor.Name = 'Juan Loyola';
		promotor.RecordTypeId = promotorRecordTypeId;
		promotor.CLABE__c = '2321340012';
		promotor.Cuenta_bancaria__c = '0989797989898';
		promotor.Beneficiario__c = 'Rosalia';
		promotor.Banco__c ='Banamex';
		promotor.Plaza__c = 'Dif-Mex';
		
		
		insert promotor;
		
		configuracion.Name = 'Oferta';
		insert configuracion;
		
		Propiedad__c propiedad = new Propiedad__c();
		propiedad.Name = 'Las maravillas';
		propiedad.ReferenciaBanco__c = 'AA';
		propiedad.Plaza__c = 'Dif-Mex';
		propiedad.GeneraOferta__c = true;
		propiedad.Tipo__c = 'Departamento';
		propiedad.ValorCompra__c = 450000;
		propiedad.ValorReferencia__c = 450000;
		propiedad.PrecioVenta__c = 450000;
		propiedad.Terreno_m2__c = 100;
		propiedad.Construccion_m2__c = 80;
		propiedad.Estatus__c = 'Disponible';
		insert propiedad;
		
		Propiedad__c propiedad2 = new Propiedad__c();
		propiedad2.Name = 'Las maravillas 2';
		propiedad2.ReferenciaBanco__c = 'AA';
		propiedad2.Plaza__c = 'Dif-Mex';
		propiedad2.GeneraOferta__c = true;
		propiedad2.Tipo__c = 'Departamento';
		propiedad2.ValorCompra__c = 800000;
		propiedad2.ValorReferencia__c = 800000;
		propiedad2.PrecioVenta__c = 800000;
		propiedad2.Terreno_m2__c = 100;
		propiedad2.Construccion_m2__c = 80;
		propiedad2.Estatus__c = 'Disponible';
		insert propiedad2;
		
		Lead lead = new Lead();
		lead.FirstName = 'Juan';
		lead.Credito__c = 500000;
		lead.Plaza__c = 'Dif-Mex';
		lead.LastName = 'Loyola';
		lead.Company ='SNK';
		
		insert lead;
		
		lead.Credito__c = 900000;
		
		update lead;
		
		//delete lead;
		
		
	}
	
	

}