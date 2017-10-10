public class TriggerSolicitudPagoHandler extends TriggerHandler {
	private Map<Id, SolicitudPago__c> newMap;
	private Map<Id, SolicitudPago__c> oldMap;
	private List<SolicitudPago__c> newList; 
	private List<SolicitudPago__c> oldList;
 	
	public TriggerSolicitudPagoHandler() {
		this.newMap = (Map<Id, SolicitudPago__c>) trigger.newMap;
		this.oldMap = (Map<Id, SolicitudPago__c>) trigger.oldMap;
		this.newList = (List<SolicitudPago__c>) trigger.new;
		this.oldList = (List<SolicitudPago__c>) trigger.old;
	}
	
	public static Map<String, Integer> vecesProcesoPermitido = new Map<String,Integer>{'actualizaGastosFuture' => 1};

	public override void beforeInsert(){
		asignaValoresIniciales();
	}
	
	public override void beforeUpdate(){
		relacionaArchivosPago();
	}
	
	
	public override void afterUpdate(){
		if(TriggerUtils.origenProceso == null){
			TriggerUtils.origenProceso = TriggerUtils.OrigenTrigger.FROM_GASTO;
		}
		
		if(TriggerUtils.origenProceso == TriggerUtils.OrigenTrigger.FROM_GASTO){
			system.debug('PruebaGastos1');
			actualizaFacturas();
		}
		actualizaGastos();
		validaSolicitudesUpdate();
	}
	
	public override void beforeDelete(){
		validaSolicitudesDelete();
	}
	
	
	public void validaSolicitudesUpdate(){
		for(SolicitudPago__c sp : newList){
			if(sp.PayableInvoice__c != oldMap.get(sp.Id).PayableInvoice__c && oldMap.get(sp.Id).PayableInvoice__c != null){
				sp.addError('No es posible cambiar el PIN.');
			}
		}
	}
	
	public void validaSolicitudesDelete(){
		for(SolicitudPago__c sp : oldList){
			if(sp.PayableInvoice__c != null || sp.Process__c){
				sp.addError('No es posible borrar una solicitud aprobada.');
			}
		}
	}

	private void asignaValoresIniciales(){
    	for(SolicitudPago__c sp : newList){
    		if(sp.EstatusManual__c == null){
    			sp.EstatusManual__c = 'Nuevo';
    		} 
    	}
    }
    
    private void actualizaGastos(){
    	Set<String> solicitudesCambiadas = new Set<String>();
    	for(SolicitudPago__c sp : newList){
    		if(sp.Rechazado__c != oldMap.get(sp.Id).Rechazado__c ||
    			sp.Process__c != oldMap.get(sp.Id).Process__c  ||
    			sp.Cancelado__c != oldMap.get(sp.Id).Cancelado__c || 
    			sp.Pagado__c != oldMap.get(sp.Id).Pagado__c || 
    			sp.EnviarCxP__c != oldMap.get(sp.Id).EnviarCxP__c|| 
    			sp.InvoiceStatus__c != oldMap.get(sp.Id).InvoiceStatus__c
    			){
    			solicitudesCambiadas.add(sp.Id);
    		}
    	}
    	if(solicitudesCambiadas.size() > 0 && TriggerSolicitudPagoHandler.vecesProcesoPermitido.get('actualizaGastosFuture') > 0){
    		TriggerSolicitudPagoHandler.actualizaGastosFuture(solicitudesCambiadas);
    		TriggerSolicitudPagoHandler.vecesProcesoPermitido.put('actualizaGastosFuture', TriggerSolicitudPagoHandler.vecesProcesoPermitido.get('actualizaGastosFuture')-1);
    		
    	}
    }
    
    @future
    public static void actualizaGastosFuture(Set<String> setSolicitudes){
    	List<Gasto__c> listaGastos = [Select Id, SolicitudPago__r.EnviarCxP__c, SolicitudPago__r.Pagado__c, SolicitudPago__r.Cancelado__c, SolicitudPago__r.Process__c, SolicitudPago__r.Rechazado__c From Gasto__c Where SolicitudPago__c IN: setSolicitudes];
    	for(Gasto__c ga : listaGastos){
	    	ga.EnviarCxP__c = ga.SolicitudPago__r.EnviarCxP__c;
	    	ga.Pagado__c = ga.SolicitudPago__r.Pagado__c;
	    	ga.Cancelado__c = ga.SolicitudPago__r.Cancelado__c;
	    	ga.Process__c = ga.SolicitudPago__r.Process__c;
	    	ga.Rechazado__c = ga.SolicitudPago__r.Rechazado__c; 
	    } 
	    try{
    		update listaGastos;
	    }catch(Exception e){
	    	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		   	String[] toAddresses = new String[] {'demos@ctconsulting.com.mx'};
		   	mail.setToAddresses(toAddresses);
		   	mail.setSubject('Fallo en actualización de gastos');
		   	mail.setPlainTextBody
		   	('El proceo de actualización de gastos fallo, solicitudes relacionadas:' + String.join(new List<String>(setSolicitudes), ', ') +'\n Error:' + e);
		   	Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	    }
    }
    private void validaGastos(){
    	for(SolicitudPago__c sp : newList){
    		if(sp.EnviarCxP__c && oldMap.get(sp.Id).EnviarCxP__c == false){
    			if(mapSolicitudConGastos.get(sp.Id).Gastos__r.size() > 0){
    				sp.addError('No se puede enviar una solicitud con gastos duplicados no aprobados.');
    			}
    		} 
    	}
    }
    Map<ID, SolicitudPago__c> mapSolicitudConGastos{
    	get{
    		if(mapSolicitudConGastos == null){
    			mapSolicitudConGastos = new Map<ID, SolicitudPago__c>([Select Id, (Select Id, AprobacionDuplicado__c From Gastos__r Where AprobacionDuplicado__c = 'Rechazado') From SolicitudPago__c Where Id IN: newList]);
    		}
    		return mapSolicitudConGastos;
    	}set;
    }
    
    public static final MAP<String,String> SYNC_FIELDS_PI = new MAP<String,String>{	'Account__c'=>'c2g__Account__c',
																					'Fecha__c'=>'c2g__InvoiceDate__c',
																					'Name'=>'c2g__AccountInvoiceNumber__c'
																					};
																					
	
	private void actualizaFacturas(){
		Map<String,c2g__codaPurchaseInvoice__c> mapPagosParent = new Map<String,c2g__codaPurchaseInvoice__c>();
		
		for(SolicitudPago__c sp : newList){
			SolicitudPago__c spOld = oldMap.get(sp.Id);
			
			if(sp.PayableInvoice__c != null){
				for(String campo : SYNC_FIELDS_PI.keySet()){
					if(sp.get(campo) != spOld.get(campo)){
						if(!mapPagosParent.containsKey(sp.PayableInvoice__c)){
							mapPagosParent.put(sp.PayableInvoice__c, mapPI.get(sp.PayableInvoice__c));
						}
						c2g__codaPurchaseInvoice__c pi = mapPagosParent.get(sp.PayableInvoice__c);
						pi.put(SYNC_FIELDS_PI.get(campo),sp.get(campo));
						if(campo == 'Fecha__c'){
							pi.c2g__DueDate__c = sp.Fecha__c;
						}
					}
				}
			}
		}
		
		if(mapPagosParent.size()>0){
			update mapPagosParent.values();
		}
	}

	Map<ID, c2g__codaPurchaseInvoice__c> mapPI {
		get{
			if(mapPI == null){
				Set<String> ids = new Set<String>();
				for(SolicitudPago__c sp : newList){
					if(sp.PayableInvoice__c != null){
						ids.add(sp.PayableInvoice__c);
					}
				}
				mapPI = new Map<ID, c2g__codaPurchaseInvoice__c>([Select Id From c2g__codaPurchaseInvoice__c Where Id IN: ids]);
			}
			return mapPI;
		}set;
	}
	
	private void relacionaArchivosPago(){
		for(SolicitudPago__c ga : newList){
			if(ga.ArchivoNo__c != null){
				String aliasEmpresa;
				if(ga.CompaniaContable__c != null && ga.CompaniaContable__c == 'Recuperadora de Propiedades Mexicanas SA de CV'){
				 	aliasEmpresa = 'RPM';
				 }if(ga.CompaniaContable__c != null && ga.CompaniaContable__c.contains('Recicladora')){
				 	aliasEmpresa = 'RPVM2 - Recicladora';
				 }else{
				 	aliasEmpresa = ga.CompaniaContable__c;
				 }
				String refInforme = aliasEmpresa + ' - ' + 'Solicitud pago - ' + ga.ArchivoNo__c;
				if(mapArchivosPago.containsKey(refInforme)){
					ga.ArchivoPago__c = mapArchivosPago.get(refInforme).Id;
				}else{
					ArchivoPago__c archivo = new ArchivoPago__c();
					archivo.ReporteReferencia__c = refInforme;
					archivo.Fecha__c = Date.today();
					archivo.ArchivoNo__c = ga.ArchivoNo__c;
					archivo.Name = refInforme;
					archivo.UsuarioEnvio__c = '005i0000001W6vu';
					archivo.Fuente__c = 'Solicitud de pago';
					archivo.Empresa__c = ga.CompaniaContable__c;
					insert archivo;
					ga.ArchivoPago__c = archivo.Id;
					mapArchivosPago.put(refInforme,archivo);
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
				for(SolicitudPago__c ga : newList){
					if(ga.ArchivoNo__c != null){
                        String aliasEmpresa;
                        if(ga.CompaniaContable__c != null && ga.CompaniaContable__c == 'Recuperadora de Propiedades Mexicanas SA de CV'){
                            aliasEmpresa = 'RPM';
                         }if(ga.CompaniaContable__c != null && ga.CompaniaContable__c.contains('Recicladora')){
                            aliasEmpresa = 'RPVM2 - Recicladora';
                         }else{
                            aliasEmpresa = ga.CompaniaContable__c;
                         }
						String refInforme = aliasEmpresa + ' - ' + 'Solicitud pago - ' + ga.ArchivoNo__c;
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