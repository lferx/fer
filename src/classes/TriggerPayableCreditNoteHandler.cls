public class TriggerPayableCreditNoteHandler extends TriggerHandler {
	private Map<Id, c2g__codaPurchaseCreditNote__c> newMap;
	private Map<Id, c2g__codaPurchaseCreditNote__c> oldMap;
	private List<c2g__codaPurchaseCreditNote__c> newList;
	private List<c2g__codaPurchaseCreditNote__c> oldList;
 
	public TriggerPayableCreditNoteHandler() {
		this.newMap = (Map<Id, c2g__codaPurchaseCreditNote__c>) trigger.newMap;
		this.oldMap = (Map<Id, c2g__codaPurchaseCreditNote__c>) trigger.oldMap;
		this.newList = (List<c2g__codaPurchaseCreditNote__c>) trigger.new;
		this.oldList = (List<c2g__codaPurchaseCreditNote__c>) trigger.old;
	}
	
	public override void afterInsert(){
	}
	
	public override void afterUpdate(){
		generaGastos('Update');
	}
	
	private void generaGastos(String tipo){
		Set<String> idsParents = new Set<String>();
		for(c2g__codaPurchaseCreditNote__c nota : newList){
			if(nota.c2g__CreditNoteStatus__c == 'Complete' && oldMap.get(nota.Id).c2g__CreditNoteStatus__c != nota.c2g__CreditNoteStatus__c){
				idsParents.add(nota.Id);
			}
		}
		if(idsParents.size() > 0){
			List<c2g__codaPurchaseCreditNoteExpLineItem__c> lineasUpdate = new List<c2g__codaPurchaseCreditNoteExpLineItem__c>(); 
			Map<String, List<c2g__codaPurchaseCreditNoteExpLineItem__c>> mapLines = new Map<String, List<c2g__codaPurchaseCreditNoteExpLineItem__c>>();
			for(c2g__codaPurchaseCreditNoteExpLineItem__c item : [Select Id, c2g__PurchaseCreditNote__c, c2g__Dimension1__c, c2g__Dimension2__c, ffap__GLACode__c, c2g__NetValue__c From c2g__codaPurchaseCreditNoteExpLineItem__c Where c2g__PurchaseCreditNote__c IN: idsParents]){
				if(!mapLines.containsKey(item.c2g__PurchaseCreditNote__c)){
					mapLines.put(item.c2g__PurchaseCreditNote__c, new List<c2g__codaPurchaseCreditNoteExpLineItem__c>());
				}
				mapLines.get(item.c2g__PurchaseCreditNote__c).add(item);
				lineasUpdate.add(item);
			}
			update lineasUpdate;
			system.debug('MapLinesNCStatus: ' + newList[0].c2g__CreditNoteStatus__c + ' - ' + tipo);
			system.debug('MapLinesNC: ' + mapLines.get(newList[0].Id));
		}
		
	}
}