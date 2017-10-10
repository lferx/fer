trigger CM_OfertaTrigger on Oferta__c (after insert) {
	if(trigger.isAfter){
		if(trigger.isInsert){
			PropiedadOfertaController propertyOfferController = new PropiedadOfertaController();
			propertyOfferController.setLastOfferinProperty(Trigger.new);
		}
	}
}