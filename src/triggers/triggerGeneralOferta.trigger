trigger triggerGeneralOferta on Oferta__c (before delete) {
//Variables
	private List<Documento__c> deleteDocumentos = new List<Documento__c>();
	Map<Id,list<Integer>> mapaEstados = new Map<Id,list<Integer>>();
	Map<Id,list<Integer>> mapaCiudades = new Map<Id,list<Integer>>();
	Map<Id,list<Integer>> mapaColonia = new Map<Id,list<Integer>>();
	List<Oferta__c> lstOfertaEstado = new List<Oferta__c>();
	List<Oferta__c> lstOfertaCiudad = new List<Oferta__c>();
	List<Oferta__c> lstOfertaColonia = new List<Oferta__c>();
	Set<Id> idOfertas = new Set<Id>();
	List<ClienteOferta__c> clo = new List<ClienteOferta__c>();
    Boolean actualizarEtapas= false;

//Triggers
if(!trigger.isDelete){
	//After Update inicio
	if(trigger.isAfter && trigger.isUpdate){
		for(Oferta__c c:Trigger.new){
			if(String.isNotBlank(c.Estado__c)){
				mapaEstados.put(c.Estado__c,new list<Integer>{0,0});
			}
			if(String.isNotBlank(c.Ciudad_Tabla__c)){
				mapaCiudades.put(c.Ciudad_Tabla__c,new list<Integer>{0,0});
			}
			if(String.isNotBlank(c.Colonia_busqueda__c)){
				mapaColonia.put(c.Colonia_busqueda__c,new list<Integer>{0,0});
			}

		generaEtapasOferta(c);
			if(c.ClienteFinal__c != trigger.oldMap.get(c.Id).ClienteFinal__c && c.ClienteFinal__c != null && trigger.new.size() > 1){
				c.addError('No se puede cambiar el cliente final masivamente.');
	    	}	
		}

		buscarListas();

		if(mapaEstados.size() > 0 || mapaCiudades.size() > 0 || mapaColonia.size() > 0){
			//Lista de estados
			for(Oferta__c x : lstOfertaEstado){
				if(x.FechaCobro__c != null || esFinalizada(x.Etapa__c)){
					mapaEstados.get(x.Estado__c)[0] +=1;
				}
				else 
				if(!esFinalizada(x.Etapa__c)){
					mapaEstados.get(x.Estado__c)[1] +=1;
				}
			}
			List<Estados__c> estados = new List<Estados__c>();
			for(id y : mapaEstados.keyset()){
				Integer v = mapaEstados.get(y)[0];//vendidas
				Integer d = mapaEstados.get(y)[1];//disponibles
				Estados__c edo = new Estados__c(id=y,vendidas__c=v,Propiedades_Disponibles__c=d);
				estados.add(edo);
			}
			if(estados.size() > 0){
				system.debug('Estados: '+estados);
				update estados;
			}
			//Lista de estados
			//Lista de ciudades
			for(Oferta__c x : lstOfertaCiudad){
				if(x.FechaCobro__c != null || esFinalizada(x.Etapa__c)){
					mapaCiudades.get(x.Estado__c)[0] +=1;
				}
				else 
				if(!esFinalizada(x.Etapa__c)){
					mapaCiudades.get(x.Estado__c)[1] +=1;
				}
			}
			List<Ciudad__c> ciudades = new List<Ciudad__c>();
			for(id y : mapaCiudades.keyset()){
				Integer v = mapaCiudades.get(y)[0];//vendidas
				Integer d = mapaCiudades.get(y)[1];//disponibles
				Ciudad__c cd = new Ciudad__c(id=y,Propiedades_vendidas__c=v,Propiedades_Disponibles__c=d);
				ciudades.add(cd);
			}
			if(ciudades.size() > 0){
				system.debug('Ciudades: '+ciudades);
				update ciudades;
			}
			//Lista de ciudades
			//Lista de colonias
			for(Oferta__c x : lstOfertaColonia){
				if(x.FechaCobro__c != null || esFinalizada(x.Etapa__c)){
					mapaColonia.get(x.Estado__c)[0] +=1;
				}
				else 
				if(!esFinalizada(x.Etapa__c)){
					mapaColonia.get(x.Estado__c)[1] +=1;
				}
			}
			List<ColoniaFraccionamiento__c> colonias = new List<ColoniaFraccionamiento__c>();
			for(id y : mapaColonia.keyset()){
				Integer v = mapaColonia.get(y)[0];//vendidas
				Integer d = mapaColonia.get(y)[1];//disponibles
				ColoniaFraccionamiento__c col = new ColoniaFraccionamiento__c(id=y,vendidas__c=v,Propiedades_Disponibles__c=d);
				colonias.add(col);
			}
			if(colonias.size() > 0){
				system.debug('Colonias: '+colonias);
				update colonias;
			}
			//Lista de colonias
		}


		for(Oferta__c ofer:Trigger.new){
				idOfertas.add(ofer.id);
		}
		clo = [SELECT id FROM ClienteOferta__c WHERE Oferta__c in :idOfertas];
		if(clo.size() > 0){
			UPDATE clo;
		}
	}
	//After Update fin
	//After Insert inicio
	
	for(Oferta__c p : trigger.new){
		if(trigger.isAfter && trigger.isInsert){
			generaEtapasOferta(p);
		}
		if(trigger.isBefore && trigger.isInsert){
	        cambiaFolio(p);
	        p.Etapa__c = 'Oferta';
	        p.Proceso__c = 'Compra';
	        p.FolioLlave__c = p.Name;
		}
		if(trigger.isBefore && trigger.isUpdate){
    		p.FolioLlave__c = p.Name; 
    		cambiaFolio(p);
    		//actualizaOfertaEtapa(p);
    		actualizaEstatus(p);
		}
    }
	
	if(trigger.isBefore && trigger.isDelete){
        List<Documento__c> ldocs = new List<Documento__c>();
        for(Oferta__c p : trigger.old){
            if(mapOfertas.get(p.Id).Documentos__r.size() > 0){
                ldocs.addAll(mapOfertas.get(p.Id).Documentos__r);
            }
        }
        delete ldocs;
        delete mapEtapasExistentes.values();
    }
        
    if(actualizarEtapas){
        upsert mapEtapasExistentes.values();
    }
    
    if(deleteDocumentos.size() > 0){
        delete deleteDocumentos;
    }
}


//Métodos
private Boolean esFinalizada(String etapa){
	Boolean e;
	if(etapa == 'Compilación expediente compra' || etapa == 'Compra final' || etapa == 'Escrituras en proceso registro' || etapa == 'Compilación expediente cliente' || etapa == 'Rehabilitación' || etapa == 'Compilación expediente crediticio' || etapa == 'Expediente aprobado' || etapa == 'Cierre oferta'){
		e = false;
	}else
	if(etapa == 'Finalizada'){
		e = true;
	}
	return e;
}
private void buscarListas(){
	List<Oferta__c> listaTodos = [SELECT id,Name,Estatus__c,FechaCobro__c,FechaPago__c,Etapa__c,Estatus_de_invasion__c,Estado__c,Ciudad_tabla__c,Colonia_busqueda__c FROM Oferta__c WHERE FechaPago__c != Null AND Estatus__c != 'Descartada' AND ((Estado__c IN:mapaEstados.keyset()) OR (Ciudad_tabla__c IN:mapaCiudades.keyset()) OR (Colonia_busqueda__c IN:mapaColonia.keyset()))];
	
	for(Oferta__c o : listaTodos){
		if(mapaEstados.containsKey(o.Estado__c)){
			lstOfertaEstado.add(o);
		}else
		if(mapaCiudades.containsKey(o.Ciudad_tabla__c)){
			lstOfertaCiudad.add(o);
		}else
		if(mapaColonia.containsKey(o.Colonia_busqueda__c)){
			lstOfertaColonia.add(o);
		}
	}
}

private void actualizaEstatus(Oferta__c p){
        if(mEtapas.containsKey(p.Etapa__c)){
            p.Estatus__c = mEtapas.get(p.Etapa__c).Estatus__c;
            p.Proceso__c = mEtapas.get(p.Etapa__c).EstatusOferta__c;
            if(mapDocumentos.containsKey(p.Id + '' + p.Etapa__c)){
                for(Documento__c doc : mapDocumentos.get(p.Id + '' + p.Etapa__c)){
                    if(doc.NumFiles__c > 0 && doc.DocumentoEtapa__r.ActualizaEstatus__c != null){
                        p.Estatus__c = doc.DocumentoEtapa__r.ActualizaEstatus__c;
                    }
                }
            }
            
        }else if(p.Etapa__c == 'Descartada'){
            p.Estatus__c = 'Descartada';
        }else if(p.Etapa__c == 'Finalizada'){
            p.Estatus__c = 'Firmada';
        }
    }
    
    private void cambiaFolio(Oferta__c p){
        if(p.Name == null && p.Propiedad__c != null && mapPropiedades.get(p.Propiedad__c).ReferenciaBanco__c != null){
            p.Name = mapPropiedades.get(p.Propiedad__c).ReferenciaBanco__c + '-' + mapPropiedades.get(p.Propiedad__c).Name;
        }
    }
    
    private void envioAlertas(Oferta__c oferta){
        if(oferta.EnviarEmailNotaria__c && oferta.EnviarEmailNotaria__c != trigger.oldMap.get(oferta.Id).EnviarEmailNotaria__c){
            sendEmail(mapOfertas.get(oferta.Id), 'EnvioNotaria', mapOfertas.get(oferta.Id).Notaria__r.Contacto__c);
        }
    }
    
    private void sendEmail(Oferta__c what, String templateName, ID target){
        Messaging.reserveSingleEmailCapacity(2);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateID(Utils.MAP_EMAILTEMPLATES.get(templateName).Id);
        mail.setWhatId(what.Id);
        mail.setTargetObjectId(target);
        
        List<Documento__c> documentos = new List<Documento__c>();
        for(Documento__c doc : what.Documentos__r){
            String emailTempletes = doc.DocumentoEtapa__r.EmailTemplates__c;
            if(emailTempletes != null && (emailTempletes.contains(templateName) || emailTempletes == templateName) ){
                documentos.add(doc);
            }
        }
        List<Messaging.EmailFileAttachment> listAttachments = new List<Messaging.EmailFileAttachment>();
        for(Attachment attach : [Select Id, Name, Parent.Name, Body From Attachment Where ParentId IN: documentos]){
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(attach.Parent.Name + ' - ' + attach.Name);
            efa.setBody(attach.Body);
            listAttachments.add(efa);
        }
        mail.setFileAttachments(listAttachments);
    
        try{
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }catch(Exception mailException){trigger.new[0].addError('' + mailException);}
    }
    
    
    private void actualizaOfertaEtapa(Oferta__c p){
        String newEtapa = p.Etapa__c; 
        String oldEtapa = null;
        
        if(trigger.oldMap != null && trigger.oldMap.get(p.Id).Etapa__c != null){
            oldEtapa = trigger.oldMap.get(p.Id).Etapa__c;
        }
        
        if(newEtapa != oldEtapa){
            Boolean etapaParalela = false;
            do{
                etapaParalela = false;
                if(mEtapas.containsKey(newEtapa) && mapEtapasExistentes.containsKey(p.Id + '' + mEtapas.get(newEtapa).Id)){
                    EtapaOferta__c newEtapaSO = mapEtapasExistentes.get(p.Id + '' + mEtapas.get(newEtapa).Id);
                    if(newEtapaSO.Estatus__c != 'Cerrada')
                    {
                        newEtapaSO.HoraInicial__c = Datetime.now();
                        newEtapaSO.Estatus__c = 'Abierta';
                    }
                        if(newEtapaSO.Etapa__r.Usuario__c != null){
                            //newEtapaSO.OwnerId = newEtapaSO.Etapa__r.Usuario__c;
                        }
                        actualizarEtapas = true; 
                    
                    if(mEtapas.get(newEtapa).Paralelo__c){
                        Decimal etapaActual = mEtapas.get(newEtapa).NumEtapa__c;
                        Decimal etapaSiguiente = mEtapas.get(newEtapa).NumEtapa__c + 100;
                        for(Etapa__c e : mEtapas.values()){
                            if(e.NumEtapa__c > etapaActual && e.NumEtapa__c < etapaSiguiente){
                                etapaSiguiente = e.NumEtapa__c; 
                                newEtapa = e.Name;
                                p.Etapa__c = e.Name;
                                etapaParalela = true;
                            }
                        }
                    }
                }
                
            }while(etapaParalela);
        }
        
        if(newEtapa != oldEtapa && actualizarEtapas == false && newEtapa != 'Descartada' && newEtapa != 'Finalizada'){
            p.addError('Existe un problema en la etapa. Error T01 ' + newEtapa + ' - ' + oldEtapa + mEtapas.keySet());
        } 
    } 
    
    private void copiaDocsCliente(Oferta__c p){
        if(p.ClienteFinal__c != trigger.oldMap.get(p.Id).ClienteFinal__c && p.ClienteFinal__c != null && trigger.new.size() == 1){
            Map<String,DocumentoEtapa__c> mapDocsEtapaCliente = new Map<String,DocumentoEtapa__c>(); 
            for(DocumentoEtapa__c de : mapDocumentosEtapa.values()){
                if(de.AdjuntarClienteDocumento__c){
                    mapDocsEtapaCliente.put(de.Name, de);
                }
            }
            Map<ID,Documento__c> mapDocsCliente = new Map<ID,Documento__c>([Select Id, Tipo__c, Name, Cuenta__c From Documento__c Where Cuenta__c = :p.ClienteFinal__c AND Name IN: mapDocsEtapaCliente.keySet()]);
            
            Map<String,Documento__c> mapDocsOferta = new Map<String,Documento__c>();
            for(Documento__c doc : [Select Id, Tipo__c, Name, Oferta__c, EtapaOferta__c, DocumentoEtapa__c From Documento__c Where Oferta__c = :p.Id AND Name IN: mapDocsEtapaCliente.keySet()]){
                mapDocsOferta.put(doc.Name, doc);
            }
            
            Map<Documento__c,List<Attachment>> mapFilesCliente = new Map<Documento__c,List<Attachment>>();
            for(Attachment att : [Select Id, ParentId, Name, ContentType, Body, Description From Attachment Where ParentId IN : mapDocsCliente.values()]){
                Documento__c doc = mapDocsCliente.get(att.ParentId);
                if(!mapFilesCliente.containsKey(doc)){
                    mapFilesCliente.put(doc, new List<Attachment>());
                }
                mapFilesCliente.get(doc).add(att);
            }
            
            if(mapFilesCliente != null && mapFilesCliente.size() > 0){
                Map<String, Documento__c> newDocs = new Map<String,Documento__c>();
                for(Documento__c doc : mapFilesCliente.keySet()){
                    Documento__c docNew = new Documento__c();
                    if(mapDocsOferta.containsKey(doc.Name)){
                        docNew = mapDocsOferta.get(doc.Name);
                    }else{
                        docNew.Oferta__c = p.Id;
                        docNew.EtapaOferta__c = mapEtapasExistentes.get(p.Id + '' + mapDocsEtapaCliente.get(doc.Name).Etapa__c).Id;
                        docNew.DocumentoEtapa__c = mapDocsEtapaCliente.get(doc.Name).Id;
                        docNew.Name = doc.Name;
                        docNew.Tipo__c = doc.Tipo__c;
                    }
                    newDocs.put(doc.Id, docNew);
                }
                system.debug('Estos son los nuevos documentos........' + newDocs.values());
                //upsert newDocs.values();

                List<Attachment> newAttachments = new List<Attachment>();
                for(List<Attachment> listAttachments : mapFilesCliente.values()){
                    for(Attachment att : listAttachments){
                        Attachment nuevo = new Attachment();
                        nuevo.Name = att.Name;
                        nuevo.ContentType = att.ContentType;
                        nuevo.Body = att.Body;
                        nuevo.Description = att.Description;
                        nuevo.ParentId = newDocs.get(att.ParentId).Id;
                        newAttachments.add(nuevo);
                    }
                }
                insert newAttachments;
            }
        }
        if(p.ClienteFinal__c != trigger.oldMap.get(p.Id).ClienteFinal__c && p.ClienteFinal__c != null && trigger.new.size() > 1){
            p.addError('No se puede cambiar el cliente final masivamente.');
        }
    }
    
    
    private void generaEtapasOferta(Oferta__c p){
        for(Etapa__c etapa : mEtapas.values()){
            String keyEstatus = p.Id + '' + etapa.Id; 
            if(!mapEtapasExistentes.containsKey(keyEstatus)){
                EtapaOferta__c etapaOferta = new EtapaOferta__c(Oferta__c = p.Id, Etapa__c = etapa.Id);
                if(etapa.NumEtapa__c == 1){
                    etapaOferta.HoraInicial__c = Datetime.now();
                    etapaOferta.Estatus__c = 'Abierta';
                    if(etapa.Usuario__c != null){
                        //etapaOferta.OwnerId = etapa.Usuario__c ;
                    }else{ 
                        //etapaOferta.OwnerId = p.OwnerId;
                    }
                }
                mapEtapasExistentes.put(keyEstatus, etapaOferta);
                actualizarEtapas = true;
            }   
        }
    }
    
    private static Map<String, Etapa__c> mEtapas{
        get{
            if(mEtapas == null){
                mEtapas = new Map<String, Etapa__c>();
                for(Etapa__c e : [Select Id, Name, NumEtapa__c, Paralelo__c, Estatus__c, EstatusOferta__c, Usuario__c From Etapa__c Where Activa__c = true AND EstatusOferta__c IN ('Compra','Venta')]){
                    mEtapas.put(e.Name, e);
                }
            }
            return mEtapas;
        }set;
    }
    
    private static Map<String, EtapaOferta__c> mapEtapasExistentes{
        get{
            if(mapEtapasExistentes == null){
                mapEtapasExistentes = new Map<String, EtapaOferta__c>();
                Oferta__c[] objects;
                if(trigger.new != null){
                    objects = trigger.new;
                }
                else{
                    objects = trigger.old;
                }
                for(EtapaOferta__c e : [Select Id, Etapa__c, Oferta__c, EstatusTiempo__c, Estatus__c, Etapa__r.Usuario__c From EtapaOferta__c Where Oferta__c IN: objects]){
                    mapEtapasExistentes.put(e.Oferta__c + '' + e.Etapa__c, e);
                }
            }
            return mapEtapasExistentes;
        }set;
    }
    
    private static Map<String, Oferta__c> mapOfertas{
        get{
            if(mapOfertas == null){
                Oferta__c[] objects;
                if(trigger.new != null){
                    objects = trigger.new;
                }
                else{
                    objects = trigger.old;
                }
                mapOfertas = new Map<String, Oferta__c>([Select Id, Notaria__c, Notaria__r.Contacto__c, Propiedad__c, Propiedad__r.Name, Propiedad__r.ReferenciaBanco__c, (Select Id, Name, DocumentoEtapa__c, DocumentoEtapa__r.AdjuntarClienteDocumento__c, DocumentoEtapa__r.EmailTemplates__c From Documentos__r ) From Oferta__c Where Id IN: objects]);
            }
            return mapOfertas;
        }set;
    }
    
    private static Map<String, Propiedad__c> mapPropiedades{
        get{
            if(mapPropiedades == null){
                set<String> setId = new set<String>();
                for(Oferta__c r : trigger.new){
                    if(r.Propiedad__c != null){setId.add(r.Propiedad__c);}
                }
                mapPropiedades = new Map<String, Propiedad__c>([Select Id, Name, ReferenciaBanco__c From Propiedad__c Where Id IN: setId]);
            }
            return mapPropiedades;
        }set;
    }
    
    private static Map<String, DocumentoEtapa__c> mapDocumentosEtapa{
        get{
            if(mapDocumentosEtapa == null){
                mapDocumentosEtapa = new Map<String, DocumentoEtapa__c>();
                for(DocumentoEtapa__c doc : [Select Id, Etapa__c, Name, Tipo__c, AdjuntarClienteDocumento__c From DocumentoEtapa__c Where Activo__c = true]){
                    mapDocumentosEtapa.put(doc.Name, doc);
                }
            }
            return mapDocumentosEtapa;
        }set;
    }
    
    private static Map<String, List<Documento__c>> mapDocumentos{
        get{
            if(mapDocumentos == null){
                mapDocumentos = new Map<String, List<Documento__c>>();
                for(Documento__c doc : [Select Id, NumFiles__c, Oferta__c, Oferta__r.Etapa__c, DocumentoEtapa__c, DocumentoEtapa__r.Etapa__r.Name, DocumentoEtapa__r.ActualizaEstatus__c From Documento__c Where Oferta__c IN: trigger.new order by DocumentoEtapa__r.Orden__c asc]){
                    if(!mapDocumentos.containsKey(doc.Oferta__c + '' + doc.DocumentoEtapa__r.Etapa__r.Name)){
                        mapDocumentos.put(doc.Oferta__c + '' + doc.DocumentoEtapa__r.Etapa__r.Name, new List<Documento__c>());
                    }
                    mapDocumentos.get(doc.Oferta__c + '' + doc.DocumentoEtapa__r.Etapa__r.Name).add(doc);
                }
            }
            return mapDocumentos;
        }set;
    }
    
    TriggerTemplate.getHandler().execute(); 
    new TriggerOfertaHandler2().run();

}