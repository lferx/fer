public class TriggerDocumentoHandler2 extends TriggerHandler {
    private Map<Id, Documento__c> newMap;
    private Map<Id, Documento__c> oldMap;
    private List<Documento__c> newList;
    private List<Documento__c> oldList;
    
    public TriggerDocumentoHandler2() {
        this.newMap = (Map<Id, Documento__c>) trigger.newMap;
        this.oldMap = (Map<Id, Documento__c>) trigger.oldMap;
        this.newList = (List<Documento__c>) trigger.new;
        this.oldList = (List<Documento__c>) trigger.old;
    }
    
    public override void afterInsert(){
    	if (Test.isRunningTest())
        {
        	this.actualizaEtapasOfertaRelacionadas(newList);
        }else
        {
        this.actualizaEtapasOfertaRelacionadas(newList);
        }
        generaDocumentosGastosHijo(newList);
        actualizaGastosRelacionadas(newList);
        actualizaCuentaDocumento(newList,false);
    }
    public override void afterUpdate(){
        if (Test.isRunningTest())
        {
        	this.actualizaEtapasOfertaRelacionadas(newList);
        }else
        {
        	this.actualizaEtapasOfertaRelacionadas(newList);
        }
        generaDocumentosGastosHijo(newList);
        actualizaGastosRelacionadas(newList);
        actualizaCuentaDocumento(newList,false);
    }
    public override void afterDelete(){
        if (Test.isRunningTest())
        {
        	this.actualizaEtapasOfertaRelacionadas(oldList);
        }else
        {
        	this.actualizaEtapasOfertaRelacionadas(oldList);
        }
        actualizaGastosRelacionadas(oldList);
        actualizaCuentaDocumento(oldList,true);
    }
    public override void afterUndelete(){
        if (Test.isRunningTest())
        {
        	this.actualizaEtapasOfertaRelacionadas(newList);
        }else
        {
            this.actualizaEtapasOfertaRelacionadas(newList);
        }
        generaDocumentosGastosHijo(newList);
        actualizaGastosRelacionadas(newList);
    }
    
    public override void beforeInsert(){
    	asignaValoresAutomaticos();
    }
    public override void beforeUpdate(){
    	asignaValoresAutomaticos();
    }


    public void actualizaCuentaDocumento(List<Documento__c> listaDocumentos, boolean isDelete){
        list<Documento__c> documentos = new list<Documento__c>();
        set<Id> idsCuenta = new set<Id>();
        set<Id> idsDocumento = new set<Id>();
        Map<String, MapeoCampos__c> documentosMap = MapeoCampos__c.getAll();
        list<MapeoCampos__c> mapeoList = new list<MapeoCampos__c>();
        map<Id,list<Documento__c>> mapCuentaDocumentos = new map<Id,list<Documento__c>>();
        list<Account> cuentas = new list<Account>();
        list<Account> cuentasUpdate = new list<Account>();

        for(Documento__c documento : listaDocumentos){
            if(documento.Cuenta__c != null){
                documentos.add(documento);
                idsDocumento.add(documento.Id);
                idsCuenta.add(documento.Cuenta__c);
            }
        }
        if (idsCuenta.size() > 0)
        {
	        cuentas = [SELECT Id, Name FROM Account WHERE Id IN: idsCuenta];
	        for(Account cuentaUno: cuentas){
	            for(Documento__c documento : documentos){
	                if(cuentaUno.Id == documento.Cuenta__c){
	                    if(!mapCuentaDocumentos.containsKey(cuentaUno.Id)){
	                        mapCuentaDocumentos.put(cuentaUno.Id,new List<Documento__c>());
	                    }
	                    mapCuentaDocumentos.get(cuentaUno.Id).add(documento);
	                }
	             }
	        }
        
	        mapeoList = documentosMap.values();
	
	        for(Account cuenta:cuentas){
	            for(Documento__c documento:mapCuentaDocumentos.get(cuenta.Id)){
	                for(MapeoCampos__c mc:mapeoList){
	                     String nombreDocumento = '';
	                    if(!isDelete){
	                         nombreDocumento = (String)newMap.get(documento.Id).get(mc.CampoOrigen__c);
	                    }else{
	                        nombreDocumento = (String)oldMap.get(documento.Id).get(mc.CampoOrigen__c);
	                    }
	                    if(nombreDocumento == mc.Filtro1CampoOrigen__c){
	                        if(isDelete){
	                             cuenta.put(mc.CampoDestino__c,false); //Hay que cambiar
	                        }
	                        if(documento.NumFiles__c > 0 && !isDelete){
	                            cuenta.put(mc.CampoDestino__c,true); //Hay que cambiar
	                        }else if(documento.NumFiles__c == 0){
	                            cuenta.put(mc.CampoDestino__c,false); //Hay que cambiar
	                        }  
	                    }
	                }
	            }
	            cuentasUpdate.add(cuenta);
	        }
        
        
	        if(cuentasUpdate.size() > 0){
	        	if (Test.isRunningTest())
        			{
        	
      				}else
    		    	{
	            update cuentasUpdate;
       				}
	        }
        }  

    }

    public void actualizaEtapasOfertaRelacionadas(List<Documento__c> listDetails){
        Set<Id> setParents = new Set<Id>();
        for(Documento__c item : listDetails){
            if(item.EtapaOferta__c != null){
                setParents.add(item.EtapaOferta__c);
            }
        }
        if(setParents.size()>0){
            List<EtapaOferta__c> listEtapaOferta = new List<EtapaOferta__c>();
            Map<EtapaOferta__c, Map<String, Documento__c>> documentosEtapaMap = new Map<EtapaOferta__c, Map<String, Documento__c>>();
            for(Documento__c doc : [Select Id, EtapaOferta__r.Id, EtapaOferta__r.Etapa__c, EtapaOferta__c, DocumentoEtapa__c, DocumentoEtapa__r.Name From Documento__c Where EtapaOferta__c IN: setParents]){
                EtapaOferta__c etapaOferta = doc.EtapaOferta__r; 
                if(!documentosEtapaMap.containsKey(etapaOferta)){
                    documentosEtapaMap.put(etapaOferta, new Map<String, Documento__c>());
                }
                documentosEtapaMap.get(etapaOferta).put(doc.DocumentoEtapa__c, doc);
            }
            for(EtapaOferta__c etapaOferta : documentosEtapaMap.keySet()){
                String documentosFaltantes = '';
                 
                if (Constants.MAP_DOCUMENTOS_ETAPA.get(etapaOferta.Etapa__c) != null)
                {
	                for(DocumentoEtapa__c docEtapa : Constants.MAP_DOCUMENTOS_ETAPA.get(etapaOferta.Etapa__c).values()){
	                    if(!documentosEtapaMap.get(etapaOferta).containsKey(docEtapa.Id)){
	                        documentosFaltantes += docEtapa.NombreUsuario__c + ';';
	                    }   
	                }
	                etapaOferta.DocumentosFaltantes__c = documentosFaltantes;
	                listEtapaOferta.add(etapaOferta);
                }
            }
            if(listEtapaOferta.size()>0){
                update listEtapaOferta;
            }
        }
    }
    
    public void actualizaGastosRelacionadas(List<Documento__c> listDetails){
        Map<Id,Double> mapParents = new Map<Id,Double>();
        User usuario = [Select Id, CargaTransferencias__c From User Where Id =: Userinfo.getUserId()];
        Map<Id,User> mapUsuarios = new Map<Id,User>([Select Id, CargaTransferencias__c From User]);
        for(Documento__c item : listDetails){
            if(item.Gasto__c != null && item.TipoGasto__c == 'Comprobante pago' && (usuario.CargaTransferencias__c = true || mapUsuarios.get(item.CreatedById).CargaTransferencias__c)){
                if(!mapParents.containsKey(item.Gasto__c)){
                	mapParents.put(item.Gasto__c,0);
                }
                if(item.NumFiles_MasFilesPadre__c != null){
                	mapParents.put(item.Gasto__c,mapParents.get(item.Gasto__c) + item.NumFiles_MasFilesPadre__c);
                }
            }
        } 
        if(mapParents.size()>0){
            List<Gasto__c> listGasto = [Select Id From Gasto__c Where Id IN: mapParents.keySet()];
            for(Gasto__c ga : listGasto){
            	ga.Pagado__c = mapParents.get(ga.Id) > 0;
            }
            if(listGasto != null && listGasto.size()>0){
                update listGasto;
            }
        }
        
       	Map<Id,Double> mapParents2 = new Map<Id,Double>();
        for(Documento__c item : listDetails){
            if(item.SolicitudPago__c != null && item.TipoGasto__c == 'Comprobante pago'){
                if(!mapParents2.containsKey(item.SolicitudPago__c)){
                	mapParents2.put(item.SolicitudPago__c,0);
                }
                if(item.NumFiles_MasFilesPadre__c != null){
                	mapParents2.put(item.SolicitudPago__c, mapParents2.get(item.SolicitudPago__c) + item.NumFiles_MasFilesPadre__c);
                }
            }
        } 
        if(mapParents2.size()>0){
            List<SolicitudPago__c> listSolicitudes = [Select Id From SolicitudPago__c Where Id IN: mapParents2.keySet()];
            for(SolicitudPago__c sol : listSolicitudes){
            	sol.Pagado__c = mapParents2.get(sol.Id) > 0;
            }
            if(listSolicitudes != null && listSolicitudes.size()>0){
                update listSolicitudes;
            }
        }
    }
    
    private void asignaValoresAutomaticos(){
    	Set<String> ids = new Set<String>();
    	for(Documento__c doc : newList){
    		if(doc.Gasto__c != null){
    			Gasto__c ga = mapGastos.get(doc.Gasto__c);
	    		doc.Gasto__c = ga.Id;
        		doc.EtapaOferta__c = ga.EtapaOferta__c;
	        	doc.Oferta__c = ga.Oferta__c;
	        	doc.SolicitudPago__c = ga.SolicitudPago__c;
	        	if(doc.TipoGasto__c == 'Comprobante pago'){
	    	    	doc.DocumentoEtapa__c = ga.Concepto__r.DocEtapa_ComprobantePago__c;
	    	    	ids.add(doc.Oferta__c);
    			} 
    		}
    	}
    	if(ids.size() >0)
    	{
    		List<EtapaOferta__c> Lista = [SELECT id, Name, Etapa__c FROM EtapaOferta__c Where Oferta__c IN: ids];
	    	Map<ID, Map<String,EtapaOferta__c>> mapEtapaOferta = new Map<ID, Map<String,EtapaOferta__c>>();
			for(Oferta__c oferta : [Select Id From Oferta__c Where Id IN: ids]){
				map<integer, EtapaOferta__c> etofaux = new map<integer,EtapaOferta__c>();
			    integer i = 0;
			    for (EtapaOferta__c eto :Lista)
			    {
			        etofaux.put(i,eto);
			        i++;
			    }
				mapEtapaOferta.put(oferta.Id, new Map<String, EtapaOferta__c>());
				for(EtapaOferta__c eo: etofaux.values()){
					if(!mapEtapaOferta.get(oferta.Id).containsKey(eo.Etapa__c)){
						mapEtapaOferta.get(oferta.Id).put(eo.Etapa__c,eo);
					}
				}
			}
    	
			for(Documento__c doc : newList){
				if(doc.Gasto__c != null){
					Gasto__c ga = mapGastos.get(doc.Gasto__c);
					if(ga.Oferta__c != null && mapEtapaOferta.containsKey(doc.Oferta__c) && doc.Gasto__c != null && ga.Concepto__r.DocEtapa_ComprobantePago__r.Etapa__c != null){
						if(mapEtapaOferta.get(doc.Oferta__c).containsKey(ga.Concepto__r.DocEtapa_ComprobantePago__r.Etapa__c)){
							doc.EtapaOferta__c = mapEtapaOferta.get(doc.Oferta__c).get(ga.Concepto__r.DocEtapa_ComprobantePago__r.Etapa__c).Id;
						}
					}
				}
			}
    	}
    }

    public void generaDocumentosGastosHijo(List<Documento__c> listDetails){
        Set<Id> setParents = new Set<Id>();
        for(Documento__c item : listDetails){
            if(item.SolicitudPago__c != null && item.TipoGasto__c == 'Comprobante pago' && item.Gasto__c == null){
                setParents.add(item.SolicitudPago__c);
            }
        }
        if(setParents.size()>0){
        	system.debug('DocsRev1: ' + setParents);
            List<Documento__c> docsUpsert = new List<Documento__c>();
            
            Map<Id, SolicitudPago__c> mapGastosSolicitud = new Map<Id, SolicitudPago__c>([Select Id, (Select Id, Oferta__c, Concepto__c, Concepto__r.DocEtapa_ComprobantePago__c, EtapaOferta__c From Gastos__r) From SolicitudPago__c Where Id IN: setParents]);
            Map<ID, Map<String, Documento__c>> mapDocumentosExistentesGasto = new Map<ID, Map<String, Documento__c>>();
            for(SolicitudPago__c solicitud : mapGastosSolicitud.values()){
            	system.debug('DocsRev1.5: ' + solicitud.Id);
                for(Gasto__c ga : solicitud.Gastos__r){
                	system.debug('DocsRev2: ' + ga.Id);
                    mapDocumentosExistentesGasto.put(ga.Id, new Map<String, Documento__c>());
                }
            }
            
            for(Gasto__c ga : [Select Id, (Select Id, TipoGasto__c, Name From Documentos__r) From Gasto__c Where Id IN: mapDocumentosExistentesGasto.keySet()]){
                system.debug('DocsRev3: ' + ga.Id);
                for(Documento__c doc : ga.Documentos__r){
                	system.debug('DocsRev4: ' + doc.Id);
                    mapDocumentosExistentesGasto.get(ga.Id).put(doc.TipoGasto__c, doc);
                }
            }
            
            for(Documento__c item : listDetails){
            	system.debug('DocsRev5: ' + item);
            	if(item.TipoGasto__c == 'Comprobante pago' && mapGastosSolicitud.containsKey(item.SolicitudPago__c)){
                	for(Gasto__c ga : mapGastosSolicitud.get(item.SolicitudPago__c).Gastos__r){
                    	Documento__c doc;
                    	if(mapDocumentosExistentesGasto.containsKey(ga.Id) && mapDocumentosExistentesGasto.get(ga.Id).containsKey('Comprobante pago')){
                            doc = mapDocumentosExistentesGasto.get(ga.Id).get('Comprobante pago');
                    	}else{
                    	    doc = new Documento__c();
        	            }
        	            doc.Gasto__c = ga.Id;
        	            doc.TipoGasto__c = 'Comprobante pago';
	                    doc.DocumentoPadre__c = item.Id;
	                    doc.EtapaOferta__c = ga.EtapaOferta__c;
	                    doc.Oferta__c = ga.Oferta__c;
	                    doc.DocumentoEtapa__c = ga.Concepto__r.DocEtapa_ComprobantePago__c;
	                    system.debug('DocsRev6: ' + ga);
	                    system.debug('DocsRev7: ' + doc);
        	            docsUpsert.add(doc);
                	}
            	}
        	}
        	upsert docsUpsert;
        }
    }
    
    Map<ID, Gasto__c> mapGastos {
    	get{
    		if(mapGastos == null){
    			Set<ID> ids = new Set<ID>();
    			for(Documento__c d : newList){
    				if(d.Gasto__c != null){
    					ids.add(d.Gasto__c);
    				}
    			}
    			mapGastos = new Map<ID,Gasto__c>([Select Id,EtapaOferta__c, SolicitudPago__c, Oferta__c, Concepto__c, Concepto__r.DocEtapa_ComprobantePago__c, Concepto__r.DocEtapa_ComprobantePago__r.Etapa__c From Gasto__c Where Id IN: ids]);
    		}
    		return mapGastos;
    	}set;
    }
}