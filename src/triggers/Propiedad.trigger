trigger Propiedad on Propiedad__c (after insert, after update, before update, before insert) {
	List<Oferta__c> newOfertas = new List<Oferta__c>();
	if(trigger.isAfter && trigger.isInsert){
		for(Propiedad__c p : trigger.new){
			if(p.GeneraOferta__c){
				newOfertas.add(generaOferta(p));
			}
		}
	}
	
	if(trigger.isAfter && trigger.isUpdate){
		for(Propiedad__c p : trigger.new){
			if(p.GeneraOferta__c && !trigger.oldMap.get(p.Id).GeneraOferta__c){
				newOfertas.add(generaOferta(p));
			}
		}
	}
	
	if(trigger.isBefore){
		for(Propiedad__c p : trigger.new){
			p.FolioLlave__c = p.ReferenciaBanco__c + '-' + p.Name;
		}
	}
	
	if(newOfertas != null && newOfertas.size() > 0){
		insert newOfertas;
	}
	
	private Oferta__c generaOferta(Propiedad__c p){
		Oferta__c oferta = new Oferta__c();
		oferta.Propiedad__c = p.Id;
		oferta.Paquete__c = p.PaqueteOrigen__c;
		oferta.ValorReferencia__c = p.ValorReferencia__c;
		oferta.PrecioCompra__c = p.ValorCompra__c;
		oferta.PrecioVenta__c = p.PrecioVenta__c;
		oferta.OwnerId = p.OwnerId;
		if(mapEntidades.containsKey(p.ReferenciaBanco__c)){
			oferta.EntidadFinanciera__c = mapEntidades.get(p.ReferenciaBanco__c).Id;
		}
		oferta.Name = p.ReferenciaBanco__c + '-' + p.Name;
		Integer num = mapPropiedades.get(p.Id).Ofertas__r.size() + 1;
		if(num > 1){
			oferta.Name = oferta.Name + '-' + num;
		}
		return oferta;
	}
	
	Map<String,Account> mapEntidades{
		get{
			if(mapEntidades == null){
				mapEntidades = new Map<String,Account>();
				for(Account a : [Select Id, CodigoBanco__c, Name From Account Where Type = 'Entidad financiera']){
					mapEntidades.put(a.CodigoBanco__c, a);
				}
			}
			return mapEntidades;
		}set;
	}
	
	Map<ID,Propiedad__c> mapPropiedades{
		get{
			if(mapPropiedades == null){
				mapPropiedades = new Map<ID,Propiedad__c>([Select Id, Name, (Select Id From Ofertas__r) From Propiedad__c Where Id IN: trigger.new]);
			}
			return mapPropiedades;
		}set;
	}
}