/**
 * 
 */
public class PropiedadOfertaController {
	
	/**
	 * [getLastOffer description]
	 * @param properties [description]
	 */
	public void getLastOffer(Propiedad__c[] properties){

		Set<Id> id_propeties = new Set<Id>();
		Map<String,Oferta__c> map_property_offer = new Map<String,Oferta__c>();

		for(Propiedad__c property:properties){
			id_propeties.add(property.Id);
		}

		for(Propiedad__c property:[Select Id,
									(Select Id,Name from Ofertas__r order by CreatedDate DESC limit 1) 
									from Propiedad__c 
									where Id IN:id_propeties]){
			if(property.Ofertas__r.size()>0){
				for(Oferta__c offer:property.Ofertas__r){
					map_property_offer.put(property.Id,offer);
				}				
			}
		}

		for(Propiedad__c property:properties){
			if(map_property_offer.get(property.Id) != null){
				property.ltima_Oferta__c = map_property_offer.get(property.Id).Id;
			}
		}
	}

	public void setLastOfferinProperty(Oferta__c[] offers){

		List<Propiedad__c> list_propeties = new List<Propiedad__c>();
		Set<Id> set_id_propety = new Set<Id>();
		Map<String,Oferta__c> map_property_offer = new map<String,Oferta__c>();

		for(Oferta__c offer:offers){
			set_id_propety.add(offer.propiedad__c);
		}

		for(Propiedad__c property:[Select Id from Propiedad__c where Id IN:set_id_propety]){
			list_propeties.add(property);
		}

		update list_propeties;
	}
}