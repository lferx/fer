public class TriggerCatalogoConceptoHandler extends TriggerHandler {
	private Map<Id, ConceptoCatalogo__c> newMap;
	private Map<Id, ConceptoCatalogo__c> oldMap;
	private List<ConceptoCatalogo__c> newList;
	private List<ConceptoCatalogo__c> oldList;
 	
	public TriggerCatalogoConceptoHandler() {
		this.newMap = (Map<Id, ConceptoCatalogo__c>) trigger.newMap;
		this.oldMap = (Map<Id, ConceptoCatalogo__c>) trigger.oldMap;
		this.newList = (List<ConceptoCatalogo__c>) trigger.new;
		this.oldList = (List<ConceptoCatalogo__c>) trigger.old;
	}
	
	public override void afterInsert(){
		creaDimension2();
	}
	
	public override void afterUpdate(){
		creaDimensionUpdate();
		actualizaDimensions();
	}
	
	private void creaDimension2(){
		List<c2g__codaDimension2__c> newDimensions = new List<c2g__codaDimension2__c>();
		for(ConceptoCatalogo__c ca : newList){
			c2g__codaDimension2__c dim = new c2g__codaDimension2__c();
			dim.ConceptoCatalogo__c = ca.Id;
			dim.Name = ca.Name;
			dim.c2g__ReportingCode__c = ca.ReportingCodeConcepto2__c;
			newDimensions.add(dim);
		}
		insert newDimensions;
	}
	
	private void actualizaDimensions(){
		update [Select Id From c2g__codaDimension2__c Where ConceptoCatalogo__c IN: newList];
	}
	private void creaDimensionUpdate(){
		List<c2g__codaDimension2__c> newDimensions = new List<c2g__codaDimension2__c>();
		Map<Id,c2g__codaDimension2__c> mapDimensions = new Map<Id,c2g__codaDimension2__c>();
		for(c2g__codaDimension2__c dim : [Select Id,ConceptoCatalogo__c From c2g__codaDimension2__c Where ConceptoCatalogo__c IN: newList]){
			mapDimensions.put(dim.ConceptoCatalogo__c,dim);
		} 
		for(ConceptoCatalogo__c ca : newList){
			if(!mapDimensions.containsKey(ca.Id)){
				c2g__codaDimension2__c dim = new c2g__codaDimension2__c();
				dim.ConceptoCatalogo__c = ca.Id;
				dim.Name = ca.Name;
				dim.c2g__ReportingCode__c = ca.ReportingCodeConcepto2__c;
				newDimensions.add(dim);
			}
		}
		insert newDimensions;
	}	
	
}