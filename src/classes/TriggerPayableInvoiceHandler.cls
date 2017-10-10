public class TriggerPayableInvoiceHandler extends TriggerHandler {
	private Map<Id, c2g__codaPurchaseInvoice__c> newMap;
	private Map<Id, c2g__codaPurchaseInvoice__c> oldMap;
	private List<c2g__codaPurchaseInvoice__c> newList;
	private List<c2g__codaPurchaseInvoice__c> oldList;
 
	public TriggerPayableInvoiceHandler() {
		this.newMap = (Map<Id, c2g__codaPurchaseInvoice__c>) trigger.newMap;
		this.oldMap = (Map<Id, c2g__codaPurchaseInvoice__c>) trigger.oldMap;
		this.newList = (List<c2g__codaPurchaseInvoice__c>) trigger.new;
		this.oldList = (List<c2g__codaPurchaseInvoice__c>) trigger.old;
	}
    
	public override void afterInsert(){
		if(TriggerUtils.origenProceso == null){
			TriggerUtils.origenProceso = TriggerUtils.OrigenTrigger.FROM_PILI;
		}
		actualizaSolicitudesInsert();
	}
	
	public override void beforeUpdate(){
		relacionaArchivosPago();
	}
	
	public override void afterUpdate(){
		if(TriggerUtils.origenProceso == null){
			TriggerUtils.origenProceso = TriggerUtils.OrigenTrigger.FROM_PILI;
		}
		
		if(TriggerUtils.origenProceso == TriggerUtils.OrigenTrigger.FROM_PILI){
			actualizaSolicitudesUpdate();
		}
	}
	private void actualizaSolicitudesInsert(){
		Map<String, Map<String,String>> mapActualizaCampos = new Map<String, Map<String,String>>();
		for(c2g__codaPurchaseInvoice__c pin : newList){
			if(pin.SolicitudPago__c != null && (mapSolicitudes.get(pin.SolicitudPago__c).PayableInvoice__c == null || mapSolicitudes.get(pin.SolicitudPago__c).PayableInvoice__c != pin.Id)){
				mapActualizaCampos.put(pin.SolicitudPago__c, new Map<String,String>());
				mapActualizaCampos.get(pin.SolicitudPago__c).put('PayableInvoice__c', pin.Id);
			}
		}
		if(mapActualizaCampos.size() > 0){
			TriggerPayableInvoiceHandler.actualizaCamposFuture(mapActualizaCampos);
		}
	}

	public static void actualizaCamposFuture(Map<String, Map<String,String>> mapActualizaCampos){
		List<SolicitudPago__c> lista = [Select Id, PayableInvoice__c From SolicitudPago__c Where Id IN: mapActualizaCampos.keySet()];
		for(SolicitudPago__c solicitud : lista){
			for(String campo : mapActualizaCampos.get(solicitud.Id).keySet()){
				solicitud.put(campo, mapActualizaCampos.get(solicitud.Id).get(campo));
			}
		}
		update lista;
	}

	private Map<String, SolicitudPago__c> mapSolicitudes {
		get{
			if(mapSolicitudes == null){
				Set<Id> ids = new Set<Id>();
				for(c2g__codaPurchaseInvoice__c item : newList){
					ids.add(item.SolicitudPago__c);
				}
				mapSolicitudes = new Map<String, SolicitudPago__c>([Select Id, PayableInvoice__c From SolicitudPago__c Where Id IN: ids]);
			}
			return mapSolicitudes;
		}set;
	}

	public static final MAP<String,String> SYNC_FIELDS_PIN = new MAP<String,String>{
																					'c2g__InvoiceDate__c'=>'Fecha__c',
																					'c2g__InvoiceStatus__c'=>'InvoiceStatus__c'
																					};
	private void actualizaSolicitudesUpdate(){
		Map<String,SolicitudPago__c> mapSolicitudesUpdate = new Map<String,SolicitudPago__c>();
		for(c2g__codaPurchaseInvoice__c pi : newList){
			c2g__codaPurchaseInvoice__c piOld = (oldMap != null)? oldMap.get(pi.Id):pi;
			Boolean isInsert = (oldMap != null)? false:true;
			if(pi.SolicitudPago__c != null){
				for(String campo : SYNC_FIELDS_PIN.keySet()){
					if(pi.get(campo) != piOld.get(campo) || isInsert){
						if(!mapSolicitudesUpdate.containsKey(pi.SolicitudPago__c)){
							mapSolicitudesUpdate.put(pi.SolicitudPago__c, mapSolicitudes.get(pi.SolicitudPago__c));
						}
						SolicitudPago__c sp = mapSolicitudesUpdate.get(pi.SolicitudPago__c);
						sp.put(SYNC_FIELDS_PIN.get(campo),pi.get(campo));
					}
				}
			}
		}
		if(mapSolicitudesUpdate.size()>0){
			update mapSolicitudesUpdate.values();
		}
	}
	
	private void relacionaArchivosPago(){
		for(c2g__codaPurchaseInvoice__c ga : newList){
			system.debug('Prueba1: ' + ga.ArchivoNo__c);
			if(ga.ArchivoNo__c != null){
				String refInforme = '';
				if(ga.SolicitudPago__c != null){
					refInforme = ga.CompanyAlias__c + ' - ' + 'Payable Invoices - ' + ga.ArchivoNo__c;
				}else{
					refInforme = ga.CompanyAlias__c + ' - ' + 'Otros pagos - ' + ga.ArchivoNo__c;
				}
				
				system.debug('refInforme: ' + refInforme);
				if(mapArchivosPago.containsKey(refInforme)){
					ga.ArchivoPago__c = mapArchivosPago.get(refInforme).Id;
				}else{
					ArchivoPago__c archivo = new ArchivoPago__c();
					archivo.ReporteReferencia__c = refInforme;
					archivo.Fecha__c = Date.today();
					archivo.ArchivoNo__c = ga.ArchivoNo__c;
					archivo.Name = refInforme;
					archivo.UsuarioEnvio__c = '005i0000001W6vu';
					archivo.Fuente__c = 'Financial Force';
					if(ga.SolicitudPago__c != null){
						archivo.Tipo__c = 'Pagos ofertas';
					}else{
						archivo.Tipo__c = 'Otros pagos';
					}
					system.debug('archivo: ' + archivo);
					insert archivo;
					system.debug('archivo: ' + archivo);
					ga.ArchivoPago__c = archivo.Id;
					system.debug('archivo: ' + archivo);
					mapArchivosPago.put(refInforme,archivo);
					system.debug('mapArchivosPago: ' + mapArchivosPago);
				}
			}else if(ga.ArchivoPago__c != null){
				ga.ArchivoPago__c = null;
			}
		}
	}
	
	map<String, ArchivoPago__c> mapArchivosPago {
		get{
			if(mapArchivosPago == null){
				mapArchivosPago = new map<String, ArchivoPago__c>();
				Set<String> ids = new Set<String>();
				for(c2g__codaPurchaseInvoice__c ga : newList){
					if(ga.ArchivoNo__c != null){
                        String refInforme = '';
						if(ga.SolicitudPago__c != null){
							refInforme = ga.CompanyAlias__c + ' - ' + 'Payable Invoices - ' + ga.ArchivoNo__c;
						}else{
							refInforme = ga.CompanyAlias__c + ' - ' + 'Otros pagos - ' + ga.ArchivoNo__c;
						}
						ids.add(refInforme);
					}
				}
				for(ArchivoPago__c archivo : [Select Id, Fecha__c, ReporteReferencia__c, ArchivoNo__c From ArchivoPago__c Where ReporteReferencia__c IN: ids]){
					mapArchivosPago.put(archivo.ReporteReferencia__c, archivo);
				}
			}
			return mapArchivosPago;
		}set;
	}

}