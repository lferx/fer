public class TriggerCashEntryHandler extends TriggerHandler {
	private Map<Id, c2g__codaCashEntry__c> newMap;
	private Map<Id, c2g__codaCashEntry__c> oldMap;
	private List<c2g__codaCashEntry__c> newList;
	private List<c2g__codaCashEntry__c> oldList;
 
	public TriggerCashEntryHandler() {
		this.newMap = (Map<Id, c2g__codaCashEntry__c>) trigger.newMap;
		this.oldMap = (Map<Id, c2g__codaCashEntry__c>) trigger.oldMap;
		this.newList = (List<c2g__codaCashEntry__c>) trigger.new;
		this.oldList = (List<c2g__codaCashEntry__c>) trigger.old;
	}
	
	public override void afterUpdate(){
		generaGastos('Update');
	}
	
	private void generaGastos(String tipo){
		Set<String> idsParents = new Set<String>();
		for(c2g__codaCashEntry__c item : newList){
			if(item.c2g__Status__c == 'Complete' && oldMap.get(item.Id).c2g__Status__c != item.c2g__Status__c){
				idsParents.add(item.Id);
			}
		}
		if(idsParents.size() > 0){
			List<c2g__codaCashEntryLineItem__c> lineasUpdate = new List<c2g__codaCashEntryLineItem__c>(); 
			Map<String, List<c2g__codaCashEntryLineItem__c>> mapLines = new Map<String, List<c2g__codaCashEntryLineItem__c>>();
			for(c2g__codaCashEntryLineItem__c item : [Select Id, c2g__CashEntry__c, c2g__NetValue__c From c2g__codaCashEntryLineItem__c Where c2g__CashEntry__c IN: idsParents]){
				if(!mapLines.containsKey(item.c2g__CashEntry__c)){
					mapLines.put(item.c2g__CashEntry__c, new List<c2g__codaCashEntryLineItem__c>());
				}
				mapLines.get(item.c2g__CashEntry__c).add(item);
				lineasUpdate.add(item);
			}
			update lineasUpdate;
		}
		
	}
}