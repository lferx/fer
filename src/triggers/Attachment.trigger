trigger Attachment on Attachment (after insert, after update, after delete) {
	Set<Documento__c> lDocsUpdate = new Set<Documento__c>();
	
	if(trigger.isAfter && trigger.isInsert){
		for(Attachment a : trigger.new){
			camposResumen(a);
		}
	}
	
	if(trigger.isAfter && trigger.isUpdate){
		for(Attachment a : trigger.new){
			camposResumen(a);
		}
	}
	
	if(trigger.isAfter && trigger.isDelete){
		for(Attachment a : trigger.old){
			camposResumen(a);
			validaArchivo(a);
		}
	}
	
	if(lDocsUpdate.size() >0){
		update new List<Documento__c>(lDocsUpdate);
	}
	
	private void validaArchivo(Attachment a){
		if(mapDocumentos.containsKey(a.ParentId)){
			Documento__c d = mapDocumentos.get(a.ParentId);
			if(d.DocumentoEtapa__r.NoBorrar__c){
				Permiso__c permiso = Permiso__c.getInstance();
				if(!permiso.BorrarDocsEspeciales__c){
					a.addError('No se puede borrar este documento.');
				}
			}
		}
	}
	
	private void camposResumen(Attachment a){
		if(mapDocumentos.containsKey(a.ParentId)){
			Documento__c d = mapDocumentos.get(a.ParentId);
			d.NumFiles__c = d.Attachments.size();
			lDocsUpdate.add(d);
		}
	}
	
	private static Map<String, Documento__c> mapDocumentos{
		get{
			if(mapDocumentos == null){
				Set<String> setIds = new Set<String>();
				if(trigger.new != null){
					for(Attachment a:trigger.new){
						setIds.add(a.ParentId);
					}
				}else{
					for(Attachment a:trigger.old){
						setIds.add(a.ParentId);
					}
				}
				mapDocumentos = new Map<String, Documento__c>([Select Id, NumFiles__c, Oferta__c, Oferta__r.Etapa__c, DocumentoEtapa__c, DocumentoEtapa__r.Etapa__r.Name, DocumentoEtapa__r.NoBorrar__c, (Select Id, ParentId From Attachments) From Documento__c Where Id IN: setIds]);
			}
			return mapDocumentos;
		}set;
	}
}