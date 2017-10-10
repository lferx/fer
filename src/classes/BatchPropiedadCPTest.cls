@isTest
private class BatchPropiedadCPTest {
	static testmethod void test() {

		Propiedad__c p1 = new Propiedad__c(
			Colonia__c='',
			Municipio__c='',
			Estado__c='',
			GeneraOferta__c=false,
			ReferenciaBanco__c = 'A',
			Name = 'p1'
		);
		insert p1;
		
		Propiedad__c p2 = new Propiedad__c(
			Colonia__c='',
			Municipio__c='',
			Estado__c='MOR',
			GeneraOferta__c=false,
			ReferenciaBanco__c = 'A',
			Name = 'p2'
		);
		insert p2;
		
		Propiedad__c p3 = new Propiedad__c(
			Colonia__c='',
			Municipio__c='Cuernavaca',
			Estado__c='MOR',
			GeneraOferta__c=false,
			ReferenciaBanco__c = 'A',
			Name = 'p3'
		);
		//insert p3;
		
		Propiedad__c p4 = new Propiedad__c(
			Colonia__c='Adolfo',
			Municipio__c='Cuernavaca',
			Estado__c='MOR',
			GeneraOferta__c=false,
			ReferenciaBanco__c = 'A',
			Name = 'p4'
		);
		//insert p4;
		
		Propiedad__c p5 = new Propiedad__c(
			Colonia__c='Adolfo Ruiz Cortines',
			Municipio__c='Cuernavaca',
			Estado__c='MOR',
			GeneraOferta__c=false,
			ReferenciaBanco__c = 'A',
			Name = 'p5'
		);
		//insert p5;
		
		Test.startTest();
			String query = '';
			BatchPropiedadCP b = new BatchPropiedadCP();
			Database.executeBatch(b,20);
		Test.stopTest();
	}
}