trigger PromotorOferta on PromotorOferta__c (before delete) {
	
	if(trigger.isBefore && trigger.isDelete){
		for(PromotorOferta__c po : trigger.old){
			if(mapPromotorOferta.get(po.Id).Clientes_ofertas__r.size() > 0){
				po.addError('No se puede borrar este promotor, primero borre los clientes que se encuentran relacionados al mismo.');
			}
		}
	}
	
	private static Map<ID, PromotorOferta__c> mapPromotorOferta {
		get{
			if(mapPromotorOferta == null){
				mapPromotorOferta = new Map<ID, PromotorOferta__c>([Select Id, (Select Id From Clientes_ofertas__r) From PromotorOferta__c Where Id IN: trigger.old]);
			}
			return mapPromotorOferta; 
		}
		set;
	}
}