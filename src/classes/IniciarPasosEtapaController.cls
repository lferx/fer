public with sharing class IniciarPasosEtapaController {
    public String sIdOfertaSeleccionada {get;set;}
    public String idLnSelect {get;set;}
    public String retURL {get;set;}
    public list<DocumentoEtapa__c> ldocup {get;set;}
    public string sOferta {get;set;}
    public string sEtapa {get;set;}
    public EtapaOferta__c etpa = new EtapaOferta__c();
    public Oferta__c ofta = new Oferta__c();
    public IniciarPasosEtapaController(ApexPages.Standardcontroller controlador){
        
        
        sIdOfertaSeleccionada = ApexPages.currentPage().getParameters().get('ido'); 
        
        retURL = ApexPages.currentPage().getParameters().get('retURL');
        
        CargaInfo();
    }
    public void CargaInfo()
    {
    	
   	    etpa = [Select id, name, Oferta__c, NumEtapa__c From EtapaOferta__c Where Oferta__c =: sIdOfertaSeleccionada and Estatus__c = : 'Abierta' Order by NumEtapa__c Limit 1];
   	    
   	    ofta = [Select id, name from Oferta__c where id =: sIdOfertaSeleccionada];
   	    
   	    sOferta = 'Oferta: ' + ofta.name;
   	    sEtapa = 'Etapa: ' + etpa.NumEtapa__c + '.. ' + etpa.name;
    	ldocup = [SELECT id, Name, Orden__c 
   	                            FROM DocumentoEtapa__c WHERE (Etapa_Paso_Anterior__c <: etpa.NumEtapa__c) AND (Etapa__r.NumEtapa__c =: etpa.NumEtapa__c) Order by Orden__c];
    }
    
    public void IniciarEtapa()
   {
   	    
   	    boolean ret;
   	    ret = wsUtility.CrearPasoMigracion(etpa);   
   	    if (ret == false)
   	    {
            
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error,'Error al iniciar pasos de la Etapa ');
            ApexPages.addMessage(msg);
        }else
        {
        	ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Info,'Pasos Iniciados Correctamente ');
            ApexPages.addMessage(msg);
        }
   }
    public Pagereference ModCierre()
    {
        return new PageReference('/apex/ModCierre?retURL=%2F&sfdc.override=1&id=' + idLnSelect);
    }  
}