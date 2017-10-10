public with sharing class pruebas_Controller
{
	
	public List<Oferta__c> mioferta {get;set;} //query que trae todos los registros diferentes de descartada
	//public List<Oferta__c> mifiltro {get;set;}
	//public Oferta__c std {get;set;}
	public List<Oferta__c> nL {get;set;} //variable lista que guarda el query Qrt
	public String parametro {get;set;}

	String convertS;
	String y;	
	String variable; //convierte obj a string	
	List<AggregateResult> filtroetapas; //lista para agregar query con ciclo for
	List<AggregateResult> etq;
	//String sttus;
	String etsv='';


	public List<SelectOption> status {get;set;} //variablelista para estatus

public List<SelectOption> etlst;
  String ets='';
   String[] EtapaSelec = new String[]{};
  public String[] getEtapaSelec(){return EtapaSelec;}
     public void setEtapaSelec(String[] EtapaSelec) {this.EtapaSelec = EtapaSelec;}

	//public List<SelectOption> etapas {get;set;} 
	//String ets='';
 //   String[] EtapasSelec = new String[]{};
 //   public String[] getEtapasSelec(){return EtapasSelec;}
 //   public void setEtapasSelec(String[] EtapasSelec) {this.EtapasSelec = EtapasSelec;}

    //public List<SelectOption> getEtapas()
				//	{    
				//	        List<SelectOption> etapas = new List<SelectOption>();
				//	        etapas.add(new SelectOption('Todo','-- Todos --'));
				//		for(AggregateResult x : filtroetapas)
				//		{
				//            		variable = (String) x.get('Name');
				//            		if(variable == null){
				//                	etapas.add(new SelectOption('','ERROR'));
				//            	}
				//            	else
				//            	{
				//                	etapas.add(new SelectOption(variable,variable));
				//            	}
				//        }    
				//        			return etapas;    
				//    }
public List<SelectOption> getetlst(){
   
        List<SelectOption> etlst = new List<SelectOption>();
        y='';
        etlst.add(new SelectOption('Todo','-- Todas --'));
        for(AggregateResult x : etq){
            convertS = (String) x.get('Etapa__c');
            if(convertS == null){
                etlst.add(new SelectOption('','ERROR'));
            }else{
                if(convertS == 'Antecedentes'){y ='Etapa 4';}else if(convertS == 'Aprobada internamente'){y ='Etapa 5';}else if(convertS == 'Compilación expediente compra'){y ='Etapa 6';} else if(convertS == 'Compra final'){y='Etapa 7';} else if(convertS == 'Escrituras en proceso registro'){y='Etapa 8';} else if(convertS == 'Compilación expediente cliente'){y='Etapa 9';} else if(convertS == 'Rehabilitación'){y='Etapa 10';}else{y=convertS;}
                etlst.add(new SelectOption(convertS,y));
            }
        }
        return etlst;    
    }
    

				    public void actualizar(){
										for(integer i=0; i < EtapaSelec.size();i++)
										{
										            if(this.EtapaSelec[i]== 'Todo'){    
										            	ets ='';        
										            	break;     
										            }
										            else if(i==0){                      
										            	ets ='\''+this.EtapaSelec[i]+'\'';
										            			}
										            else{                               
										            	ets +=',\''+this.EtapaSelec[i]+'\'';    
										            	}
										}
					if(ets == '')   {etsv='';   }     else{etsv=' Etapa__c IN('+ets+') ';}
		etq=Database.query('SELECT Etapa__c FROM Oferta__c  GROUP BY Etapa__c');

									}
				     //lista de seleccion de etapa//////////////////////////////////////////////////////////
    //public List<SelectOption> getetlst(){
   
    //    List<SelectOption> etlst = new List<SelectOption>();
    //    y='';
    //    etlst.add(new SelectOption('Todo','-- Todas --'));
    //    for(AggregateResult x : etq){
    //        convertS = (String) x.get('Etapa__c');
    //        if(convertS == null){
    //            etLst.add(new SelectOption('','ERROR'));
    //        }else{
    //            if(convertS == 'Antecedentes'){y ='Etapa 4';}else if(convertS == 'Aprobada internamente'){y ='Etapa 5';}else if(convertS == 'Compilación expediente compra'){y ='Etapa 6';} else if(convertS == 'Compra final'){y='Etapa 7';} else if(convertS == 'Escrituras en proceso registro'){y='Etapa 8';} else if(convertS == 'Compilación expediente cliente'){y='Etapa 9';} else if(convertS == 'Rehabilitación'){y='Etapa 10';}else{y=convertS;}
    //            etLst.add(new SelectOption(convertS,y));
    //        }
    //    }
    //    return etlst;    
    //}




						public List<SelectOption> getEstatus()
					{    
					        List<SelectOption> status = new List<SelectOption>();
					        status.add(new SelectOption('Todas','-- Todas --'));
					        status.add(new SelectOption('En proceso','-- En proceso --'));
					        status.add(new SelectOption('Firmada','-- Firmada --'));
					        status.add(new SelectOption('Oferta','-- Oferta --'));
					        status.add(new SelectOption('Pagada','-- Pagada --'));
					        status.add(new SelectOption('No cobrada','-- No cobrada --'));
					        status.add(new SelectOption('Pendiente','-- Pendiente --'));
						
				        			return status;    
				    }

		public pruebas_Controller()
		{
			 parametro = '';



				mioferta=[SELECT Id,Estatus__c,Name FROM Oferta__c WHERE Estatus__c != 'Descartada'];
		}

				public PageReference test(){
					return null;
				}

		public void filtroEstatus()

		{	

		
		//std
				if(parametro == 'Todas'){
					nL=[SELECT Name, Id, Estatus__c,Etapa__c FROM Oferta__c ];
				}else{
					nL= [SELECT Name, Id, Estatus__c,Etapa__c FROM Oferta__c where Estatus__c =: parametro]; //Query Qrt
				}



//Name IN ('Escrituras Registradas','Carta de desalojo')
//Oferta__c miVariable = new Oferta__c(Estatus__c = myTestString);



//SELECT Estatus__c FROM Oferta__c where Estatus__c = 'En proceso'

		//List<Oferta__c> mifiltro = new List<Oferta__c>();
  //      mifiltro = Database.query('SELECT Id,Estatus__c,Name FROM Oferta__c WHERE Estatus__c ' + sttus);
        
		
		//Id idRegistro = ApexPages.currentPage().getParameters().get('id');
		//try
		//{ where Id =: idRegistro];  from Account where Id =: idRegistro];
		//		if(std.Estatus__c!=null)
		//		{
		//			mifiltro=[SELECT Id,Estatus__c,Name FROM Oferta__c WHERE Estatus__c=:std.Estatus__c];
		//		}
		//}
		//	catch(Exception bitch)
		//	{
				
		//  	}

		}
		public PageReference regresa(){
			return Page.prueba2;
		}


}




 //String[] countries {get;set;}

 //       //String[] countries = new String[]{};

             

 //       public PageReference test() {

 //           return null;

 //       }

             

 //       public List<SelectOption> getItems() {

 //           List<SelectOption> options = new List<SelectOption>();

 //           options.add(new SelectOption('US','US'));

 //           options.add(new SelectOption('CANADA','Canada'));

 //           options.add(new SelectOption('MEXICO','Mexico'));

 //           return options;

 //       }

             

 //       public String[] getCountries() {

 //           return countries;

 //       }

             

 //       public void setCountries(String[] countries) {

 //           this.countries = countries;

 //       }

    

	
	//public List<Oferta__c> mioferta {get;set;}
	//public List<Oferta__c> mifiltro {get;set;}
	//public Oferta__c std {get;set;}

	//public List<SelectOption> getEstatus()
	//				{    
	//				        List<SelectOption> status = new List<SelectOption>();
	//				        status.add(new SelectOption('Todo','-- Todos --'));
	//					for(AggregateResult x : filtrostatus)
	//					{
	//			            		variable = (String) x.get('Name');
	//			            		if(variable == null){
	//			                	status.add(new SelectOption('','ERROR'));
	//			            	}
	//			            	else
	//			            	{
	//			                	status.add(new SelectOption(variable,variable));
	//			            	}
	//			        }    
	//			        			return status;    
	//			    }

		
		



	//public pruebas_Controller()
	//{

	// mioferta=[SELECT Id,Estatus__c,Name FROM Oferta__c WHERE Estatus__c != 'Descartada'];
	//}

	//public void filtroEstatus()
	//{
	//	try
	//	{
	//			if(std.Estatus__c!=null)
	//			{
	//				mifiltro=[SELECT Id,Estatus__c,Name FROM Oferta__c WHERE Estatus__c=:std.Estatus__c];
	//			}
	//	}
	//		catch(Exception bitch)
	//		{
				
	//	  	}

	//}