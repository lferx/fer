public class TriggerPayableExpenseLineItemHandler extends TriggerHandler {
	private Map<Id, c2g__codaPurchaseInvoiceExpenseLineItem__c> newMap;
	private Map<Id, c2g__codaPurchaseInvoiceExpenseLineItem__c> oldMap;
	private List<c2g__codaPurchaseInvoiceExpenseLineItem__c> newList;
	private List<c2g__codaPurchaseInvoiceExpenseLineItem__c> oldList;
 
	public TriggerPayableExpenseLineItemHandler() {
		this.newMap = (Map<Id, c2g__codaPurchaseInvoiceExpenseLineItem__c>) trigger.newMap;
		this.oldMap = (Map<Id, c2g__codaPurchaseInvoiceExpenseLineItem__c>) trigger.oldMap;
		this.newList = (List<c2g__codaPurchaseInvoiceExpenseLineItem__c>) trigger.new;
		this.oldList = (List<c2g__codaPurchaseInvoiceExpenseLineItem__c>) trigger.old;
	}
	
	public override void afterInsert(){
		if(TriggerUtils.origenProceso == null){
			TriggerUtils.origenProceso = TriggerUtils.OrigenTrigger.FROM_PILI;
		}
		actualizaGastosInsert();
		creaGastosAutomaticos();
	}
	
	public override void afterUpdate(){
		if(TriggerUtils.origenProceso == null){
			TriggerUtils.origenProceso = TriggerUtils.OrigenTrigger.FROM_PILI;
		}
		
		if(TriggerUtils.origenProceso == TriggerUtils.OrigenTrigger.FROM_PILI){
			actualizaGastosUpdate();
			creaGastosAutomaticos();
		} 
		
	}
	
	private void creaGastosAutomaticos(){
		List<Gasto__c> listaGastos = new List<Gasto__c>();
		
		for(c2g__codaPurchaseInvoiceExpenseLineItem__c lineItem : newList){
			if(lineItem.Gasto__c == null && lineItem.c2g__Dimension1__c != null && lineItem.c2g__Dimension2__c != null){
				Gasto__c ga = new Gasto__c();
				ga.Tipo__c = 'Automático';
				ga.Fuente__c = 'Payable Invoice';
				ga.Oferta__c = mapDimension1.get(lineItem.c2g__Dimension1__c).Oferta__c;
				ga.Concepto__c = mapDimension2.get(lineItem.c2g__Dimension2__c).ConceptoCatalogo__c;
				ga.Account__c = mapParents.get(lineItem.c2g__PurchaseInvoice__c).c2g__Account__c;
				ga.Fecha__c = mapParents.get(lineItem.c2g__PurchaseInvoice__c).c2g__InvoiceDate__c;
				ga.Comentario__c = lineItem.c2g__LineDescription__c;
				ga.GLA__c = lineItem.c2g__GeneralLedgerAccount__c;
				ga.PayableInvoiceExpenseLineItem__c = lineItem.Id;
				ga.PayableInvoice__c = lineItem.c2g__PurchaseInvoice__c;
				ga.Importe__c = lineItem.c2g__NetValue__c;
				
				if(lineItem.c2g__Dimension1__c != null){
					ga.Dimension1__c = lineItem.c2g__Dimension1__c;
					ga.Oferta__c = mapDimension1.get(lineItem.c2g__Dimension1__c).Oferta__c;
				}
				
				if(lineItem.c2g__Dimension2__c != null){
					ga.Dimension2__c = lineItem.c2g__Dimension2__c;
					ga.Concepto__c = mapDimension2.get(lineItem.c2g__Dimension2__c).ConceptoCatalogo__c;
				}
				
				if(lineItem.c2g__InputVATCode__c != null && mapTaxCodes.get(lineItem.c2g__InputVATCode__c).Name == 'IVA 16%'){ 
					ga.AplicarIVA__c = true;
				}
				
				String comentario = '';
				if(mapParents.get(lineItem.c2g__PurchaseInvoice__c).c2g__InvoiceDescription__c != null){
					comentario += mapParents.get(lineItem.c2g__PurchaseInvoice__c).c2g__InvoiceDescription__c + '\n';
					
				}
				if(lineItem.c2g__LineDescription__c != null){
					comentario += lineItem.c2g__LineDescription__c;
				}
				ga.Comentario__c = ' ** Payable Invoice: ' + mapParents.get(lineItem.c2g__PurchaseInvoice__c).Name + ' ** \n' + comentario ;
				
				
				listaGastos.add(ga);
			}
		}
		if(listaGastos.size() > 0){
			insert listaGastos;
			Map<String,String> mapFacturaGasto = new Map<String,String>();
			for(Gasto__c ga : listaGastos){
				mapFacturaGasto.put(ga.PayableInvoiceExpenseLineItem__c, ga.Id);
			}
			TriggerPayableExpenseLineItemHandler.actualizaFacturasFuture(mapFacturaGasto);
		}
	}
	
	@future
	public static void actualizaFacturasFuture(Map<String,String> mapFacturaGasto){
		List<c2g__codaPurchaseInvoiceExpenseLineItem__c> lista = [Select Id From c2g__codaPurchaseInvoiceExpenseLineItem__c Where Id IN: mapFacturaGasto.keySet()];
		for(c2g__codaPurchaseInvoiceExpenseLineItem__c item : lista){
			item.Gasto__c = mapFacturaGasto.get(item.Id);
		}
		update lista;
	}
	
	Map<String, c2g__codaPurchaseInvoice__c> mapParents {
		get{
			if(mapParents == null){
				Set<Id> ids = new Set<Id>();
				for(c2g__codaPurchaseInvoiceExpenseLineItem__c item : newList){
					ids.add(item.c2g__PurchaseInvoice__c);
				}
				mapParents = new Map<String, c2g__codaPurchaseInvoice__c>([Select Id, Name, c2g__InvoiceDate__c, c2g__Account__c, c2g__InvoiceDescription__c From c2g__codaPurchaseInvoice__c Where Id IN: ids]);
			}
			return mapParents;
		}set;
	}
	
	Map<String, c2g__codaDimension1__c> mapDimension1 {
		get{
			if(mapDimension1 == null){
				Set<Id> ids = new Set<Id>();
				for(c2g__codaPurchaseInvoiceExpenseLineItem__c item : newList){
					ids.add(item.c2g__Dimension1__c);
				}
				mapDimension1 = new Map<String, c2g__codaDimension1__c>([Select Id, Oferta__c From c2g__codaDimension1__c Where Id IN: ids]);
			}
			return mapDimension1;
		}set;
	}
	
	Map<Id, c2g__codaTaxCode__c> mapTaxCodes {
		get{
			if(mapTaxCodes == null){
				mapTaxCodes = new Map<Id, c2g__codaTaxCode__c>([Select Id, Name From c2g__codaTaxCode__c]);
			}
			return mapTaxCodes;
		}set;
	}
	
	
	
	Map<String, c2g__codaDimension2__c> mapDimension2 {
		get{
			if(mapDimension2 == null){
				Set<Id> ids = new Set<Id>();
				for(c2g__codaPurchaseInvoiceExpenseLineItem__c item : newList){
					ids.add(item.c2g__Dimension2__c);
				}
				mapDimension2 = new Map<String, c2g__codaDimension2__c>([Select Id, ConceptoCatalogo__c From c2g__codaDimension2__c Where Id IN: ids]);
			}
			return mapDimension2;
		}set;
	}
	
	
	private void actualizaGastosInsert(){
		Map<String, Map<String,String>> mapActualizaGastosCampos = new Map<String, Map<String,String>>();
		for(c2g__codaPurchaseInvoiceExpenseLineItem__c lineItem : newList){
			if(lineItem.Gasto__c != null && (mapGastos.get(lineItem.Gasto__c).PayableInvoiceExpenseLineItem__c == null || mapGastos.get(lineItem.Gasto__c).PayableInvoiceExpenseLineItem__c != lineItem.Id)){
				mapActualizaGastosCampos.put(lineItem.Gasto__c, new Map<String,String>());
				mapActualizaGastosCampos.get(lineItem.Gasto__c).put('PayableInvoiceExpenseLineItem__c', lineItem.Id);
				mapActualizaGastosCampos.get(lineItem.Gasto__c).put('PayableInvoice__c', lineItem.c2g__PurchaseInvoice__c);
			}
		}
		if(mapActualizaGastosCampos.size() > 0){
			TriggerPayableExpenseLineItemHandler.actualizaGastosFuture(mapActualizaGastosCampos);
		}
	}
	
	public static void actualizaGastosFuture(Map<String, Map<String,String>> mapActualizaGastos){
		List<Gasto__c> lista = [Select Id, Oferta__c, PayableInvoice__c, PayableInvoiceExpenseLineItem__c From Gasto__c Where Id IN: mapActualizaGastos.keySet()];
		for(Gasto__c gasto : lista){
			for(String campo : mapActualizaGastos.get(gasto.Id).keySet()){
				gasto.put(campo, mapActualizaGastos.get(gasto.Id).get(campo));
			}
		}
		update lista;
	}
	
	private Map<String, Gasto__c> mapGastos {
		get{
			if(mapGastos == null){
				Set<Id> ids = new Set<Id>();
				for(c2g__codaPurchaseInvoiceExpenseLineItem__c item : newList){
					ids.add(item.Gasto__c);
				}
				mapGastos = new Map<String, Gasto__c>([Select Id, Oferta__c, PayableInvoice__c, PayableInvoiceExpenseLineItem__c From Gasto__c Where Id IN: ids]);
			}
			return mapGastos;
		}set;
	}
	
	
	public static final MAP<String,String> SYNC_FIELDS_PILI = new MAP<String,String>{'c2g__NetValue__c'=>'Importe__c',
																					'c2g__LineDescription__c'=>'Comentario__c',
																					'c2g__GeneralLedgerAccount__c'=>'GLA__c',
																					'Oferta__c'=>'Oferta__c',
																					'c2g__Dimension1__c'=>'Dimension1__c',
																					'c2g__Dimension2__c'=>'Dimension2__c',
																					'ConceptoCatalogo__c'=>'Concepto__c',
																					'Id'=>'PayableInvoiceExpenseLineItem__c',
																					'c2g__PurchaseInvoice__c'=>'PayableInvoice__c'
																					};
	private void actualizaGastosUpdate(){
		Map<String,Gasto__c> mapGastosUpdate = new Map<String,Gasto__c>();
		for(c2g__codaPurchaseInvoiceExpenseLineItem__c pili : newList){
			c2g__codaPurchaseInvoiceExpenseLineItem__c piliOld = (oldMap != null)? oldMap.get(pili.Id):pili;
			Boolean isInsert = (oldMap != null)? false:true;
			if(pili.Gasto__c != null){
				for(String campo : SYNC_FIELDS_PILI.keySet()){
					if(pili.get(campo) != piliOld.get(campo) || isInsert){
						if(!mapGastosUpdate.containsKey(pili.Gasto__c)){
							mapGastosUpdate.put(pili.Gasto__c, mapGastos.get(pili.Gasto__c));
						}
						Gasto__c ga = mapGastosUpdate.get(pili.Gasto__c);
						ga.put(SYNC_FIELDS_PILI.get(campo),pili.get(campo));
					}
				}
			}
		}
		if(mapGastosUpdate.size()>0){
			update mapGastosUpdate.values();
		}
	}
}