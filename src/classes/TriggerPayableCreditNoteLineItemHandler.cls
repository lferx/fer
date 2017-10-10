public class TriggerPayableCreditNoteLineItemHandler extends TriggerHandler {
	private Map<Id, c2g__codaPurchaseCreditNoteExpLineItem__c> newMap;
	private Map<Id, c2g__codaPurchaseCreditNoteExpLineItem__c> oldMap;
	private List<c2g__codaPurchaseCreditNoteExpLineItem__c> newList;
	private List<c2g__codaPurchaseCreditNoteExpLineItem__c> oldList;
 
	public TriggerPayableCreditNoteLineItemHandler() {
		this.newMap = (Map<Id, c2g__codaPurchaseCreditNoteExpLineItem__c>) trigger.newMap;
		this.oldMap = (Map<Id, c2g__codaPurchaseCreditNoteExpLineItem__c>) trigger.oldMap;
		this.newList = (List<c2g__codaPurchaseCreditNoteExpLineItem__c>) trigger.new;
		this.oldList = (List<c2g__codaPurchaseCreditNoteExpLineItem__c>) trigger.old;
	}
	
	public override void afterInsert(){
		
	}
	
	public override void beforeUpdate(){
		generaGastos();
	}
	
	private void generaGastos(){
		List<c2g__codaPurchaseCreditNoteExpLineItem__c> lineasPorActualizar = new List<c2g__codaPurchaseCreditNoteExpLineItem__c>();
		
		for(c2g__codaPurchaseCreditNoteExpLineItem__c line : newList){
			if(mapCreditNotes.get(line.c2g__PurchaseCreditNote__c).c2g__CreditNoteStatus__c == 'Complete' && line.Gasto__c == null && line.c2g__Dimension1__c != null && line.c2g__Dimension2__c != null){
				lineasPorActualizar.add(line);
			}
		}
		
		if(lineasPorActualizar.size() > 0){
			Map<Id, c2g__codaDimension1__c> mapDimension1 = new Map<Id, c2g__codaDimension1__c>();
			Map<Id, c2g__codaDimension2__c> mapDimension2 = new Map<Id, c2g__codaDimension2__c>();
			Map<Id, c2g__codaTaxCode__c> mapTaxCodes = new Map<Id, c2g__codaTaxCode__c>(); 
			for(c2g__codaPurchaseCreditNoteExpLineItem__c line : lineasPorActualizar){
				if(line.c2g__Dimension1__c != null){
					mapDimension1.put(line.c2g__Dimension1__c, null);
				}
				if(line.c2g__Dimension2__c != null){
					mapDimension2.put(line.c2g__Dimension2__c, null);
				}
				if(line.c2g__InputVATCode__c != null){
					mapTaxCodes.put(line.c2g__InputVATCode__c, null);
				}
			}
			mapDimension1 = new Map<Id, c2g__codaDimension1__c>([Select Id, Oferta__c From c2g__codaDimension1__c Where Id IN: mapDimension1.keySet()]);
			mapDimension2 = new Map<Id, c2g__codaDimension2__c>([Select Id, ConceptoCatalogo__c From c2g__codaDimension2__c Where Id IN: mapDimension2.keySet()]);
			mapTaxCodes = new Map<Id, c2g__codaTaxCode__c>([Select Id, Name From c2g__codaTaxCode__c Where Id IN: mapTaxCodes.keySet()]);
			
			Map<Id, Gasto__c> mapNewGastos = new Map<Id,Gasto__c>();
			for(c2g__codaPurchaseCreditNoteExpLineItem__c line : lineasPorActualizar){
				Gasto__c gasto = new Gasto__c();
				gasto.Account__c = mapCreditNotes.get(line.c2g__PurchaseCreditNote__c).c2g__Account__c;
				gasto.Fecha__c = mapCreditNotes.get(line.c2g__PurchaseCreditNote__c).c2g__CreditNoteDate__c;
				gasto.GLA__c = line.c2g__GeneralLedgerAccount__c;
				gasto.Importe__c = (line.c2g__NetValue__c)*-1;
				gasto.Tipo__c = 'Automático';
				gasto.Fuente__c = 'Payable Credit Note';
				gasto.PayableCreditNote__c = line.c2g__PurchaseCreditNote__c;
				gasto.PayableCreditNoteExpenseLineItem__c = line.Id;
				if(line.c2g__Dimension1__c != null){
					gasto.Dimension1__c = line.c2g__Dimension1__c;
					gasto.Oferta__c = mapDimension1.get(line.c2g__Dimension1__c).Oferta__c;
				}
				
				if(line.c2g__Dimension2__c != null){
					gasto.Dimension2__c = line.c2g__Dimension2__c;
					gasto.Concepto__c = mapDimension2.get(line.c2g__Dimension2__c).ConceptoCatalogo__c;
				}
				if(line.c2g__InputVATCode__c != null && mapTaxCodes.get(line.c2g__InputVATCode__c).Name == 'IVA 16%'){ 
					gasto.AplicarIVA__c = true;
				}
				String comentario = '';
				if(mapCreditNotes.get(line.c2g__PurchaseCreditNote__c).c2g__CreditNoteDescription__c != null){
					comentario += mapCreditNotes.get(line.c2g__PurchaseCreditNote__c).c2g__CreditNoteDescription__c + '\n';
					
				}
				if(line.c2g__LineDescription__c != null){
					comentario += line.c2g__LineDescription__c;
				}
				gasto.Comentario__c = ' ** Nota de Crédito: ' + mapCreditNotes.get(line.c2g__PurchaseCreditNote__c).Name + ' ** \n' + comentario ;
				
				mapNewGastos.put(line.Id, gasto);
			}
			insert mapNewGastos.values();
			
			for(c2g__codaPurchaseCreditNoteExpLineItem__c line : lineasPorActualizar){
				line.Gasto__c = mapNewGastos.get(line.Id).Id;
			}
		}
		
	}
	
	private Map<Id, c2g__codaPurchaseCreditNote__c> mapCreditNotes {
		get{
			if(mapCreditNotes == null){
				Set<Id> idsParents = new Set<Id>();
				for(c2g__codaPurchaseCreditNoteExpLineItem__c line : newList){
					idsParents.add(line.c2g__PurchaseCreditNote__c);
				}
				mapCreditNotes = new Map<Id, c2g__codaPurchaseCreditNote__c>([Select Id, Name, c2g__CreditNoteStatus__c, c2g__Account__c, c2g__CreditNoteDate__c, c2g__CreditNoteDescription__c From c2g__codaPurchaseCreditNote__c Where Id IN: idsParents]);
			}
			return mapCreditNotes;
		}set;
	}
	
	
}