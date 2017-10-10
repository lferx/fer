trigger ClienteOferta on ClienteOferta__c (before delete) {
	if(trigger.isBefore && trigger.isDelete){
		for(ClienteOferta__c co : trigger.old){
			if(co.Estatus2__c == 'Cliente final'){
				co.addError('No se puede borrar este cliente, ya que está seleccionado como cliente final de la oferta.');
			}
		}
	}
	
	if(trigger.isAfter && trigger.isUpdate){
		Set<String> setIds = new Set<String>();
		Set<String> setIdsPromotor = new Set<String>();
		for(ClienteOferta__c co : trigger.new){
			if(co.Estatus2__c == 'Cliente final' && co.PromotorId__c != null){
				setIds.add(co.Oferta__c);
				setIdsPromotor.add(co.PromotorId__c);
			}
		}
		if(setIds.size() > 0){
			Map<Id,Oferta__c> mapOfertas = new Map<Id,Oferta__c>([Select Id From Oferta__c Where Id IN: setIds AND Promotor__c NOT IN: setIdsPromotor]);
			for(ClienteOferta__c co : trigger.new){
				if(co.Estatus2__c == 'Cliente final' && co.PromotorId__c != null && mapOfertas.containsKey(co.Oferta__c)){
					mapOfertas.get(co.Oferta__c).Promotor__c = co.PromotorId__c;
				}
			}
			update mapOfertas.values();
		}
	}
}