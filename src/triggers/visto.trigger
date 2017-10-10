trigger visto on Task (before Insert) {

	//
	if (trigger.isInsert&&trigger.isBefore){

		List<String> lAccIds = new List<String>();

		for(Task objTask: trigger.new){
			system.debug(objTask.WhatId);

			if(objTask.WhatId != null){
				String tmpId = objTask.WhatId;
				// If starts with account prefix.
				if(tmpId.startsWith('001')){
					lAccIds.add(tmpId);
				}
			}
		}
		system.debug(lAccIds);

		if(lAccIds.size()>0){

			List<Account> lAccountsUpdate = new List<Account>();
			for(Account objAccount: [Select Id, Visto__c from Account Where Id =: lAccIds]){
				objAccount.Visto__c = true;
				lAccountsUpdate.add(objAccount);
			}

			update lAccountsUpdate;
		}
	}
}