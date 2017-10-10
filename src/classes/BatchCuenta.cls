global class BatchCuenta implements Database.Batchable<sObject> {
	
	global Id idAccount {get;set;}
	global Id oldUser {get; set;}
	global Id newUser{get;set;}
	
	global BatchCuenta() {
	}
	
	global BatchCuenta(Id idAccount, Id oldUser, Id newUser) {
		this.idAccount = idAccount;
		this.oldUser = oldUser;
		this.newUser = newUser;
	}
	
	global List<Oferta__c> start(Database.BatchableContext BC){
		List<Oferta__c> ofertas = [SELECT id, InversorId__c,Inversor__c FROM Oferta__c Where Inversor__c =: idAccount];
		return ofertas;
	}
	
	global void execute(Database.BatchableContext BC, List<Oferta__c> scope) {
		List<Oferta__c> lOfertas = new List<Oferta__c> ();
		List<Oferta__Share> lColaboracion = new List<Oferta__Share>();
		List<Oferta__Share> lColaboracionDelete = new List<Oferta__Share>();
		List<EtapaOferta__Share> lColaboracionEtapaOferta = new List<EtapaOferta__Share>();
		List<EtapaOferta__Share> lColaboracionEtapaOfertaDelete = new List<EtapaOferta__Share>();
		List<Documento__Share> lColaboracionDocs = new List<Documento__Share>();
		List<Documento__Share> lColaboracionDocsDelete = new List<Documento__Share>();
		set<Id> idOfertaDelete = new set<Id>();
		set<id> idOldUser = new set<id>();
		
		for(Oferta__c oferta:scope){
			if(newUser!= null){
				lColaboracion.add(
					new Oferta__Share(
					UserOrGroupId = newUser,
					ParentId = oferta.Id,
					AccessLevel = 'Read'
					)
				);
				lOfertas.add(oferta);
			}
			if(oldUser != null){
				idOfertaDelete.add(oferta.Id);
				idOldUser.add(oldUser);
			}
		}
		lColaboracionDelete = [Select Id, UserOrGroupId, ParentId From Oferta__Share Where RowCause = 'Manual' AND ParentId IN: idOfertaDelete AND UserOrGroupId IN: idOldUser];
		
        
        for(EtapaOferta__c etapaOferta : [Select Id, Oferta__c, Oferta__r.Inversor__r.UsuarioInversor__c From EtapaOferta__c Where Oferta__c IN: lOfertas AND Oferta__r.Inversor__r.UsuarioInversor__c != null]){
            lColaboracionEtapaOferta.add(new EtapaOferta__Share(
                UserOrGroupId = etapaOferta.Oferta__r.Inversor__r.UsuarioInversor__c,
                ParentId = etapaOferta.Id,
                AccessLevel = 'Read'
            ));
        }
        
        lColaboracionEtapaOfertaDelete = [Select Id, UserOrGroupId, ParentId, Parent.Oferta__c From EtapaOferta__Share Where RowCause = 'Manual' 
																						AND Parent.Oferta__c IN: idOfertaDelete AND UserOrGroupId IN:idOldUser];
	        
		for(Documento__c doc : [Select Id, Oferta__c, Oferta__r.Inversor__r.UsuarioInversor__c From Documento__c Where Oferta__c IN: lOfertas AND Oferta__r.Inversor__r.UsuarioInversor__c != null]){
			lColaboracionDocs.add(new Documento__Share(
				UserOrGroupId = doc.Oferta__r.Inversor__r.UsuarioInversor__c,
				ParentId = doc.Id,
				AccessLevel = 'Read'
			));
		}
		lColaboracionDocsDelete = [Select Id, UserOrGroupId, ParentId, Parent.Oferta__c From Documento__Share Where RowCause = 'Manual' 
																						AND Parent.Oferta__c IN: idOfertaDelete AND UserOrGroupId IN:idOldUser];
		
		
		insert lColaboracion;
		delete lColaboracionDelete;
		insert lColaboracionEtapaOferta;
		delete lColaboracionEtapaOfertaDelete;
		insert lColaboracionDocs;
		delete lColaboracionDocsDelete;
	}
	
	global void finish(Database.BatchableContext BC) {
	}
}