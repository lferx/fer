public class TriggerCashEntryLineItemHandler extends TriggerHandler {
	private Map<Id, c2g__codaCashEntryLineItem__c> newMap;
	private Map<Id, c2g__codaCashEntryLineItem__c> oldMap;
	private List<c2g__codaCashEntryLineItem__c> newList;
	private List<c2g__codaCashEntryLineItem__c> oldList;
 
	public TriggerCashEntryLineItemHandler() {
		this.newMap = (Map<Id, c2g__codaCashEntryLineItem__c>) trigger.newMap;
		this.oldMap = (Map<Id, c2g__codaCashEntryLineItem__c>) trigger.oldMap;
		this.newList = (List<c2g__codaCashEntryLineItem__c>) trigger.new;
		this.oldList = (List<c2g__codaCashEntryLineItem__c>) trigger.old;
	}
	
	public override void afterInsert(){
		
	}
	
	public override void beforeUpdate(){
		generaGastos();
	}
	
	private void generaGastos(){
		List<c2g__codaCashEntryLineItem__c> lineasPorActualizar = new List<c2g__codaCashEntryLineItem__c>();
		
		for(c2g__codaCashEntryLineItem__c line : newList){
			if(mapParents.get(line.c2g__CashEntry__c).c2g__Status__c == 'Complete' && line.Gasto__c == null && line.c2g__AccountDimension1__c != null && line.c2g__AccountDimension2__c != null){
				lineasPorActualizar.add(line);
			}
		}
		
		if(lineasPorActualizar.size() > 0){
			Map<Id, c2g__codaDimension1__c> mapDimension1 = new Map<Id, c2g__codaDimension1__c>();
			Map<Id, c2g__codaDimension2__c> mapDimension2 = new Map<Id, c2g__codaDimension2__c>();
			Map<Id, Account> mapAccounts = new Map<Id, Account>();
			for(c2g__codaCashEntryLineItem__c line : lineasPorActualizar){
				if(line.c2g__AccountDimension1__c != null){
					mapDimension1.put(line.c2g__AccountDimension1__c, null);
				}
				if(line.c2g__AccountDimension2__c != null){
					mapDimension2.put(line.c2g__AccountDimension2__c, null);
				}
				if(line.c2g__Account__c != null){
					mapAccounts.put(line.c2g__Account__c, null);
				}
			}
			mapDimension1 = new Map<Id, c2g__codaDimension1__c>([Select Id, Oferta__c From c2g__codaDimension1__c Where Id IN: mapDimension1.keySet()]);
			mapDimension2 = new Map<Id, c2g__codaDimension2__c>([Select Id, ConceptoCatalogo__c From c2g__codaDimension2__c Where Id IN: mapDimension2.keySet()]);
			mapAccounts = new Map<Id, Account>([Select Id, c2g__CODAAccountsReceivableControl__c From Account Where Id IN: mapAccounts.keySet()]);
			
			Map<Id, Gasto__c> mapNewGastos = new Map<Id,Gasto__c>();
			for(c2g__codaCashEntryLineItem__c line : lineasPorActualizar){
				Gasto__c gasto = new Gasto__c();
				gasto.Account__c = line.c2g__Account__c;
				gasto.Fecha__c = mapParents.get(line.c2g__CashEntry__c).c2g__Date__c;
				gasto.GLA__c = mapAccounts.get(line.c2g__Account__c).c2g__CODAAccountsReceivableControl__c;
				Integer valorSigno = 1;
				if(mapParents.get(line.c2g__CashEntry__c).c2g__Type__c == 'Receipt' || mapParents.get(line.c2g__CashEntry__c).c2g__Type__c == 'Payment Refund'){
					valorSigno = -1;
				}
				gasto.Importe__c = (line.c2g__NetValue__c) * valorSigno;
				gasto.Tipo__c = 'Automático';
				gasto.Fuente__c = 'Cash Entry';
				gasto.CashEntry__c = line.c2g__CashEntry__c;
				gasto.CashEntryLineItem__c = line.Id;
				if(line.c2g__AccountDimension1__c != null){
					gasto.Dimension1__c = line.c2g__AccountDimension1__c;
					gasto.Oferta__c = mapDimension1.get(line.c2g__AccountDimension1__c).Oferta__c;
				}
				
				if(line.c2g__AccountDimension2__c != null){
					gasto.Dimension2__c = line.c2g__AccountDimension2__c;
					gasto.Concepto__c = mapDimension2.get(line.c2g__AccountDimension2__c).ConceptoCatalogo__c;
				}
				//if(line.c2g__InputVATCode__c != null && mapTaxCodes.get(line.c2g__InputVATCode__c).Name == 'IVA 16%'){ 
				//	gasto.AplicarIVA__c = true;
				//}
				String comentario = '';
				if(mapParents.get(line.c2g__CashEntry__c).c2g__Description__c != null){
					comentario += mapParents.get(line.c2g__CashEntry__c).c2g__Description__c + '\n';
					
				}
				if(line.c2g__LineDescription__c != null){
					comentario += line.c2g__LineDescription__c;
				}
				gasto.Comentario__c = ' ** Cash Entry: ' + mapParents.get(line.c2g__CashEntry__c).Name + ' ** \n' + comentario ;
				
				mapNewGastos.put(line.Id, gasto);
			}
			insert mapNewGastos.values();
			
			for(c2g__codaCashEntryLineItem__c line : lineasPorActualizar){
				line.Gasto__c = mapNewGastos.get(line.Id).Id;
			}
		}
		
	}
	
	private Map<Id, c2g__codaCashEntry__c> mapParents {
		get{
			if(mapParents == null){
				Set<Id> idsParents = new Set<Id>();
				for(c2g__codaCashEntryLineItem__c line : newList){
					idsParents.add(line.c2g__CashEntry__c);
				}
				mapParents = new Map<Id, c2g__codaCashEntry__c>([Select Id, Name, c2g__Date__c, c2g__Status__c, c2g__Type__c, c2g__Description__c From c2g__codaCashEntry__c Where Id IN: idsParents]);
			}
			return mapParents;
		}set;
	}
}