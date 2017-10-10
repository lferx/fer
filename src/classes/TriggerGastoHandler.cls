public class TriggerGastoHandler extends TriggerHandler {
	private Map<Id, Gasto__c> newMap;
	private Map<Id, Gasto__c> oldMap;
	private List<Gasto__c> newList;
	private List<Gasto__c> oldList;

 	PagosEngine pagoEngine;

	public TriggerGastoHandler() {
		this.newMap = (Map<Id, Gasto__c>) trigger.newMap;
		this.oldMap = (Map<Id, Gasto__c>) trigger.oldMap;
		this.newList = (List<Gasto__c>) trigger.new;
		this.oldList = (List<Gasto__c>) trigger.old;
		if(newList != null){
			pagoEngine = new PagosEngine(newList);
		}
	}

	
	public override void beforeInsert(){
		asignaValoresIniciales();
		asignaDimensions();
		asignaValoresAutomaticos();
		buscaControlesAlcanzados();
		asignaFolioDocumentoFF();
		actualizarEstatus();
	}

	public override void beforeUpdate(){
		if(!(TriggerUtils.PAYMENT_IN_PROGRESS == true)){
			asignaDimensions();
			asignaValoresAutomaticos();
			buscaControlesAlcanzados();
			asignaFolioDocumentoFF();
		}
		actualizarEstatus();
	}

	public override void afterInsert(){
		List<Oferta__c> parts = this.getOfertas4Update(newList);
    	if(parts.size()>0){
            update parts;
    	}
    	actualizaSolicitudes(newList);
    	List<Account> cuentas = this.getCuentas4Update(newList);
    	if(cuentas.size()>0){
            update cuentas;
    	}
    	
	}

	public override void afterUpdate(){
		system.debug('TriggerUtils.PAYMENT_IN_PROGRESS: ' + TriggerUtils.PAYMENT_IN_PROGRESS);
		if(!(TriggerUtils.PAYMENT_IN_PROGRESS == true)){
			if(TriggerUtils.origenProceso == null){
				TriggerUtils.origenProceso = TriggerUtils.OrigenTrigger.FROM_GASTO;
			}
	
			if(TriggerUtils.origenProceso == TriggerUtils.OrigenTrigger.FROM_GASTO){
				actualizaFacturas();
			}
			List<Oferta__c> parts = this.getOfertas4Update(newList);
		  	if(parts.size()>0){
		          update parts;
		  	}
		}
  		actualizaSolicitudes(newList);
  		if(!(TriggerUtils.PAYMENT_IN_PROGRESS == true)){
			List<Account> cuentas = this.getCuentas4Update(newList);
  			if(cuentas.size()>0){
        		update cuentas;
  			}
  		}
  		CierraPaso();
	}

	public override void afterDelete(){
		List<Oferta__c> parts = this.getOfertas4Update(oldList);
    	if(parts.size()>0){
            update parts;
    	}
    	actualizaSolicitudes(oldList);
	}

	public override void afterUndelete(){
		List<Oferta__c> parts = this.getOfertas4Update(newList);
    	if(parts.size()>0){
            update parts;
    	}
    	actualizaSolicitudes(newList);
	}

	public static final MAP<String,String> SYNC_FIELDS_PILI = new MAP<String,String>{'Importe__c'=>'c2g__NetValue__c',
																					'Comentario__c'=>'c2g__LineDescription__c',
																					'GLA__c'=>'c2g__GeneralLedgerAccount__c',
																					'Oferta__c'=>'Oferta__c',
																					'Dimension1__c'=>'c2g__Dimension1__c',
																					'Dimension2__c'=>'c2g__Dimension2__c',
																					'Concepto__c'=>'ConceptoCatalogo__c'
																					};

	private void actualizaFacturas(){
		Map<String,c2g__codaPurchaseInvoiceExpenseLineItem__c> mapPagosLineItem = new Map<String,c2g__codaPurchaseInvoiceExpenseLineItem__c>();
		for(Gasto__c ga : newList){
			Gasto__c gaOld = oldMap.get(ga.Id);
			if(ga.PayableInvoiceExpenseLineItem__c != null){
				for(String campo : SYNC_FIELDS_PILI.keySet()){
					if(ga.get(campo) != gaOld.get(campo)){
						c2g__codaPurchaseInvoiceExpenseLineItem__c pi = mapPILI.get(ga.PayableInvoiceExpenseLineItem__c);
						if(pi.get(SYNC_FIELDS_PILI.get(campo)) != ga.get(campo)){
							system.debug('GA:' + ga.Name + ', Campo:' + campo + ', OldValue: ' + gaOld.get(campo) + ', NewValue:' + ga.get(campo));
							if(!mapPagosLineItem.containsKey(pi.Id)){
								mapPagosLineItem.put(pi.Id, pi);
							}
							pi.put(SYNC_FIELDS_PILI.get(campo),ga.get(campo));
							if(campo == 'Importe__c' && pi.c2g__TaxRate1__c != null && pi.c2g__TaxRate1__c > 0){
								pi.c2g__TaxValue1__c = ga.Importe__c * (pi.c2g__TaxRate1__c/100);
							}else if(campo == 'Importe__c'){
								pi.c2g__TaxValue1__c = 0;
							}
						}
					}
				}
			}
		}
		if(mapPagosLineItem.size()>0){
			update mapPagosLineItem.values();
		}
	}

	Map<ID, c2g__codaPurchaseInvoice__c> mapPI {
		get{
			if(mapPI == null){
				Set<String> ids = new Set<String>();
				for(Gasto__c ga : newList){
					if(ga.PayableInvoice__c != null){
						ids.add(ga.PayableInvoice__c);
					}
				}
				mapPI = new Map<ID, c2g__codaPurchaseInvoice__c>([Select Id, Name, c2g__InvoiceStatus__c, c2g__PaymentStatus__c From c2g__codaPurchaseInvoice__c Where Id IN: ids]);
			}
			return mapPI;
		}set;
	}

	Map<ID, c2g__codaPurchaseInvoiceExpenseLineItem__c> mapPILI {
		get{
			if(mapPILI == null){
				Set<String> ids = new Set<String>();
				for(Gasto__c ga : newList){
					if(ga.PayableInvoiceExpenseLineItem__c != null){
						ids.add(ga.PayableInvoiceExpenseLineItem__c);
					}
				}
				mapPILI = new Map<ID, c2g__codaPurchaseInvoiceExpenseLineItem__c>([Select Id, c2g__NetValue__c, c2g__LineDescription__c, c2g__GeneralLedgerAccount__c, Oferta__c, c2g__Dimension1__c, c2g__Dimension2__c, ConceptoCatalogo__c, c2g__TaxValue1__c, c2g__TaxRate1__c From c2g__codaPurchaseInvoiceExpenseLineItem__c Where Id IN: ids]);
			}
			return mapPILI;
		}set;
	}

	private void asignaValoresAutomaticos(){
		Set<String> ids = new Set<String>();
		for(Gasto__c gasto : newList){
			Gasto__c gaOld;
			if(oldMap != null){
				gaOld = oldMap.get(gasto.Id);
			}
			if(gasto.Concepto__c != null && gasto.GLA__c == null){
				if(gasto.PayableInvoiceExpenseLineItem__c != null){
					gasto.GLA__c = mapPILI.get(gasto.PayableInvoiceExpenseLineItem__c).c2g__GeneralLedgerAccount__c;
				}else{
					gasto.GLA__c = mapConceptos.get(gasto.Concepto__c).GLA__c;
				}

			}
			if(gaOld != null && gasto.SolicitudPago__c == null && gaOld.SolicitudPago__c != null){
				gasto.Rechazado__c = true;
			}
			ids.add(gasto.Oferta__c);
		}
		
		/*
		Map<ID, Map<String,EtapaOferta__c>> mapEtapaOferta = new Map<ID, Map<String,EtapaOferta__c>>();
		for(Oferta__c oferta : [Select Id From Oferta__c Where Id IN: ids]){
			mapEtapaOferta.put(oferta.Id, new Map<String, EtapaOferta__c>());
			map<integer, EtapaOferta__c> etofaux = new map<integer,EtapaOferta__c>();
		    integer i = 0;
		    for (EtapaOferta__c eto :[SELECT id, Name, Etapa__c FROM EtapaOferta__c Where Oferta__c IN: ids])
		    {
		        etofaux.put(i,eto);
		        i++;
		    }
			for(EtapaOferta__c eo: etofaux.values()){
				if(!mapEtapaOferta.get(oferta.Id).containsKey(eo.Etapa__c)){
					mapEtapaOferta.get(oferta.Id).put(eo.Etapa__c,eo);
				}
			}
		}
		for(Gasto__c gasto : newList){
			Gasto__c gaOld;
			if(oldMap != null){
				gaOld = oldMap.get(gasto.Id);
			}
			if(gasto.Oferta__c != null && mapEtapaOferta.containsKey(gasto.Oferta__c) && mapConceptos.containsKey(gasto.Concepto__c) && mapConceptos.get(gasto.Concepto__c).DocEtapa_ComprobantePago__r.Etapa__c != null){
				//gasto.EtapaOferta__c = mapEtapaOferta.get(gasto.Oferta__c).get(mapConceptos.get(gasto.Concepto__c).DocEtapa_ComprobantePago__r.Etapa__c).Id;
			}
			ids.add(gasto.Oferta__c);
		}*/

	}

	private void asignaDimensions(){
		for(Gasto__c gasto : newList){
			Gasto__c gaOld;
			if(oldMap != null){
				gaOld = oldMap.get(gasto.Id);
			}
			if(gasto.Oferta__c != null && (gaOld == null || gasto.Oferta__c != gaOld.Oferta__c)){
				gasto.Dimension1__c = mapDimensions1.get(gasto.Oferta__c).Id;
			}
			if(gasto.Concepto__c != null && (gaOld == null || gasto.Concepto__c != gaOld.Concepto__c) && mapDimensions2.containsKey(gasto.Concepto__c)){
				gasto.Dimension2__c = mapDimensions2.get(gasto.Concepto__c).Id;
			}
		}
	}

	private void buscaControlesAlcanzados(){
		for(Gasto__c gasto : newList){
			gasto = pagoEngine.revisaValidacionesConcepto(gasto);
		}
	}

	private void actualizaSolicitudes(List<Gasto__c> listDetails){
		Set<Id> setParents = new Set<Id>();
        for(Gasto__c item : listDetails){
            if(item.SolicitudPago__c != null){
            	setParents.add(item.SolicitudPago__c);
            }
            if(oldMap != null && oldMap.get(item.Id).SolicitudPago__c != null){
            	setParents.add(oldMap.get(item.Id).SolicitudPago__c);
            }
        }
        if(setParents.size()>0){
            Map<Id,SolicitudPago__c> updParents = new Map<Id,SolicitudPago__c>();
            for(Id idParent : setParents){
            	SolicitudPago__c parent = new SolicitudPago__c(Id=idParent, Importe__c = 0, Reconciliado__c = false);
                updParents.put(idParent, parent);
            }
            for(AggregateResult result : [Select SolicitudPago__c, SUM(Importe__c) importe, SUM(ImporteFinal__c) importeFinal, count(Id) Total From Gasto__c
            								Where SolicitudPago__c IN: setParents AND EstatusManual__c NOT IN ('Cancelado')
            								Group by SolicitudPago__c]){
                Id idParent = (Id)result.get('SolicitudPago__c');
                Double sumImporte = (Double)result.get('importe');
                Double sumImporteFinal = (Double)result.get('importeFinal');
                if(sumImporte!=null){
                	(updParents.get(idParent)).Importe__c = sumImporte;
                }
                if(sumImporteFinal!=null){
                	(updParents.get(idParent)).ImporteFinal__c = sumImporteFinal;
                }
            }
            for(Gasto__c item : [Select Id, Reconciliado__c, SolicitudPago__c From Gasto__c Where SolicitudPago__c IN: setParents]){
            	if(!updParents.containsKey(item.SolicitudPago__c)){
            		SolicitudPago__c parent = new SolicitudPago__c(Id=item.SolicitudPago__c, Reconciliado__c = false);
            	  	updParents.put(item.SolicitudPago__c, parent);
            	}
            	if(item.Reconciliado__c && (updParents.get(item.SolicitudPago__c)).Reconciliado__c == false){
					(updParents.get(item.SolicitudPago__c)).Reconciliado__c = true;
            	}
       	 	}
            if(updParents.size()>0){
                update updParents.values();
            }
        }
	}

	//Actualiza campos cuenta
    public List<Account> getCuentas4Update(List<Gasto__c> listDetails){
        Map<ID,Account> mapCuentasUpdate = new Map<ID,Account>();
        for(Gasto__c item : listDetails){
        	Account cuenta = mapCuentas.get(item.Account__c);
            if(item.Account__c != null && item.Process__c && cuenta.TipoGastos__c != 'Por facturar'){
            	cuenta.TipoGastos__c = 'Por facturar';
            	mapCuentasUpdate.put(cuenta.Id, cuenta);
            }
            else if(item.Account__c != null && item.EnviarCxP__c && cuenta.TipoGastos__c != 'Por facturar' && cuenta.TipoGastos__c != 'Por aprobar'){
            	cuenta.TipoGastos__c = 'Por aprobar';
            	mapCuentasUpdate.put(cuenta.Id, cuenta);
            }else if(item.Account__c != null && cuenta.TipoGastos__c == null){
            	cuenta.TipoGastos__c = 'Por enviar';
            	mapCuentasUpdate.put(cuenta.Id, cuenta);
            }
        }
        return mapCuentasUpdate.values();
    }


    private Map<ID, Account> mapCuentas {
		get{
			if(mapCuentas == null){
				Set<Id> ids = new Set<Id>();
				for(Gasto__c gasto : newList){
					ids.add(gasto.Account__c);
				}
				mapCuentas = new Map<ID,Account>([Select Id, TipoGastos__c From Account Where Id IN: ids]);
			}
			return mapCuentas;
		}set;
	}

	//Actualiza totales en oferta
    public List<Oferta__c> getOfertas4Update(List<Gasto__c> listDetails){
        Set<Id> setParents = new Set<Id>();
        Map<String,Set<String>> setFieldsUpdate = new Map<String,Set<String>>();
        for(Gasto__c item : listDetails){
        	Gasto__c itemOld;
        	if(oldMap != null){
        		itemOld = oldMap.get(item.Id);
        	}
            if(item.Oferta__c != null && item.Concepto__c != null && PagosEngine.MAP_CONCEPTO_CATALOGO_ID.get(item.Concepto__c).ObjetoSuma__c == 'Oferta__c'){
            	setParents.add(item.Oferta__c);
            	if(!setFieldsUpdate.containsKey(item.Oferta__c)){
            		setFieldsUpdate.put(item.Oferta__c, new Set<String>());
            	}
            	setFieldsUpdate.get(item.Oferta__c).add(PagosEngine.MAP_CONCEPTO_CATALOGO_ID.get(item.Concepto__c).CampoSuma__c);
            	if(itemOld != null && itemOld.Concepto__c != item.Concepto__c && itemOld.Oferta__c == item.Oferta__c){
            		setFieldsUpdate.get(item.Oferta__c).add(PagosEngine.MAP_CONCEPTO_CATALOGO_ID.get(itemOld.Concepto__c).CampoSuma__c);
            	}
            }

            if(itemOld != null && itemOld.Oferta__c != null && itemOld.Oferta__c != item.Oferta__c && itemOld.Concepto__c != null && PagosEngine.MAP_CONCEPTO_CATALOGO_ID.get(itemOld.Concepto__c).ObjetoSuma__c == 'Oferta__c'){
            	setParents.add(itemOld.Oferta__c);
            	if(!setFieldsUpdate.containsKey(itemOld.Oferta__c)){
            		setFieldsUpdate.put(itemOld.Oferta__c, new Set<String>());
            	}
            	setFieldsUpdate.get(itemOld.Oferta__c).add(PagosEngine.MAP_CONCEPTO_CATALOGO_ID.get(itemOld.Concepto__c).CampoSuma__c);
            }
        }
        if(setParents.size()>0){
            Map<Id,Oferta__c> updParents = new Map<Id,Oferta__c>();
            for(Id idParent : setParents){
            	Oferta__c parent = new Oferta__c(Id=idParent);
            	for(String fieldName : setFieldsUpdate.get(idParent)){
            		parent.put(fieldName, 0);
            	}
                updParents.put(idParent, parent);
            }
            for(AggregateResult result : [Select Oferta__c, Concepto__r.CampoSuma__c CampoSuma, SUM(ImporteFinal__c) Total From Gasto__c
            								Where Concepto__c != null AND Concepto__r.CampoSuma__c != null AND Oferta__c IN: setParents AND (Estatus__c NOT IN ('Cancelado','Rechazado','Nuevo','En aprobación'))
            								Group by Oferta__c, Concepto__r.CampoSuma__c]){
                Id idParent = (Id)result.get('Oferta__c');
                String fieldName = (String)result.get('CampoSuma');
                Double total = (Double)result.get('Total');
                if(total!=null){
                    updParents.get(idParent).put(fieldName, total);
                }
            }
            if(updParents.size()>0){
                return updParents.values();
            }
        }
        return new List<Oferta__c>();
    }

    private void asignaValoresIniciales(){
    	for(Gasto__c ga : newList){
    		if(ga.EstatusManual__c == null){
    			ga.EstatusManual__c = 'Nuevo';
    		}
    		if(ga.Tipo__c == null){
    			ga.Tipo__c = 'Manual';
    		}
    	}
    }

    Map<ID, c2g__codaCashEntry__c> mapCashEntries {
		get{
			if(mapCashEntries == null){
				Set<String> ids = new Set<String>();
				for(Gasto__c ga : newList){
					if(ga.CashEntry__c != null){
						ids.add(ga.CashEntry__c);
					}
				}
				mapCashEntries = new Map<ID, c2g__codaCashEntry__c>([Select Id, Name, c2g__Status__c, c2g__PaymentStatus__c From c2g__codaCashEntry__c Where Id IN: ids]);
			}
			return mapCashEntries;
		}set;
	}

	Map<ID, c2g__codaPurchaseCreditNote__c> mapCreditNotes {
		get{
			if(mapCreditNotes == null){
				Set<String> ids = new Set<String>();
				for(Gasto__c ga : newList){
					if(ga.PayableCreditNote__c != null){
						ids.add(ga.PayableCreditNote__c);
					}
				}
				mapCreditNotes = new Map<ID, c2g__codaPurchaseCreditNote__c>([Select Id, Name, c2g__CreditNoteStatus__c, c2g__PaymentStatus__c From c2g__codaPurchaseCreditNote__c Where Id IN: ids]);
			}
			return mapCreditNotes;
		}set;
	}

	Map<ID, c2g__codaJournal__c> mapJournals {
		get{
			if(mapJournals == null){
				Set<String> ids = new Set<String>();
				for(Gasto__c ga : newList){
					if(ga.Journal__c != null){
						ids.add(ga.Journal__c);
					}
				}
				mapJournals = new Map<ID, c2g__codaJournal__c>([Select Id, Name, c2g__JournalStatus__c From c2g__codaJournal__c Where Id IN: ids]);
			}
			return mapJournals;
		}set;
	}

    private void asignaFolioDocumentoFF(){
    	Set<String> setIds = new Set<String>();
    	for(Gasto__c item : newList){
    		if(item.PayableInvoice__c != null || item.PayableCreditNote__c != null || item.CashEntry__c != null || item.Journal__c != null){
				setIds.add(item.Id);
			}
    	}
    	if(setIds.size() > 0){
			for(Gasto__c item : newList){
				String documentNumber = '';
				if(item.PayableInvoice__c != null){
					documentNumber = mapPI.get(item.PayableInvoice__c).Name;
					if(mapPI.get(item.PayableInvoice__c).c2g__PaymentStatus__c == 'Paid'){
						item.EstatusDocumento__c = 'Pagado';
					}else if(mapPI.get(item.PayableInvoice__c).c2g__PaymentStatus__c == 'Part Paid'){
						item.EstatusDocumento__c = 'Parcialmente pagado';
					}else if(mapPI.get(item.PayableInvoice__c).c2g__InvoiceStatus__c == 'Complete'){
						item.EstatusDocumento__c = 'Sin pagar';
					}else{
						item.EstatusDocumento__c = 'En proceso';
					}
				}else if(item.PayableCreditNote__c != null){
					documentNumber = mapCreditNotes.get(item.PayableCreditNote__c).Name;
					if(mapCreditNotes.get(item.PayableCreditNote__c).c2g__PaymentStatus__c == 'Paid'){
						item.EstatusDocumento__c = 'Pagado';
					}else if(mapCreditNotes.get(item.PayableCreditNote__c).c2g__PaymentStatus__c == 'Part Paid'){
						item.EstatusDocumento__c = 'Parcialmente pagado';
					}else if(mapCreditNotes.get(item.PayableCreditNote__c).c2g__CreditNoteStatus__c == 'Complete'){
						item.EstatusDocumento__c = 'Sin pagar';
					}else{
						item.EstatusDocumento__c = 'En proceso';
					}
				}else if(item.CashEntry__c != null){
					documentNumber = mapCashEntries.get(item.CashEntry__c).Name;
					if(mapCashEntries.get(item.CashEntry__c).c2g__PaymentStatus__c == 'Paid'){
						item.EstatusDocumento__c = 'Pagado';
					}else if(mapCashEntries.get(item.CashEntry__c).c2g__PaymentStatus__c == 'Part Paid'){
						item.EstatusDocumento__c = 'Parcialmente pagado';
					}else if(mapCashEntries.get(item.CashEntry__c).c2g__Status__c == 'Complete'){
						item.EstatusDocumento__c = 'Sin pagar';
					}else{
						item.EstatusDocumento__c = 'En proceso';
					}
				}else if(item.Journal__c != null){
					documentNumber = mapJournals.get(item.Journal__c).Name;
					if(mapJournals.get(item.Journal__c).c2g__JournalStatus__c == 'Complete'){
						item.EstatusDocumento__c = 'Posteado';
					}else{
						item.EstatusDocumento__c = 'En proceso';
					}
				}
				item.FolioDocumentoFF__c = documentNumber;
			}
    	}
    }
    private void CierraPaso()
    {
    	for (Gasto__c gtodoc :newlist)
    	{
    		if (((gtodoc.PagadoFF__c == true && oldMap.get(gtodoc.Id).PagadoFF__c == false) || (gtodoc.Cancelado__c == true && oldMap.get(gtodoc.Id).Cancelado__c == false)) 
    		      && gtodoc.Oferta__c != null && gtodoc.Documento__c != null)
    		{
    			Integer iCountGastos;
    			iCountGastos = [SELECT Count() FROM Gasto__c WHERE Documento__c =: gtodoc.Documento__c AND PagadoFF__c =: false AND Cancelado__c =: false];
    			Integer iCountPago;
    			iCountPago = [SELECT Count() FROM Gasto__c WHERE Documento__c =: gtodoc.Documento__c AND PagadoFF__c =: true];
    			if (iCountGastos == 0 && iCountPago >= 1)
    			{
	    			Documento__c docgasto = new Documento__c();
	    			docgasto = [SELECT id, Name, Oferta__c, DocumentoEtapa__c, EtapaOferta__c, Desalojo__c, Cerrado__c, Iniciado__c, Fecha_Cierre__c, 
	    			             EtapaOferta__r.Etapa__c FROM Documento__c WHERE id =: gtodoc.Documento__c];
	    			if (docgasto.Cerrado__c == false)
	    			{
	    				Boolean ret;
	    				ret = wsUtility.ConcluyePaso(docgasto);
	    			}
    			}
    		}
    	}
    }
    private void actualizarEstatus(){
    	for(Gasto__c item : newList){
    		String estatus = '';
			if(item.Reconciliado__c){
				estatus = 'Reconciliado';
			}else if(item.PagadoFF__c){
				estatus = 'Pagado';
			}else if(item.Pagado__c){
				estatus = 'Comprobado';
			}else if(item.EstatusDocumento__c != null && item.EstatusDocumento__c == 'Sin pagar'){
				estatus = 'Listo para pagar';
			}else if(item.Process__c){
				estatus = 'En proceso';
			}else if(item.Rechazado__c){
				estatus = 'Rechazado';
			}else if(item.EnviarCxP__c){
				estatus = 'En aprobación';
			}else if(item.Tipo__c == 'Histórico'){
				estatus = 'Histórico';
			}else if(item.Tipo__c == 'Automático'){
				estatus = 'Automático';
			}else if(item.Cancelado__c){
				estatus = 'Cancelado';
			}else{
				estatus = 'Nuevo';
				if(item.SolicitudPago__c == null && item.EstatusManual__c == 'Cancelado'){
					item.EstatusManual__c = 'Nuevo';
				}
			}

			if((estatus == 'Reconciliado' || estatus == 'Pagado') && item.EstatusDocumento__c == 'Parcialmente pagado'){
				estatus += ' - Parcialmente pagado';
			}
			item.Estatus2__c = estatus;
    	}
    }


	private Map<String, c2g__codaDimension1__c> mapDimensions1 {
		get{
			if(mapDimensions1 == null){
				mapDimensions1 = new Map<String, c2g__codaDimension1__c>();
				Set<Id> ids = new Set<Id>();
				for(Gasto__c gasto : newList){
					ids.add(gasto.Oferta__c);
				}
				for(c2g__codaDimension1__c dim : [Select Id,Oferta__c From c2g__codaDimension1__c Where Oferta__c IN: ids]){
					mapDimensions1.put(dim.Oferta__c, dim);
				}
			}
			return mapDimensions1;
		}set;
	}

	private Map<String, c2g__codaDimension2__c> mapDimensions2 {
		get{
			if(mapDimensions2 == null){
				mapDimensions2 = new Map<String, c2g__codaDimension2__c>();
				Set<Id> ids = new Set<Id>();
				for(Gasto__c gasto : newList){
					ids.add(gasto.Concepto__c);
				}
				for(c2g__codaDimension2__c dim : [Select Id, ConceptoCatalogo__c From c2g__codaDimension2__c Where ConceptoCatalogo__c IN: ids]){
					mapDimensions2.put(dim.ConceptoCatalogo__c, dim);
				}
			}
			return mapDimensions2;
		}set;
	}

	private Map<String, ConceptoCatalogo__c> mapConceptos {
		get{
			if(mapConceptos == null){
				Set<Id> ids = new Set<Id>();
				for(Gasto__c gasto : newList){
					ids.add(gasto.Concepto__c);
				}
				mapConceptos = new Map<String, ConceptoCatalogo__c>([Select Id, GLA__c, DocEtapa_ComprobantePago__c, DocEtapa_ComprobantePago__r.Etapa__c From ConceptoCatalogo__c Where Id IN: ids]);
			}
			return mapConceptos;
		}set;
	}
}