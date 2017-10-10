trigger CM_PropiedadTrigger on Propiedad__c (before update) {

	if(Trigger.isBefore){
		if(Trigger.isUpdate){

			//Instance to get last offer actions
			PropiedadOfertaController propertyOfferController = new PropiedadOfertaController();
			propertyOfferController.getLastOffer(Trigger.new);
		}
	}
}