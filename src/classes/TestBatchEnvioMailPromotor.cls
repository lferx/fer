@isTest
private class TestBatchEnvioMailPromotor {
	
	@isTest
	static void test_method_one() {
		
		Test.startTest();
		
			Id devRecordTypeIdCliente  = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
			Id devRecordTypeIdPromotor = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Promotor').getRecordTypeId();
			
			Account promotor = new Account();
			promotor.Name = 'Juan Loyola';
			promotor.RecordTypeId = devRecordTypeIdPromotor;
			promotor.CLABE__c = '2321340012';
			promotor.Cuenta_bancaria__c = '0989797989898';
			promotor.Beneficiario__c = 'Rosalia';
			promotor.Banco__c ='Banamex';
			promotor.Plaza__c = 'Dif-Mex';
			
			insert promotor;
			
			
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
			
			Account cliente = new Account();
			cliente.Name = 'Juan Loyola';
			cliente.RecordTypeId = devRecordTypeIdCliente;
			cliente.CLABE__c = '2321340012';
			cliente.Cuenta_bancaria__c = '0989797989898';
			cliente.Beneficiario__c = 'Rosalia';
			cliente.Banco__c ='Banamex';
			cliente.Plaza__c = 'Dif-Mex';
			cliente.Promotor__c = promotor.Id;
			
			insert cliente;
			
			List<Oferta__c> lstOferta = [SELECT Id FROM Oferta__c LIMIT 100];
			List<ClienteOferta__c> lstCO = new List<ClienteOferta__c>();
			
			for(Oferta__c oferta :lstOferta){
				ClienteOferta__c co = new ClienteOferta__c();
				co.Cuenta__c = cliente.Id;
				co.Oferta__c = oferta.Id;
			}
			
			insert lstCO;
		
		
		
			SchedulerEnvioMailPromotor sh1 = new SchedulerEnvioMailPromotor();
			String sch = '0 0 1 * * ?'; 
			system.schedule('Test Territory Check', sch, sh1); 
			
		
			String query =  ' SELECT ' 
		               		+' Id, '
		               		+' Name, '
					   		+' Promotor__c, '
					   		+' Precalificacion__c, '
					   		+' Email__c, '
					   		+' Phone, '
					   		+' Notificado_al_promotor__c  '
		               		+' FROM Account WHERE Notificado_al_promotor__c = false AND RecordTypeId =\''+devRecordTypeIdCliente+'\'';
		              
			//Id batchInstanceId = Database.executeBatch(new BatchEnvioMailPromotor(query),5);
			
		Test.stopTest();
		
	}

}