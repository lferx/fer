public with sharing class Panel_Fijo_Infonavit_Controller {

	public List<EtapaOferta__c> ofertas {get;set;}

	public List<EtapaOferta__c> ofertasRicardo10sem1 {get;set;}
	public List<EtapaOferta__c> ofertasRicardo11sem1 {get;set;}
	public List<EtapaOferta__c> ofertasRicardo12sem1 {get;set;}
	public List<EtapaOferta__c> ofertasAmira10sem1 {get;set;}
	public List<EtapaOferta__c> ofertasAmira11sem1 {get;set;}
	public List<EtapaOferta__c> ofertasAmira12sem1 {get;set;}
	public List<EtapaOferta__c> ofertasNadia10sem1 {get;set;}
	public List<EtapaOferta__c> ofertasNadia11sem1 {get;set;}
	public List<EtapaOferta__c> ofertasNadia12sem1 {get;set;}

	public List<EtapaOferta__c> ofertasRicardo10sem2 {get;set;}
	public List<EtapaOferta__c> ofertasRicardo11sem2 {get;set;}
	public List<EtapaOferta__c> ofertasRicardo12sem2 {get;set;}
	public List<EtapaOferta__c> ofertasAmira10sem2 {get;set;}
	public List<EtapaOferta__c> ofertasAmira11sem2 {get;set;}
	public List<EtapaOferta__c> ofertasAmira12sem2 {get;set;}
	public List<EtapaOferta__c> ofertasNadia10sem2 {get;set;}
	public List<EtapaOferta__c> ofertasNadia11sem2 {get;set;}
	public List<EtapaOferta__c> ofertasNadia12sem2 {get;set;}

	public List<EtapaOferta__c> ofertasRicardo10sem3 {get;set;}
	public List<EtapaOferta__c> ofertasRicardo11sem3 {get;set;}
	public List<EtapaOferta__c> ofertasRicardo12sem3 {get;set;}
	public List<EtapaOferta__c> ofertasAmira10sem3 {get;set;}
	public List<EtapaOferta__c> ofertasAmira11sem3 {get;set;}
	public List<EtapaOferta__c> ofertasAmira12sem3 {get;set;}
	public List<EtapaOferta__c> ofertasNadia10sem3 {get;set;}
	public List<EtapaOferta__c> ofertasNadia11sem3 {get;set;}
	public List<EtapaOferta__c> ofertasNadia12sem3 {get;set;}

	public Integer tamanoRic10Sem1 {get;set;}
	public Integer tamanoRic10Sem2 {get;set;}
	public Integer tamanoRic10Sem3 {get;set;}
	public Integer tamanoAmi10Sem1 {get;set;}
	public Integer tamanoAmi10Sem2 {get;set;}
	public Integer tamanoAmi10Sem3 {get;set;}
	public Integer tamanoNad10Sem1 {get;set;}
	public Integer tamanoNad10Sem2 {get;set;}
	public Integer tamanoNad10Sem3 {get;set;}

	public Integer tamanoRic11Sem1 {get;set;}
	public Integer tamanoRic11Sem2 {get;set;}
	public Integer tamanoRic11Sem3 {get;set;}
	public Integer tamanoAmi11Sem1 {get;set;}
	public Integer tamanoAmi11Sem2 {get;set;}
	public Integer tamanoAmi11Sem3 {get;set;}
	public Integer tamanoNad11Sem1 {get;set;}
	public Integer tamanoNad11Sem2 {get;set;}
	public Integer tamanoNad11Sem3 {get;set;}

	public Integer tamanoRic12Sem1 {get;set;}
	public Integer tamanoRic12Sem2 {get;set;}
	public Integer tamanoRic12Sem3 {get;set;}
	public Integer tamanoAmi12Sem1 {get;set;}
	public Integer tamanoAmi12Sem2 {get;set;}
	public Integer tamanoAmi12Sem3 {get;set;}
	public Integer tamanoNad12Sem1 {get;set;}
	public Integer tamanoNad12Sem2 {get;set;}
	public Integer tamanoNad12Sem3 {get;set;}

	public Panel_Fijo_Infonavit_Controller() {
		tamanoRic10Sem1 = 0;
		tamanoRic10Sem2 = 0;
		tamanoRic10Sem3 = 0;
		tamanoAmi10Sem1 = 0;
		tamanoAmi10Sem2 = 0;
		tamanoAmi10Sem3 = 0;
		tamanoNad10Sem1 = 0;
		tamanoNad10Sem2 = 0;
		tamanoNad10Sem3 = 0;

		tamanoRic11Sem1 = 0;
		tamanoRic11Sem2 = 0;
		tamanoRic11Sem3 = 0;
		tamanoAmi11Sem1 = 0;
		tamanoAmi11Sem2 = 0;
		tamanoAmi11Sem3 = 0;
		tamanoNad11Sem1 = 0;
		tamanoNad11Sem2 = 0;
		tamanoNad11Sem3 = 0;

		tamanoRic12Sem1 = 0;
		tamanoRic12Sem2 = 0;
		tamanoRic12Sem3 = 0;
		tamanoAmi12Sem1 = 0;
		tamanoAmi12Sem2 = 0;
		tamanoAmi12Sem3 = 0;
		tamanoNad12Sem1 = 0;
		tamanoNad12Sem2 = 0;
		tamanoNad12Sem3 = 0;

		ofertasRicardo10sem1 = new List<EtapaOferta__c>();
		ofertasRicardo11sem1 = new List<EtapaOferta__c>();
		ofertasRicardo12sem1 = new List<EtapaOferta__c>();
		ofertasAmira10sem1 = new List<EtapaOferta__c>();
		ofertasAmira11sem1 = new List<EtapaOferta__c>();
		ofertasAmira12sem1 = new List<EtapaOferta__c>();
		ofertasNadia10sem1 = new List<EtapaOferta__c>();
		ofertasNadia11sem1 = new List<EtapaOferta__c>();
		ofertasNadia12sem1 = new List<EtapaOferta__c>();

		ofertasRicardo10sem2 = new List<EtapaOferta__c>();
		ofertasRicardo11sem2 = new List<EtapaOferta__c>();
		ofertasRicardo12sem2 = new List<EtapaOferta__c>();
		ofertasAmira10sem2 = new List<EtapaOferta__c>();
		ofertasAmira11sem2 = new List<EtapaOferta__c>();
		ofertasAmira12sem2 = new List<EtapaOferta__c>();
		ofertasNadia10sem2 = new List<EtapaOferta__c>();
		ofertasNadia11sem2 = new List<EtapaOferta__c>();
		ofertasNadia12sem2 = new List<EtapaOferta__c>();

		ofertasRicardo10sem3 = new List<EtapaOferta__c>();
		ofertasRicardo11sem3 = new List<EtapaOferta__c>();
		ofertasRicardo12sem3 = new List<EtapaOferta__c>();
		ofertasAmira10sem3 = new List<EtapaOferta__c>();
		ofertasAmira11sem3 = new List<EtapaOferta__c>();
		ofertasAmira12sem3 = new List<EtapaOferta__c>();
		ofertasNadia10sem3 = new List<EtapaOferta__c>();
		ofertasNadia11sem3 = new List<EtapaOferta__c>();
		ofertasNadia12sem3 = new List<EtapaOferta__c>();

		ofertas = [SELECT id,Cerrada__c,Etapa__r.name,FechaCierre__c,Name,Oferta__c,Oferta__r.Plaza__c,Oferta__r.Direccion2__c,Oferta__r.TipoOferta__c,Oferta__r.ClienteFinal__c,Oferta__r.Promotor__r.name,Oferta__r.Subsidio__c,HoraInicial__c,Fecha_Prevista__c,DocumentosFaltantes__c,Oferta__r.Comentarios_del_Gerente__c,Oferta__r.Gerente_Operativo__r.name,NumEtapa__c,Oferta__r.Estatus__c FROM EtapaOferta__c WHERE ((NumEtapa__c IN (10.0,10.1,11.0,12.0) AND Oferta__r.Estatus_de_invasion__c != 'Invadida') OR (NumEtapa__c IN (11.0,12.0) AND Oferta__r.Estatus_de_invasion__c = 'Invadida')) AND Oferta__r.Gerente_Operativo__r.name IN ('Ricardo Hernandez Bárcena','Amira Haide Trejo Aranda','Nadia Veronica Rosas Torres') AND Oferta__r.Estatus__c != 'Descartada' AND Oferta__r.FechaCobro__c = NULL AND EtapaActual__c = true AND Oferta__r.TipoOferta__c != 'Contado' AND Oferta__r.FechaPago__c != NULL AND (NOT Oferta__r.Inversor2__c LIKE 'Regeneradora%') order by NumEtapa__c];
	
		proceso();
	}


	public void proceso(){

		for(EtapaOferta__c ofer: ofertas){
			if(ofer.Oferta__r.Gerente_Operativo__r.name == 'Ricardo Hernandez Bárcena'){
				
				if(ofer.NumEtapa__c == 10.0){
					ofertasRicardo10sem1.add(ofer);
				}
				else if(ofer.NumEtapa__c == 11.0){
					ofertasRicardo11sem1.add(ofer);
				} 
				else if(ofer.NumEtapa__c == 12.0){
					ofertasRicardo12sem1.add(ofer);
				}
			}
			else if(ofer.Oferta__r.Gerente_Operativo__r.name == 'Amira Haide Trejo Aranda'){
				
				if(ofer.NumEtapa__c == 10.0){
					ofertasAmira10sem1.add(ofer);
				}
				else if(ofer.NumEtapa__c == 11.0){
					ofertasAmira11sem1.add(ofer);
				} 
				else if(ofer.NumEtapa__c == 12.0){
					ofertasAmira12sem1.add(ofer);
				}
			}
			else if(ofer.Oferta__r.Gerente_Operativo__r.name == 'Nadia Veronica Rosas Torres'){
				
				if(ofer.NumEtapa__c == 10.0){
					ofertasNadia10sem1.add(ofer);
				}
				else if(ofer.NumEtapa__c == 11.0){
					ofertasNadia11sem1.add(ofer);
				} 
				else if(ofer.NumEtapa__c == 12.0){
					ofertasNadia12sem1.add(ofer);
				}
			}

		}



		if(ofertasRicardo10sem1.size() > 0){
			tamanoRic10Sem1 = ofertasRicardo10sem1.size() * 5;	
		}
		if(ofertasRicardo11sem1.size() > 0){
			tamanoRic11Sem1 = ofertasRicardo11sem1.size() * 5;	
		}
		if(ofertasRicardo12sem1.size() > 0){
			tamanoRic12Sem1 = ofertasRicardo12sem1.size() * 5;	
		}

		
		if(ofertasAmira10sem1.size() > 0){
			tamanoAmi10Sem1 = ofertasAmira10sem1.size() * 5;	
		}
		if(ofertasAmira11sem1.size() > 0){
			tamanoAmi11Sem1 = ofertasAmira11sem1.size() * 5;	
		}
		if(ofertasAmira12sem1.size() > 0){
			tamanoAmi12Sem1 = ofertasAmira12sem1.size() * 5;	
		}


		
		if(ofertasNadia10sem1.size() > 0){
			tamanoNad10Sem1 = ofertasNadia10sem1.size() * 5;	
		}
		if(ofertasNadia11sem1.size() > 0){
			tamanoNad11Sem1 = ofertasNadia11sem1.size() * 5;	
		}
		if(ofertasNadia12sem1.size() > 0){
			tamanoNad12Sem1 = ofertasNadia12sem1.size() * 5;	
		}
		

	}


}