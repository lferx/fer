public class TriggerDimension2Handler extends TriggerHandler {
	private Map<Id, c2g__codaDimension2__c> newMap;
	private Map<Id, c2g__codaDimension2__c> oldMap;
	private List<c2g__codaDimension2__c> newList;
	private List<c2g__codaDimension2__c> oldList;
 	
	public TriggerDimension2Handler() {
		this.newMap = (Map<Id, c2g__codaDimension2__c>) trigger.newMap;
		this.oldMap = (Map<Id, c2g__codaDimension2__c>) trigger.oldMap;
		this.newList = (List<c2g__codaDimension2__c>) trigger.new;
		this.oldList = (List<c2g__codaDimension2__c>) trigger.old;
	}
	
	public override void beforeUpdate(){
		for(c2g__codaDimension2__c dim : newList){
			if(dim.ConceptoCatalogo__c != null){
				dim.Name = mapConceptosCatoalogo.get(dim.ConceptoCatalogo__c).Name;
			}
		}
	}
	
	private Map<String, ConceptoCatalogo__c> mapConceptosCatoalogo{
		get{
			if(mapConceptosCatoalogo == null){
				Set<String> ids = new Set<String>();
				for(c2g__codaDimension2__c item : newList){
					ids.add(item.ConceptoCatalogo__c);
				}
				mapConceptosCatoalogo = new Map<String, ConceptoCatalogo__c>([Select Id, Name From ConceptoCatalogo__c Where Id IN: ids]);
			}
			return mapConceptosCatoalogo;
		}set;
	}
}