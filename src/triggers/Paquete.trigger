trigger Paquete on Paquete__c (after update, before insert, before update) {
	 list<EtapaOferta__c> etapasOfertas = new list<EtapaOferta__c>();
	 list<Oferta__c> ofertas = new list<Oferta__c>();
	 map<Id,String> mapaOfertaUltimo = new map<Id,String>();

 	 map<Id,list<Oferta__c>> mapaOfertas{
		 get {
		 	if(mapaOfertas == null){
		 		mapaOfertas = new map<Id,list<Oferta__c>>();
		 		set<String> setIds = new set<String>();
		 		for(Paquete__c p : trigger.new){
		 			mapaOfertas.put(p.Id, [SELECT Id, Etapa__c, Paquete__c FROM Oferta__c WHERE Paquete__c =: p.Id ]);
		 		}
		 	}
		 	return mapaOfertas;
		 }
		 set;
	 }
	
	if(trigger.isAfter && trigger.isUpdate){
		for(Paquete__c p : trigger.new){
			if(p.Etapa__c != trigger.oldMap.get(p.Id).Etapa__c ){
				if (mapaOfertas.containsKey(p.Id)){
					for(Oferta__c oferta: mapaOfertas.get(p.Id)){
						//mapaOfertaUltimo.put(oferta.Id, trigger.oldMap.get(p.Id).Etapa__c);
						oferta.Etapa__c = p.Etapa__c;
						ofertas.add(oferta);
					}
				}
			}
		}
		update ofertas;
		//actualizaEtapasOferta();
	}
	
	public void actualizaEtapasOferta(){
	 	for(Id idOferta: mapaOfertaUltimo.keySet()){
	 		EtapaOferta__c etapaOferta = [SELECT id,Name, FechaCierre__c, Oferta__c, Etapa__r.Name FROM EtapaOferta__c WHERE oferta__c =: idOferta AND  Etapa__r.Name =: mapaOfertaUltimo.get(idOferta) ];
	 		etapaOferta.FechaCierre__c = Date.today();
	 		etapaOferta.Estatus__c = 'Cerrada';
	 		etapaOferta.Cerrada__c = true;
	 		etapasOfertas.add(etapaOferta);
	 	}
	 	update etapasOfertas;
	}
	
	
}