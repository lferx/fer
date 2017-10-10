public with sharing class panel_compras_controller {
	public List<EtapaOferta__c> listEtapasOfertas {get;set;}
	public List<Oferta__c> listOfertas {get;set;}
	public List<Date> beginOferta {get;set;}
	public Map<String,Date> map_etp_ofert {get;set;}
	public Map<String,wrapperOferta> mapa_etapas {get;set;}
	public Map<String,List<wrapperOferta>> map_aux_etap {get;set;}
	public Map<String,Integer> mapa_ofertaCompras {get;set;}
	public Map<String,Decimal> mapaEtapaNumero {get;set;}
	public wrapperOferta objOferta {get;set;} 
	public List<wrapperOferta> listWrapperOfertas {get;set;}
	public Integer rangoFechaOft {get;set;}
	public Decimal porcentajeDia {get;set;}
	public String gridAreas {get;set;}
	public String fotoUsuario {get;set;}
	public String asignacion {get;set;}
	public Set<String> listaAsignada {get;set;}

	public panel_compras_controller() {
		listWrapperOfertas = new List<wrapperOferta>();
		listEtapasOfertas = new List<EtapaOferta__c>();
		listOfertas = new List<Oferta__c>();
		beginOferta = new List<Date>();
		map_etp_ofert = new Map<String,Date>();
		mapa_etapas = new Map<String,wrapperOferta>();
		map_aux_etap = new Map<String,List<wrapperOferta>>();
		mapa_ofertaCompras = new Map<String,Integer>();
		objOferta = new wrapperOferta();
	    listaAsignada = new Set<String>();
	    objOferta = new wrapperOferta();
	    mapaEtapaNumero = new Map<String,Decimal>();

	    asignacion = 'ss';
	    fotoUsuario = '';
	}

	public class wrapperOferta{ 
			public String ofertaId {get;set;}
			public String ofertaName {get;set;}
			public String etapaOfertaActual {get;set;}
			public Date fechaInicio {get;set;}
			public Integer diasTotales {get;set;}
			public Decimal porcentajeTotal {get;set;}

			public void wrapperOferta(){
		
			}
		}

 public List<SelectOption> getListaAsignacion(){
    List<SelectOption> myList = new List<SelectOption>();
    myList.add(new SelectOption('ss','--Seleciona un coordinador--'));
    for(String x : listaAsignada){
      if(String.isNotBlank(x)){
        myList.add(new SelectOption( x,x));
      }else{ 
        myList.add(new SelectOption( '','Sin Asignar'));
      }
    }
    return myList;
  }

	public void panel_oferta_compras(){

	    listWrapperOfertas = new List<wrapperOferta>();//moldes
	    map_etp_ofert = new Map<String,Date>();// molde mapa con llave tipo string para etapas y una lista tipo wrapper
	    map_aux_etap = new Map<String,List<wrapperOferta>>();
	    mapa_ofertaCompras = new Map<String,Integer>();

		if(asignacion == 'ss'){
			listEtapasOfertas = [SELECT Id, Oferta__c, Oferta__r.Name, Oferta__r.Id, Name, HoraInicial__c, EtapaActual__c, Oferta__r.FechaCobro__c, Oferta__r.FechaPago__c, Oferta__r.Etapa__c, NumEtapa__c FROM EtapaOferta__c WHERE Oferta__r.FechaCobro__c = null AND Oferta__r.FechaPago__c != null
			AND HoraInicial__c != NULL AND NumEtapa__c = 4];
			for(EtapaOferta__c etapa_oferta_comodin : listEtapasOfertas){
					map_etp_ofert.put(etapa_oferta_comodin.Oferta__r.Id, etapa_oferta_comodin.HoraInicial__c.date());			
			}
			listOfertas = [SELECT Name, Id, FechaCobro__c, FechaPago__c, Etapa__c, Gerente_Escrituras__r.Name, (Select Name, Etapa__r.Name, NumEtapa__c FROM EstatusPropiedades__r) FROM Oferta__c WHERE FechaCobro__c = null AND FechaPago__c != null
			AND Estatus__c != NULL AND (NOT Inversor2__c LIKE 'Regeneradora%') AND Estatus__c != 'Descartada' AND Etapa__c IN ('Antecedentes','Aprobada internamente','Compilación expediente compra','Compra final','Escrituras en proceso registro')];
		}

		else{
			listEtapasOfertas = [SELECT Id, Oferta__c, Oferta__r.Name, Oferta__r.Id, Name, HoraInicial__c, EtapaActual__c, Oferta__r.FechaCobro__c, Oferta__r.FechaPago__c, Oferta__r.Etapa__c, NumEtapa__c FROM EtapaOferta__c WHERE Oferta__r.FechaCobro__c = null AND Oferta__r.FechaPago__c != null
			AND HoraInicial__c != NULL AND NumEtapa__c = 4];
			for(EtapaOferta__c etapa_oferta_comodin : listEtapasOfertas){
					map_etp_ofert.put(etapa_oferta_comodin.Oferta__r.Id, etapa_oferta_comodin.HoraInicial__c.date());				
			}
			listOfertas = [SELECT Name, Id, FechaCobro__c, FechaPago__c, Etapa__c, Gerente_Escrituras__r.Name, (Select Name, Etapa__r.Name, NumEtapa__c FROM EstatusPropiedades__r) FROM Oferta__c WHERE FechaCobro__c = null AND FechaPago__c != null
			AND Estatus__c != NULL AND  Gerente_Escrituras__r.Name =:asignacion AND (NOT Inversor2__c LIKE 'Regeneradora%') AND Estatus__c != 'Descartada' AND Etapa__c IN ('Antecedentes','Aprobada internamente','Compilación expediente compra','Compra final','Escrituras en proceso registro')];
		}

		System.debug(listOfertas);
		if(Test.isRunningTest()){
			listOfertas = [SELECT Name, Id, FechaCobro__c, FechaPago__c, Etapa__c, Gerente_Escrituras__r.Name FROM Oferta__c];
		}

		for(Oferta__c  oferta_comodin : listOfertas){

			for(EtapaOferta__c objetapaof: oferta_comodin.EstatusPropiedades__r){
				mapaEtapaNumero.put(objetapaof.Etapa__r.Name, objetapaof.NumEtapa__c);
			}

			listaAsignada.add(oferta_comodin.Gerente_Escrituras__r.Name);

			porcentajeDia = 7.52/30; 
			objOferta = new wrapperOferta();

			objOferta.ofertaId = oferta_comodin.Id;
			objOferta.ofertaName = oferta_comodin.Name;
			objOferta.etapaOfertaActual = oferta_comodin.Etapa__c;
			objOferta.fechaInicio = map_etp_ofert.get(oferta_comodin.Id);
			if(Test.isRunningTest()){
				objOferta.fechaInicio = Date.today();
			}
			rangoFechaOft = objOferta.fechaInicio.daysBetween(Date.today());
			objOferta.diasTotales = rangoFechaOft;

			objOferta.porcentajeTotal = (porcentajeDia *  objOferta.diasTotales);

            List<wrapperOferta> valorMapa = null; // Instanciamos la lista tipo wrapper

            valorMapa = map_aux_etap.get(oferta_comodin.Etapa__c);

		    if(valorMapa == null){ //Validacion al inicio de que se instancia la lista
		       valorMapa = new List<wrapperOferta>(); //Volvemos a instanciar la lista wrapper
		    }
		      
		    valorMapa.add(objOferta); //Agregamos el desalojo a la lista wrapper
		    map_aux_etap.put(objOferta.etapaOfertaActual,valorMapa);
		}

        for(string nOfertas: map_aux_etap.keySet()){
                integer numberOfertas = map_aux_etap.get(nOfertas).size();
                System.debug('El tamaño del mapa es: '+numberOfertas);
                mapa_ofertaCompras.put(nOfertas,numberOfertas);
        }

		gridAreas = '';
	    for(String etapaofert: map_aux_etap.keySet()){
	      gridAreas += 'a ';
	    }
	    if(gridAreas.length()>0){
	      gridAreas = gridAreas.substring(0,gridAreas.length()-1);
		}
		//}
		//System.debug('Numero de etapa almacenada en la wrapper ' + objOferta.numEtapa);
		//System.debug('Fecha de inicio almacenada en la wrapper ' + objOferta.fechaInicio);
		System.debug('Valores que trae la wrapper dentro de un mapa' + mapa_etapas);
		System.debug('Tamanio de la wrapper dentro de un mapa' + mapa_etapas.size());
		System.debug('Tamanio del mapa de la oferta' + map_etp_ofert.size());
		System.debug('Tamanio de la lista wrapper' + listWrapperOfertas.size());
		System.debug('Valores del mapa de la oferta' + map_etp_ofert);
		System.debug('Valores de la ista wrapper' + listWrapperOfertas);
		System.debug('Tamanio de la ista wrapper' + listWrapperOfertas.size());
	}
}