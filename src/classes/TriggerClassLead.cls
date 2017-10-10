/**   
* <P>Clase que contiene los metodos ejecutados en los diferentes momentos del Trigger LeadWebTrigger
* El cual como su nombre indica esta ligado al objeto <a href="https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_objects_lead.htm">Lead</a>
*  
* @author Juan Loyola
* @version 1.0
*/
public with sharing class TriggerClassLead {
	
	/**
	* <P> Este metodo resive como parametro una lista la cual contiene objetos de tipo Lead, los cuales sirven para obtener su credito y su ubicacion 
	* y en base a estos datos obtener una lista de propiedades para ofrecer.
	*/
	public void LigarPropiedades( List<Lead> lstLeads ){
		
		System.debug('##### Inicia el metodo de ligar propiedades');
		System.debug('##### Numero de leads que entran: ' + lstLeads.size());
		
		List<Lead> lstLeadsAux = new List<Lead>();
		
		for(Lead lead: lstLeads){
			if(lead.IsConverted == false){
				lstLeadsAux.add(lead);
			}
		}
		
		lstLeads = lstLeadsAux;
		
		System.debug('##### Numero de leads a evaluar: ' + lstLeads.size());
		
		//En el siguiente conjunto insertaremos todas las plazas en las que se encuentren nuestros Leads
		Set<String> setPlazas = new Set<String>();
		
		
		
		//Se necesitara saber el rango maximo y el minimo de credito de nuestra lista de leads por lo que declaramos 2 variables en donde almacenaremos ese dato
		Decimal decCreditoMaximo = (lstLeads != null && lstLeads.size() != null && lstLeads.size() > 0 )?lstLeads[0].Credito__c:0;
		
		//Teniendo en cuenta que solo podemos ofrecer propiedades que esten en una oferta con etapas definidas y con base a que la relacion de oferta propiedad es de uno a uno 
		//La Busqueda de propiedades sera sobre el objeto oferta.
		List<Oferta__c> lstOfertas = new List<Oferta__c>();
		
		//La siguiente variable es la lista que insertaremos para ligar las propiedades a los leads
		List<Ofertas_por_lead__c> lstOfertasLeads = new List<Ofertas_por_lead__c>();
		
		
		//Recorremos una ves nuestros leads para obtener las plazas y el credito maximo y minimo de la lista
		
		Integer numLeads = 0;
		
		for(Integer i=0; i<lstLeads.size(); i++){
			if(lstLeads[i].Credito__c > decCreditoMaximo){
				decCreditoMaximo = lstLeads[i].Credito__c;
			} 
		}
		
		for(Lead lead:lstLeads){
			//Insertamos la plaza del lead al conjunto
			setPlazas.add( lead.Plaza__c );			
		}
		
		
		System.debug('##### Credito Maximo: ' + decCreditoMaximo);
		
		
		Map<String, Configuracion_Etapa_Lead__c> mapConfiguracionEtapaLead = Configuracion_Etapa_Lead__c.getAll();
		
		System.debug('##### Configuracion personalizada de etapas: ' + mapConfiguracionEtapaLead);
		
		Set<String> setEtapas = new Set<String>();
		
		for( Configuracion_Etapa_Lead__c configuarcioEtapa : mapConfiguracionEtapaLead.values() ){
			setEtapas.add( configuarcioEtapa.Name );
		}
		
		System.debug('##### Etapas a evaluar: ' + setEtapas);
		
		//Consultamos las ofertas con los anteriores parametros aprovechandonos de la lupa de propiedades en el objeto.
		lstOfertas = [
						SELECT Id,Name,Etapa__c,PrecioVenta__c,Plaza__c, Propiedad__r.Estatus__c ,Propiedad__c,Propiedad__r.Oferta_Valor_Referencia__c,Propiedad__r.Plaza__c 
						FROM Oferta__c 
						WHERE Propiedad__r.Plaza__c IN :setPlazas 
						AND PrecioVenta__c <= :decCreditoMaximo 
						AND Etapa__c IN :setEtapas
						AND Estatus__c != 'Descartada' ];
						

						
		for( Lead lead:lstLeads){ 
			numLeads = 0;
			for(Oferta__c oferta:lstOfertas){
				if( oferta.Plaza__c == lead.Plaza__c ){							
					if( oferta.PrecioVenta__c <= lead.Credito__c ){
						Ofertas_por_lead__c oferatLead = new Ofertas_por_lead__c();
						oferatLead.Propiedad__c = oferta.Propiedad__c;
						oferatLead.Lead__c = lead.Id;
						
						if( numLeads < 10 ){
							lstOfertasLeads.add( oferatLead );
							numLeads++;
						}
					}
				}
			}
		}
		
		System.debug('##### lstOfertasLeads ' + lstOfertasLeads);
		
		if(!lstOfertasLeads.isEmpty()){
			insert lstOfertasLeads;
		}
		
	}
	
	/**
	* <P>Este metodo elimina los registros del objeto Ofertas_por_lead de aquellos leads que se reciben en la lista de parametros.
	*/
	public void eliminarPropiedadesDelLead( Map<Id,Lead> mapLeads ){
		
		//Buscamos los registros del  objeto Ofertas_por_lead
		List<Ofertas_por_lead__c> lstOfertas = [SELECT Id FROM Ofertas_por_lead__c WHERE Lead__c IN :mapLeads.keySet() ];
		
		if(lstOfertas != null && !lstOfertas.isEmpty()){
			delete lstOfertas;
		}
		
	}
	
	
	/**
	* <P> Este metodo resive como parametro una lista la cual contiene objetos de tipo Lead, los cuales sirven para obtener su credito y su ubicacion 
	* y en base a estos datos obtener una lista de propiedades para ofrecer.
	*/
	public void LigarPropiedadesUpdate( Map<Id,Lead> mapOldLeads, Map<Id,Lead> mapNewLeads ){
		eliminarPropiedadesDelLead(mapNewLeads);
		LigarPropiedades(mapNewLeads.values());
		
	}
	
	/**
	* <P>Este metodo vincula los promoteres a los nuevos prospectos que se ingresan en salesforce
	*/
	public void insertarInteresados( List<Lead> lstLeads ){
		
		List<Candidato_Interesado__c> lstCandidatosInteresados = new List<Candidato_Interesado__c>();
		
		for(Lead lead:lstLeads){
			Candidato_Interesado__c canIn = new Candidato_Interesado__c();
			canIn.Lead__c = lead.Id;
			canIn.Correo_electr_nico__c = lead.Email;
			canIn.OwnerId = lead.OwnerId;
			lstCandidatosInteresados.add(canIn);
			
		}
		
		insert lstCandidatosInteresados;
	}
	
	
	/**
	* <p>Metodo que establece el campo propietario para los leads que ingresan en salesforce.com, el proceso para seleccionar 
	* el gerente se realiza haciendo un match con la plaza que tiene el lead y la plazas que tienen asignadas los gerentes</p>
	* @param <code> List<leads> </code> la cual proviene del trigger que se dispara al insertar un nuevo lead.
	*/
	public void asignarGerente( List<Lead> lstLeads ){
		/*
		//Conjunto de plazas el cual nos servira para realizar una consulta hacia el objeto User para traer los gerentes que coinciden con estas
		String strPlazas;
		
		//El siguiente mapa almacena como llave el nombre de la plaza y como contenido tiene el id del usuario gerente que esta asignado a esta
		Map<String,Id> mapPlazasPorUserId = new Map<String,Id>();
		
		//Consultamos el perfil de Gerente de Ventas para que al consultar los usuarios solo se busquen los que coinsidan con este perfil
		Profile perfilGerenteVentas = [SELECT Id FROM Profile WHERE Name = 'Gerente de Ventas' LIMIT 1];
		
		//LLenamos el conjutno de plazas con las que tengan los leads
		for( Lead lead:lstLeads ){
			if( String.isEmpty(strPlazas) ){
				strPlazas = lead.Plaza__c;
			}else{
				if( !(strPlazas.indexOf( lead.Plaza__c ) >= 0) ){
					strPlazas+=';'+lead.Plaza__c;
				}	
			}
		}
		
		//Se realiza la consulta para buscar los usuarios.
		List<User> lstUsersGerentes = [SELECT Id,Plaza__c FROM User WHERE ProfileId =: perfilGerenteVentas.Id AND Plaza__c INCLUDES(:strPlazas)];
		
		//Ya con la lista de usuarios gerentes recorremos esta y asignamos los ids a las plazas en el mapa.
		for( User userGerente:lstUsersGerentes ){
			mapPlazasPorUserId.put( userGerente.Plaza__c, userGerente.Id );
		}
		
		//Por ultimo se realiza la asigancion de los gerentes a los leads
		for( Lead lead:lstLeads ){
			if( mapPlazasPorUserId.containsKey( lead.Plaza__c ) ){
				lead.OwnerId = mapPlazasPorUserId.get(lead.Plaza__c);
			}
		}
		
	*/}
	
	/**
	* <P>Este metodo vincula los promoteres a los nuevos prospectos que se ingresan en salesforce
	*/
	public void LigarPromotor( List<Lead> lstLeads ){
		/*System.debug('##### Entro al trigger');
		//Promotor Menor
		Id promotorIdMenor;
		
		//Mapa que almacena la cantidad de leads por promotor
		Map<Id,Integer> mapLeadsPorPromotor = new Map<Id,Integer>();
		
		//En el siguiente conjunto insertaremos todas las plazas en las que se encuentren nuestros Leads
		Set<String> setPlazas = new Set<String>();
		
		
		System.debug('##### Primer for de leads');
		for( Lead lead:lstLeads ){
			setPlazas.add( lead.Plaza__c );
		}
		
		System.debug('##### obtener RecordType');
		//Consultamos el RecordTypeId de promotor
		Id promotorRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Promotor').getRecordTypeId();
		
		System.debug('##### Obtener promotores de las plazas');
		//Obtenemos los promotores en un Mapa
		Map<Id,Account> mapPromotores = new Map<Id,Account>([SELECT Id,Plaza__c FROM Account WHERE RecordTypeId =: promotorRecordTypeId AND Account.Plaza__c IN :setPlazas ]);
		
		System.debug('##### Obtener leads auxiliares');
		//Consultamos los prospectos con los consultores anteriores
		List<Lead> lstLeadsAux = [SELECT Id,Promotor__c FROM Lead WHERE Promotor__c IN :mapPromotores.values()];
		
		System.debug('##### segundo for de promotores');
		//Setamos el mapa de promotores por lead
		for( Account promotor:mapPromotores.values() ){
			mapLeadsPorPromotor.put( promotor.Id, 0 );
		}
		
		System.debug('##### for de leads auxiliares');
		for(Lead lead:lstLeadsAux){
			if(mapLeadsPorPromotor.containsKey(lead.Promotor__c)){
				Integer contador = mapLeadsPorPromotor.get(lead.Promotor__c);
				contador += 1;
				mapLeadsPorPromotor.put(lead.Promotor__c, contador);
			}
		}
		
		System.debug('##### Primer for de leads');
		for(Lead lead:lstLeads){
			if(lead.Promotor__c!= null){
				continue;
			}
			//Variable pivote para el numero de leads
			Integer numerLeadsAnterior = 0;
			System.debug('##### for interno de promotores');
			for(Account promotor:mapPromotores.values()){
				
				System.debug('##### if de lead por plaza');
				if(lead.Plaza__c == promotor.Plaza__c){
					System.debug('##### if de numero de prospectos por promotor');
					if( mapLeadsPorPromotor.get( promotor.Id ) <= 0 ){
						System.debug('##### break de cumplimiento');
						lead.Promotor__c = promotor.Id;
						numerLeadsAnterior = mapLeadsPorPromotor.get( promotor.Id );
						mapLeadsPorPromotor.put(promotor.Id, numerLeadsAnterior+1 );
						break;
					}else{
						System.debug('##### else de no cumplimiento');
						if(numerLeadsAnterior > mapLeadsPorPromotor.get( promotor.Id ) ){
							numerLeadsAnterior = mapLeadsPorPromotor.get( promotor.Id );
							lead.Promotor__c = promotor.Id;
							mapLeadsPorPromotor.put(promotor.Id, numerLeadsAnterior+1 );
						}
					}
				}
				
			}
		}*/	
		
	}
	
	public void asignarBoletos( Map<Id,Lead> mapOldLead, Map<Id,Lead> mapNewLead ){
		
		/*Sorteo__c sorteo = [SELECT Id, Name FROM Sorteo__c WHERE Fecha_de_inicio__c <=: System.today() AND Fecha_de_fin__c >=: System.today() LIMIT 1 ];
		
		List<Boleto__c> lstBoletos = new List<Boleto__c>();
		
		for(Lead newLead:mapNewLead.values()){
			
			Lead oldLead = mapOldLead.get(newLead.Id);
			
			if( newLead.Estatus_Llamada__c != oldLead.Estatus_Llamada__c && newLead.Estatus_Llamada__c == 'Interesado' && newLead.Sorteo__c == false ){
				Boleto__c boleto = new Boleto__c();
				boleto.Sorteo__c = sorteo.Id;
				boleto.Candidato__c = newLead.Id;
				boleto.Estado__c = 'Activo';
				lstBoletos.add( boleto );
			}
			
		}
		
		insert lstBoletos;*/
		

		
	}
	

}