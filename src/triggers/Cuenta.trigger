trigger Cuenta on Account (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {

	//Variables Hector
	Map<String,Account> mapaEstatus = new Map<String,Account>();
	List<Account> listaCuentas = new List<Account>();
	//Variables Hector
	
	if(trigger.isBefore && (trigger.isUpdate || trigger.isInsert)){
		for(Account a : trigger.new){
			if(a.RecordTypeId != null){
				a.Type = Constants.MAP_RECORDTYPES_ID.get(a.RecordTypeId).Name;
			}
		}
	}
	
	if(trigger.isUpdate && trigger.isAfter){
		for(Account account : trigger.new){
			if(account.UsuarioInversor__c != trigger.oldMap.get(account.Id).UsuarioInversor__c){
				if(trigger.new.size() == 1){
					Database.executeBatch(new BatchCuenta(account.Id,trigger.oldMap.get(account.Id).UsuarioInversor__c, account.UsuarioInversor__c ),1);
				}else{
					account.addError('No puede actualizar más de un usuario inversor a la vez.');
				}
			}
	//Empieza codigo Hector Morales
			if(account.Estatus__c != NULL){
				if(account.type == 'Matriz'){
					mapaEstatus.put(account.id,account);
				}
			}
		}

		for(Account reg: [SELECT id,Estatus__c,Cuenta_Matriz__c FROM Account WHERE Cuenta_Matriz__c IN :mapaEstatus.keyset()]){
			reg.Estatus__c = mapaEstatus.get(reg.Cuenta_Matriz__c).Estatus__c;
			listaCuentas.add(reg);
		}

		if(listaCuentas.size()>0){
			UPDATE listaCuentas;
		}
		
	//Termina codigo Hector Morales

	}


	new TriggerAccountHandler().run();
}