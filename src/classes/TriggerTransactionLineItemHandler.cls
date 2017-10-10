public class TriggerTransactionLineItemHandler extends TriggerHandler {
	private Map<Id, c2g__codaTransactionLineItem__c> newMap;
	private Map<Id, c2g__codaTransactionLineItem__c> oldMap;
	private List<c2g__codaTransactionLineItem__c> newList;
	private List<c2g__codaTransactionLineItem__c> oldList;
 
	public TriggerTransactionLineItemHandler() {
		this.newMap = (Map<Id, c2g__codaTransactionLineItem__c>) trigger.newMap;
		this.oldMap = (Map<Id, c2g__codaTransactionLineItem__c>) trigger.oldMap;
		this.newList = (List<c2g__codaTransactionLineItem__c>) trigger.new;
		this.oldList = (List<c2g__codaTransactionLineItem__c>) trigger.old;
		TriggerUtils.PAYMENT_IN_PROGRESS = true;
	}

	public override void afterInsert(){
		actulizaGastosPagados();
	}

	public override void afterUpdate(){
		actulizaGastosPagados();
		actualizaReconciliacionGastos();
	}

	private void actulizaGastosPagados(){
		system.debug('zmUno');
		Set<String> setIds = new Set<String>();
		for(c2g__codaTransactionLineItem__c item : newList){
			if(item.c2g__LineType__c == 'Analysis' && item.c2g__Account__c != null && item.c2g__BankAccount__c != null){
				if(mapTransaccionesConGastos.get(item.Id).Gastos__r.size() == 0){
					setIds.add(item.Id);
					system.debug('zmDos');
				}
			}
		}
		if(setIds.size() > 0){
			actulizaGastosPagadosFuture(setIds);
		}
	}

	private void actualizaReconciliacionGastos(){
		Map<String, Boolean> mapIds = new Map<String, Boolean>();
		system.debug('zrUno');
		for(c2g__codaTransactionLineItem__c item : newList){
			if(item.c2g__BankReconciliation__c != oldMap.get(item.Id).c2g__BankReconciliation__c){
				if(item.c2g__BankReconciliation__c != null){
					mapIds.put(item.Id, true);
					system.debug('zrUno1');
				}
				else{
					system.debug('zrUno2');
					mapIds.put(item.Id, false);
				}
			}
		}
		if(mapIds.size() > 0){
			actualizaReconciliacionGastosFuture(mapIds);
		}
	}

	private static void actulizaGastosPagadosFuture(Set<String> setTransactionLineIds){
		
		List<c2g__codaTransactionLineItem__c> newList2 = new List<c2g__codaTransactionLineItem__c>();
		//Se extraen los transaction line items de la base de datos.
		for(c2g__codaTransactionLineItem__c item :[Select Id, c2g__LineType__c, c2g__BankAccount__c, c2g__Account__c, c2g__Transaction__c, 
															c2g__BankReconciliation__c, c2g__Transaction__r.c2g__DocumentNumber__c, (Select Id, Reconciliado__c, PagadoFF__c From Gastos__r)
															From c2g__codaTransactionLineItem__c 
															Where Id IN: setTransactionLineIds]){
			newList2.add(item);
			system.debug('zrUno3');
		}
		system.debug('zrUno4');
		//Se filtran las transacciones relacionadas al banco y a
		Set<String> setTransacitonsIds = new Set<String>();
		Map<String, c2g__codaCashEntry__c> mapCashEntries = new Map<String, c2g__codaCashEntry__c>(); 
		Map<String, c2g__codaTransactionLineItem__c> mapTransactionConAnalysisLineItem = new Map<String, c2g__codaTransactionLineItem__c>();
		for(c2g__codaTransactionLineItem__c item: newList2){
			system.debug('zrUno5');
			if(item.c2g__LineType__c == 'Analysis' && item.c2g__Account__c != null && item.c2g__BankAccount__c != null && item.c2g__Transaction__r.c2g__DocumentNumber__c != null && item.c2g__Transaction__r.c2g__DocumentNumber__c.startsWith('CSH')){
				if(item.Gastos__r.size() == 0){
					system.debug('zrUno6');
					setTransacitonsIds.add(item.c2g__Transaction__c);
					mapTransactionConAnalysisLineItem.put(item.c2g__Transaction__c, item);
					mapCashEntries.put(item.c2g__Transaction__r.c2g__DocumentNumber__c, null);
				}
			}
		}
		system.debug('zrUno7');
		if(mapTransactionConAnalysisLineItem.size() > 0){
			system.debug('zrUno8');
			//Se mapen los Cash Entries relacionados con su folio
			for(c2g__codaCashEntry__c item :[Select Id, Name, c2g__PaymentNumber__c From c2g__codaCashEntry__c Where Name IN: mapCashEntries.keySet()]){
				mapCashEntries.put(item.Name, item);
				system.debug('zrUno9');
			}
	
			Map<String, List<c2g__codaCashMatchingHistory__c>> mapMapHistoriesReconciliacion = new Map<String, List<c2g__codaCashMatchingHistory__c>>();
			system.debug('zrUno10');
			List<c2g__codaCashMatchingHistory__c> listaMatchHistoriesReconciliados = [Select Id, c2g__MatchingReference__c, c2g__TransactionLineItem__r.c2g__Transaction__c From c2g__codaCashMatchingHistory__c Where c2g__TransactionLineItem__r.c2g__Transaction__c IN: setTransacitonsIds];
			for(c2g__codaCashMatchingHistory__c item : listaMatchHistoriesReconciliados){
				system.debug('zrUno11');
				if(!mapMapHistoriesReconciliacion.containsKey(item.c2g__MatchingReference__c)){
					mapMapHistoriesReconciliacion.put(item.c2g__MatchingReference__c, new List<c2g__codaCashMatchingHistory__c>());
				}
				mapMapHistoriesReconciliacion.get(item.c2g__MatchingReference__c).add(item);
			}
	
			Map<String, List<c2g__codaCashMatchingHistory__c>> mapMapHistoriesPagosDocs = new Map<String, List<c2g__codaCashMatchingHistory__c>>();
			system.debug('zrUno12');
			for(c2g__codaCashMatchingHistory__c item : [Select Id, c2g__MatchingReference__c, c2g__TransactionLineItem__c, c2g__TransactionLineItem__r.Documento__c
															From c2g__codaCashMatchingHistory__c Where c2g__MatchingReference__c IN: mapMapHistoriesReconciliacion.keySet() AND Id NOT IN: listaMatchHistoriesReconciliados]){
				if(!mapMapHistoriesPagosDocs.containsKey(item.c2g__TransactionLineItem__r.Documento__c)){
					mapMapHistoriesPagosDocs.put(item.c2g__TransactionLineItem__r.Documento__c, new List<c2g__codaCashMatchingHistory__c>());
				}
				mapMapHistoriesPagosDocs.get(item.c2g__TransactionLineItem__r.Documento__c).add(item);
				system.debug('zrUno14');
			}
			system.debug('zrUno14');
			if(mapMapHistoriesPagosDocs.size()>0){
				system.debug('zrUno15');
				List<Gasto__c> listaGastosReconciliados = new List<Gasto__c>();
				for(Gasto__c item : [Select Id, PayableInvoice__c, PayableInvoice__r.Name, PayableCreditNote__c, PayableCreditNote__r.Name, CashEntry__c, CashEntry__r.Name, Journal__c, Journal__r.Name From Gasto__c 
										Where (PayableInvoice__c != null AND PayableInvoice__r.Name IN: mapMapHistoriesPagosDocs.keySet()) OR
											(PayableCreditNote__c != null AND PayableCreditNote__r.Name IN: mapMapHistoriesPagosDocs.keySet()) OR
											(CashEntry__c != null AND CashEntry__r.Name IN: mapMapHistoriesPagosDocs.keySet()) OR
											(Journal__c != null AND Journal__r.Name IN: mapMapHistoriesPagosDocs.keySet())
									]){
					system.debug('zrUno16' + item);
					String documentNumber = '';
					if(item.PayableInvoice__c != null){
						documentNumber = item.PayableInvoice__r.Name; 
					}else if(item.PayableCreditNote__c != null){
						documentNumber = item.PayableCreditNote__r.Name;
					}else if(item.CashEntry__c != null){
						documentNumber = item.CashEntry__r.Name;
					}else if(item.Journal__c != null){
						documentNumber = item.Journal__r.Name;
					}
					c2g__codaCashMatchingHistory__c cashMatchPago = mapMapHistoriesPagosDocs.get(documentNumber)[0];
					c2g__codaCashMatchingHistory__c cashMatchReconciliacion = mapMapHistoriesReconciliacion.get(cashMatchPago.c2g__MatchingReference__c)[0];
					c2g__codaTransactionLineItem__c transactionLineItem = mapTransactionConAnalysisLineItem.get(cashMatchReconciliacion.c2g__TransactionLineItem__r.c2g__Transaction__c);
					c2g__codaCashEntry__c cashEntry = mapCashEntries.get(transactionLineItem.c2g__Transaction__r.c2g__DocumentNumber__c);
					item.PagadoFF__c = true;
					item.CashMatchingHistory1__c = cashMatchPago.Id;
					item.MatchingReference__c = cashMatchPago.c2g__MatchingReference__c;
					item.CashEntryPayment__c = cashEntry.Id;
					item.Payment__c = cashEntry.c2g__PaymentNumber__c;
					item.TransaccionReconciliacion__c = transactionLineItem.Id;
					listaGastosReconciliados.add(item); 
				}
				system.debug('zrUno20' + listaGastosReconciliados.size());
				if(listaGastosReconciliados.size() > 0){
					update listaGastosReconciliados;
				}
			}
		}
	}

	private static void actualizaReconciliacionGastosFuture(Map<String,Boolean> mapTransactionLineIds){
		List<c2g__codaTransactionLineItem__c> newList2 = [Select Id, c2g__LineType__c, c2g__BankAccount__c, c2g__Account__c, c2g__Transaction__c, 
															c2g__BankReconciliation__c, (Select Id, Reconciliado__c, PagadoFF__c From Gastos__r)
															From c2g__codaTransactionLineItem__c 
															Where Id IN: mapTransactionLineIds.keySet()];
		List<Gasto__c> listaGastos = new List<Gasto__c>();
		for(c2g__codaTransactionLineItem__c item : newList2){
			for(Gasto__c gasto : item.Gastos__r){
				gasto.Reconciliado__c = mapTransactionLineIds.get(item.Id);
				listaGastos.add(gasto);
			}
		}
		if(listaGastos.size() > 0){
			update listaGastos;
		}
	}

	private Map<Id, c2g__codaTransactionLineItem__c> mapTransaccionesConGastos {
		get{
			if(mapTransaccionesConGastos == null){
				mapTransaccionesConGastos = new Map<Id, c2g__codaTransactionLineItem__c>([Select Id, (Select Id, Reconciliado__c, PagadoFF__c From Gastos__r) From c2g__codaTransactionLineItem__c Where Id IN: newList]);
			}
			return mapTransaccionesConGastos;
		}set;
	}
}