@isTest(seeAllData = true)
private class Consola_Pendiente_Test {
	
	private static testmethod void pruebaQuery() {
		Test.setCurrentPage(Page.Consola_Pendientes);
		Consola_Pendientes_Controller ctr = new Consola_Pendientes_Controller();
		ctr.cargaLista();

		for(Consola_Pendientes_Controller.DocumentoWrapper reg : ctr.listaTiempoDocumentos){

			System.assert((reg.retraso == true && reg.docs.Tiempo_Restante__c < 0)||(reg.retraso == false && reg.docs.Tiempo_Restante__c > 0));

			System.assert(reg.docs.Fecha_Inicio__c < reg.docs.Fecha_Com_Controller__c);

			System.assert(reg.docs.Fecha_Inicio__c != null);

			System.assert(reg.docs.Fecha_Com_Controller__c != null);

			System.assert(reg.docs.Tiempo_Restante__c != null);

			Integer x = 0;
			for(Consola_Pendientes_Controller.DocumentoWrapper reg2 : ctr.listaTiempoDocumentos){

				System.assert(x<2);
				if(reg.docs.name == reg2.docs.name && reg.docs.Oferta__r.name == reg2.docs.Oferta__r.name){
					x++;
				}
			}

		}



		
	}

	
	
}