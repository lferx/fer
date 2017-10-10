global class Batch_Migracion_Crear_Contactos implements Database.Batchable<sObject>, Database.Stateful {
	
	String query;
	List<Account> cuentas;
	List<Contact> contactos;
	List<Contact> contactosInsertar;
	Map<String,Account> idsCuentas;
	Map<Account,Contact> mapaCuentaContacto; 
	List<String> nombreCompleto;
	
	global Batch_Migracion_Crear_Contactos() {
		query = 'SELECT ID, RecordTypeId,type,Phone,OwnerId,name FROM Account WHERE RecordType.name = \'Lead\' AND Owner.IsActive = true';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		
		mapaCuentaContacto = new Map<Account,Contact>();
		contactosInsertar = new List<Contact>();
		cuentas = (List<Account>) scope;
		idsCuentas = new Map<String,Account>();
		nombreCompleto = new List<String>();

		for(Account reg: cuentas){
			idsCuentas.put(reg.id,reg);
			mapaCuentaContacto.put(reg,NULL);
		}

		contactos = [Select name,id,phone,OwnerId,AccountId From Contact where AccountId in :idsCuentas.keySet()];
		

		for(Contact cont: contactos){
			mapaCuentaContacto.put(idsCuentas.get(cont.AccountId),cont);
		}

		for(Account acc: mapaCuentaContacto.keySet()){
			nombreCompleto = acc.name.split(' ');
			String nombre = '';
			String apellido = '';
			Integer palabras = 0;
			for(String fragmento: nombreCompleto){
				if(palabras < (nombreCompleto.size()/2)){
					nombre += fragmento+' ';
				}
				else{
					apellido += fragmento+' ';
				}
				palabras++;
			}
			if(nombre.length()>=40){
				nombre = nombre.substring(0,38);
			}
			if(apellido.length()>=80){
				apellido = apellido.substring(0,78);
			}

			if(mapaCuentaContacto.get(acc) == NULL){
				Contact contacto = new Contact();
				contacto.OwnerId = acc.OwnerId;
				contacto.phone = acc.phone;
				contacto.Accountid = acc.id;
				contacto.firstname = nombre.trim();
				if(apellido != ''){
					contacto.lastname = apellido.trim();
				}
				else{
					contacto.lastname = '+';
				}
				contactosInsertar.add(contacto);
			}
			else{
				mapaCuentaContacto.get(acc).OwnerId = acc.OwnerId;
				mapaCuentaContacto.get(acc).phone = acc.phone;
				mapaCuentaContacto.get(acc).Accountid = acc.id;
				mapaCuentaContacto.get(acc).firstname = nombre.trim();
				if(apellido != ''){
					mapaCuentaContacto.get(acc).lastname = apellido.trim();
				}
				else{
					mapaCuentaContacto.get(acc).lastname = '+';
				}
				contactosInsertar.add(mapaCuentaContacto.get(acc));
			}
		}

		UPSERT contactosInsertar;
		nombreCompleto.clear();
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}