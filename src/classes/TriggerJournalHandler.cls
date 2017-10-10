public class TriggerJournalHandler extends TriggerHandler {
	private Map<Id, c2g__codaJournal__c> newMap;
	private Map<Id, c2g__codaJournal__c> oldMap;
	private List<c2g__codaJournal__c> newList;
	private List<c2g__codaJournal__c> oldList;
 
	public TriggerJournalHandler() {
		this.newMap = (Map<Id, c2g__codaJournal__c>) trigger.newMap;
		this.oldMap = (Map<Id, c2g__codaJournal__c>) trigger.oldMap;
		this.newList = (List<c2g__codaJournal__c>) trigger.new;
		this.oldList = (List<c2g__codaJournal__c>) trigger.old;
	}
	
	public override void afterUpdate(){
		generaGastos('Update');
	}
	
	private void generaGastos(String tipo){
		Set<String> idsParents = new Set<String>();
		for(c2g__codaJournal__c item : newList){
			if(item.c2g__JournalStatus__c == 'Complete' && oldMap.get(item.Id).c2g__JournalStatus__c != item.c2g__JournalStatus__c){
				idsParents.add(item.Id);
			}
		}
		if(idsParents.size() > 0){
			List<c2g__codaJournalLineItem__c> lineasUpdate = new List<c2g__codaJournalLineItem__c>(); 
			Map<String, List<c2g__codaJournalLineItem__c>> mapLines = new Map<String, List<c2g__codaJournalLineItem__c>>();
			for(c2g__codaJournalLineItem__c item : [Select Id, c2g__Journal__c, c2g__Value__c From c2g__codaJournalLineItem__c Where c2g__Journal__c IN: idsParents]){
				if(!mapLines.containsKey(item.c2g__Journal__c)){
					mapLines.put(item.c2g__Journal__c, new List<c2g__codaJournalLineItem__c>());
				}
				mapLines.get(item.c2g__Journal__c).add(item);
				lineasUpdate.add(item);
			}
			update lineasUpdate;
		}
		
	}
}