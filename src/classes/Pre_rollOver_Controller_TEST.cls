@isTest
private class Pre_rollOver_Controller_TEST {
	
	@isTest static void test_method_one() {
		// Implement test code
	     
		Pre_rollOver_Controller cls = new Pre_rollOver_Controller();
		RecordType registroId= new RecordType();

		registroId=[SELECT Id FROM RecordType where Name = 'Lead Inversionista'];

		Account lead1 = new Account();
		
		lead1.firstname ='daniel';
		lead1.lastname = 'redondo';
		lead1.phone = '1111111111';
		lead1.RecordTypeId = registroId.id;

		UPSERT lead1;
		cls.guardarDatos();
		cls.leadCliente.firstName = 'daniel';
		cls.leadCliente.lastName = 'redondo';
		cls.leadCliente.phone = '1111111111';
		cls.leadCliente.RecordTypeId = registroId.id;

		//cls.leadCliente.RecordTypeId = registroId.id;
		UPSERT cls.leadCliente;
		cls.guardarDatos();
		//cls.leadCliente.firstName = 'nombre de prueba';

		cls.leadCliente.Phone = '4444444444';
		cls.leadCliente.Tipo_de_Credito__c='Sin_Relación_Laboral';
		cls.leadCliente.RecordTypeId = registroId.id;
		cls.leadCliente.Type='Lead Inversionista';


		cls.guardarDatos();
		cls.createNewLead();
		cls.leadCliente.Precalificacion__c=0;
		cls.cambioTipoCredito();
		cls.leadCliente.Precalificacion__c=1;
		cls.cambioTipoCredito();
		cls.leadCliente.Precalificacion__c=250000;
		cls.cambioTipoCredito();
		cls.leadCliente.Fecha_de_Nacimiento__c=System.today();
		cls.menorDate();
		cls.leadCliente.PersonEmail='hola';
		cls.checkEmail();
		cls.leadCliente.RecordTypeId = registroId.id;
		
		


		//cls.leadCliente.PersonEmail='hola@g.com';
		cls.validaEstrellaPhone();
		cls.getListaOrigenes();
		cls.getListaPlazas();
		//cls.getPicklistValues();

	}
	
}