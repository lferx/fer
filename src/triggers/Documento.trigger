trigger Documento on Documento__c (before insert, before update, after delete, after insert, after undelete, after update) {
	new TriggerDocumentoHandler2().run();
	
	/**** Invocación de métodos por evento ****/
	
	if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
		List<Documento__Share> listInsert = creaColaboraciones(trigger.new);
		if(listInsert != null){
			insert listInsert;
		}
	}
	
	if(trigger.isAfter){
		actualizaCamposResumen();
	}
	
	if(trigger.isBefore && (trigger.isUpdate || trigger.isInsert)){
		cargaCamposDefault(trigger.new);
	}
	
	if(trigger.isAfter && trigger.isDelete){
		deleteValidation(trigger.old);
	}
	
	/**** Métodos ****/
	
	private List<Documento__Share> creaColaboraciones(List<Documento__c> listaDocs){
		List<Documento__Share> lColaboracion = new List<Documento__Share>();
		for(Documento__c d : listaDocs){
			if(d.Oferta__c != null && mapOfertas.get(d.Oferta__c).Inversor__r.UsuarioInversor__c != null){
				lColaboracion.add(new Documento__Share(
					UserOrGroupId = mapOfertas.get(d.Oferta__c).Inversor__r.UsuarioInversor__c,
					ParentId = d.Id,
					AccessLevel = 'Read'
				));
			}
		}
		return lColaboracion;
	}
	
	private void deleteValidation(List<Documento__c> listaDocs){
		for(Documento__c a : listaDocs){
			if(mapDocumentoEtapa.containsKey(a.DocumentoEtapa__c)){
				DocumentoEtapa__c d = mapDocumentoEtapa.get(a.DocumentoEtapa__c);
				if(d.NoBorrar__c){
					Permiso__c permiso = Permiso__c.getInstance();
					if(!permiso.BorrarDocsEspeciales__c){
						a.addError('No se puede borrar este documento.');
					}
				}
			}
		}
	}
	
	private void cargaCamposDefault(List<Documento__c> listaDocs){
		for(Documento__c doc : listaDocs){
			if(doc.Oferta__c == null && doc.EtapaOferta__c != null){
				doc.Oferta__c = mapEtapasOfertas.get(doc.EtapaOferta__c).Oferta__c;
			}
			if(doc.DocumentoEtapa__c != null){
				doc.Name = mapDocumentoEtapa.get(doc.DocumentoEtapa__c).Name;
			}
			if(doc.Oferta__c != null){
				doc.OwnerId = mapOfertas.get(doc.Oferta__c).OwnerId;
				
			}
		}
	}
	
	private void actualizaCamposResumen() {
		Set<String> setEtapasOferta = new Set<String>();
		
    	if(Trigger.isDelete) {
        	for(Documento__c doc: trigger.old){
	    		if(doc.EtapaOferta__c != null){
	    			setEtapasOferta.add(doc.EtapaOferta__c);
	    		}
    		}
	    }else {
        	for(Documento__c doc: trigger.new){
	    		if(doc.EtapaOferta__c != null){
	    			setEtapasOferta.add(doc.EtapaOferta__c);
	    		}
    		}
     	}
    	
    List<EtapaOferta__c> lEtapasOferta = new List<EtapaOferta__c>();
    	for(EtapaOferta__c et : [Select Id, (Select Id, Name, Oferta__c From Documentos__r Where DocumentoEtapa__r.Obligatorio__c = true) From EtapaOferta__c Where Id IN: setEtapasOferta]){
    		Set<String> documentosCargadados = new Set<String>();
    		for(Documento__c doc : et.Documentos__r){
    			documentosCargadados.add(doc.Name);
    			/*if(doc.Name=='Carta de desalojo'){
    				Oferta__c Actual=[select Id, Invadida__c from Oferta__c where id =: doc.Oferta__c];
    				Actual.Invadida__c=false;
    				update Actual;
    			}*/
    		}
    		et.DocsObligatoriosCargados__c = documentosCargadados.size();
    		lEtapasOferta.add(et);
    	}
    	if(lEtapasOferta.size() > 0){
    		update lEtapasOferta;
    	}
	}
	
	/**** Mapas y listas ****/
	
	Map<ID, Oferta__c> mapOfertas {
		get{
			if(mapOfertas == null){
				Set<String> sets = new Set<String>();
				for(Documento__c d : trigger.new){
					if(d.Oferta__c != null){
						sets.add(d.Oferta__c);
					}
				}
				mapOfertas = new Map<ID, Oferta__c>([Select Id, OwnerId, Inversor__r.UsuarioInversor__c From Oferta__c Where Id IN: sets]);
			}
			return mapOfertas;
		}
		set;
	}
	
	Map<ID, EtapaOferta__c> mapEtapasOfertas {
		get{
			if(mapEtapasOfertas == null){
				Set<String> sets = new Set<String>();
				for(Documento__c d : trigger.new){
					if(d.EtapaOferta__c != null){
						sets.add(d.EtapaOferta__c);
					}
				}
				mapEtapasOfertas = new Map<ID, EtapaOferta__c>([Select Id, Oferta__c From EtapaOferta__c Where Id IN: sets]);
			}
			return mapEtapasOfertas;
		}
		set;
	}
	
	Map<ID, DocumentoEtapa__c> mapDocumentoEtapa {
		get{
			if(mapDocumentoEtapa == null){
				Set<String> sets = new Set<String>();
				List<Documento__c> lista;
				if(trigger.new != null){
					lista = trigger.new;
				}else{
					lista = trigger.old;
				}
				
				for(Documento__c d : lista){
					if(d.DocumentoEtapa__c != null){
						sets.add(d.DocumentoEtapa__c);
					}
				}
				mapDocumentoEtapa = new Map<ID, DocumentoEtapa__c>([Select Id, Name, NoBorrar__c From DocumentoEtapa__c Where Id IN: sets]);
			}
			return mapDocumentoEtapa;
		}
		set;
	}
	
	
}