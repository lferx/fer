public class TriggerPaymentLineItemHandler extends TriggerHandler {
	private Map<Id, c2g__codaPaymentLineItem__c> newMap;
	private Map<Id, c2g__codaPaymentLineItem__c> oldMap;
	private List<c2g__codaPaymentLineItem__c> newList;
	private List<c2g__codaPaymentLineItem__c> oldList;
 
	public TriggerPaymentLineItemHandler() {
		this.newMap = (Map<Id, c2g__codaPaymentLineItem__c>) trigger.newMap;
		this.oldMap = (Map<Id, c2g__codaPaymentLineItem__c>) trigger.oldMap;
		this.newList = (List<c2g__codaPaymentLineItem__c>) trigger.new;
		this.oldList = (List<c2g__codaPaymentLineItem__c>) trigger.old;
	}
	
	public override void beforeInsert(){
		actualizaCampos();
	}
	public override void beforeUpdate(){
		actualizaCampos();
	}
	
	public override void afterInsert(){
		creaPaymentDetailGasto();
	}

	public override void afterUpdate(){
		creaPaymentDetailGasto();
	}
	
	private void creaPaymentDetailGasto(){
		Set<String> documentNumbers = new Set<String>();
		for(c2g__codaPaymentLineItem__c item : newList){
			if(item.c2g__DocumentNumber__c != null){
				documentNumbers.add(item.c2g__DocumentNumber__c);
			}
		}
		
		Map<String, List<Gasto__c>> mapListGastos = new Map<String, List<Gasto__c>>();
		for(Gasto__c item : [Select Id, FolioDocumentoFF__c From Gasto__c Where FolioDocumentoFF__c IN: documentNumbers]){
			if(!mapListGastos.containsKey(item.FolioDocumentoFF__c)){
				mapListGastos.put(item.FolioDocumentoFF__c, new List<Gasto__c>());
			}
			mapListGastos.get(item.FolioDocumentoFF__c).add(item);
		}
		
		Map<String, PaymentDetailGasto__c> mapPaymentDetailsGasto = new Map<String, PaymentDetailGasto__c>();
		for(PaymentDetailGasto__c item : [Select Id, PaymentDetail__c, Gasto__c From PaymentDetailGasto__c Where PaymentDetail__c IN: newList]){
			mapPaymentDetailsGasto.put(String.valueOf(item.PaymentDetail__c) + String.valueOf(item.Gasto__c), item);
		}
		List<PaymentDetailGasto__c> listNewPaymentDetailGasto = new List<PaymentDetailGasto__c>(); 
		for(c2g__codaPaymentLineItem__c item : newList){
			if(item.c2g__DocumentNumber__c != null && mapListGastos.containsKey(item.c2g__DocumentNumber__c)){
				for(Gasto__c ga : mapListGastos.get(item.c2g__DocumentNumber__c)){
					String llave = String.valueOf(item.Id) + String.valueOf(ga.Id);
					if(!mapPaymentDetailsGasto.containsKey(llave)){
						PaymentDetailGasto__c newDetailGasto = new PaymentDetailGasto__c(Payment__c = item.c2g__Payment__c, Gasto__c = ga.Id, PaymentDetail__c = item.Id);
						listNewPaymentDetailGasto.add(newDetailGasto);
					}
				}
			}
		}
		if(listNewPaymentDetailGasto.size() > 0){
			insert listNewPaymentDetailGasto;
		}
	}
	
	private void actualizaCampos(){
		Set<String> documentNumbers = new Set<String>();
		for(c2g__codaPaymentLineItem__c item : newList){
			if(item.c2g__DocumentNumber__c != null && item.DocumentoId__c == null){
				documentNumbers.add(item.c2g__DocumentNumber__c);
			}
		}
		if(documentNumbers.size() > 0){
			Map<String,String> mapaDocs = new Map<String,String>();
			for(List<SObject>searchList : [FIND :String.join(new List<String>(documentNumbers), ' OR ') IN NAME FIELDS RETURNING c2g__codaPurchaseInvoice__c(id,name), c2g__codaPurchaseCreditNote__c(id,name), c2g__codaCashEntry__c(id,name), c2g__codaJournal__c(id,name)]){
				for(SObject objeto : searchList){
					mapaDocs.put(String.valueOf(objeto.get('Name')), String.valueOf(objeto.get('Id')));
				}
			}
			for(c2g__codaPaymentLineItem__c item : newList){
				if(item.c2g__DocumentNumber__c != null && item.DocumentoId__c == null && mapaDocs.containsKey(item.c2g__DocumentNumber__c)){
					item.DocumentoId__c = mapaDocs.get(item.c2g__DocumentNumber__c);
				}
			}
		}
	}
}