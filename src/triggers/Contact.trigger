trigger Contact on Contact (before insert, before update) {
	for(Contact c : trigger.new){
		if(c.Phone != null && c.Phone.length() > 40){
			c.Phone = c.Phone.substring(0,39);
		}
		if(c.MobilePhone != null && c.MobilePhone.length() > 40){
			c.MobilePhone = c.MobilePhone.substring(0,39);
		}
		if(c.OtherPhone != null && c.OtherPhone.length() > 40){
			c.OtherPhone = c.OtherPhone.substring(0,39); 
		}
		if(c.Tipo__c == null){
			c.Tipo__c = 'Público';
		}
	}
}