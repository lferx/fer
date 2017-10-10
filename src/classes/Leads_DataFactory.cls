@isTest
public class Leads_DataFactory {
	
	public static Account creaCuenta(){
		Account acc = new Account();
		acc.Name = 'test';
		acc.Origen__c = '01800';
		acc.Email__c = 'test@revimextest.com';
		Map<String, Schema.RecordTypeInfo> solicitudRecordTypeInfo = Account.SObjectType.getDescribe().getRecordTypeInfosByName();
		acc.RecordTypeId = solicitudRecordTypeInfo.get('Lead').getRecordTypeId();
		insert acc;
		return acc;
	}

	public static List<Propiedad__c> creaPropiedades(Integer cuantos){
		List<Propiedad__c> propiedades = new List<Propiedad__c>();
		for(Integer i = 1; i <= cuantos; i++){
			Propiedad__c prop = new Propiedad__c();
			prop.Name = 'propiedad prueba ' + String.valueOf(i);
			prop.CP__c = '123456';
			prop.Municipio__c = 'municipio';
			prop.Colonia__c = 'colonia';
			prop.Plaza__c = 'Aguascalientes';
			prop.N_de_Habitaciones__c = '1 Recamara';
			prop.N_de_Ba_os__c = '1 Baño';
			prop.Tipo__c = 'Departamento';
			prop.Niveles_Plantas__c = '1 Nivel';
			propiedades.add(prop);
		}
		insert propiedades;
		return propiedades;
	}
}