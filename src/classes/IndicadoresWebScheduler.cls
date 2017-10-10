public with sharing class IndicadoresWebScheduler implements Schedulable{
	public IndicadoresWebScheduler() {
		
	}

	public void execute (SchedulableContext SC){
		Integer propVendidas = 0;
   		Integer propDisponibles = 0;
   		Double propAhorro = 0;
   		IndicadorWeb__c indicador = null;
   		list<Oferta__c> ofertas = new list<Oferta__c>();
   		try{
   			
   			indicador = [SELECT Id,Ahorro__c,PropiedadesDisponibles__c,PropiedadesVendidas__c FROM IndicadorWeb__c LIMIT 1];

   			AggregateResult[] arVendidas = [SELECT COUNT(Id) total FROM Oferta__c WHERE Estatus__c IN ('No cobrada','Cobrada','Firmada')];
			propVendidas = Integer.valueOf(arVendidas[0].get('total'));

			AggregateResult[] arDisponibles = [SELECT COUNT(Id) total FROM Oferta__c WHERE Estatus__c IN ('Pagada')];
			propDisponibles = Integer.valueOf(arDisponibles[0].get('total'));

			ofertas = [SELECT Id,AhorradoIndicadorWeb__c FROM Oferta__c];
			for(Oferta__c oferta: ofertas){
				propAhorro = propAhorro + oferta.AhorradoIndicadorWeb__c;
			}

			//Se divide en 1,000,000 para que quede la cantidad en millones
			propAhorro = (propAhorro/1000000);
			indicador.PropiedadesVendidas__c = propVendidas;
			indicador.PropiedadesDisponibles__c = propDisponibles;
			indicador.Ahorro__c = propAhorro;

			update indicador;

   		}catch(Exception e){
   			System.debug('Error obteniendo los indicadores web: ' + e.getMessage());
   		}

	}
}