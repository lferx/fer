public with sharing class ModificarFechasController {
    
    public String sIdOfertaSeleccionada {get;set;}
    public String idLnSelect {get;set;}
    public String retURL {get;set;}
    public list<Documento__c> ldocup {get;set;}
    
    public ModificarFechasController(ApexPages.Standardcontroller controlador){
        
        
        sIdOfertaSeleccionada = ApexPages.currentPage().getParameters().get('ido'); 
        
        retURL = ApexPages.currentPage().getParameters().get('retURL');
        
        CargaInfo();
    }
    public void CargaInfo()
    {
    	ldocup = [SELECT id, Oferta__c, Name, Fecha_Inicio__c, Fecha_Com_Controller__c, Tiempo_Restante__c, DocumentoEtapa__r.Obligatorio__c, 
    	          DocumentoEtapa__r.Tiempo_Proceso__c, EtapaOferta__r.NumEtapa__c, Iniciado__c, Cerrado__c, DocumentoEtapa__r.Orden__c
   	                            FROM Documento__c WHERE Oferta__c =: sIdOfertaSeleccionada 
   	                            ORDER BY EtapaOferta__r.NumEtapa__c, DocumentoEtapa__r.Orden__c];
    }
    public Pagereference ModCierre()
    {
        return new PageReference('/apex/ModCierre?retURL=%2F&sfdc.override=1&id=' + idLnSelect);
    }
    public void CerrarPaso()
    {
        Documento__c docto = new Documento__c();
        docto = [Select id, Name, Oferta__c, DocumentoEtapa__c, DocumentoEtapa__r.Ultimo_Documento__c, DocumentoEtapa__r.Obligatorio__c,
                 EtapaOferta__c, Desalojo__c, Cerrado__c, Iniciado__c, Fecha_Cierre__c, EtapaOferta__r.Etapa__c FROM Documento__c Where id =: idLnSelect];
        boolean ret;
        ret = wsUtility.ConcluyePaso(docto);
        if(ret == false)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'No se ha podido cerrar el Paso/Documento'));
            
        }else
        {
        	ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Info,'Paso Cerrado'));
        	CargaInfo();
        }
    }  
    
    public void BorrarPaso()
    {
    	Documento__c docto = new Documento__c();
        docto = [Select id, Name, Oferta__c, DocumentoEtapa__c, DocumentoEtapa__r.Ultimo_Documento__c, DocumentoEtapa__r.Obligatorio__c,
                 EtapaOferta__c, Desalojo__c, Cerrado__c, Iniciado__c, Fecha_Cierre__c, EtapaOferta__r.Etapa__c FROM Documento__c Where id =: idLnSelect];
        try
	    {
	      delete docto;
          CargaInfo();
	      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Info,'Paso Borrado'));
	      
	    }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            
        }
    }
    public void AbrirPaso()
    {
    	DateTime dFrom = DateTime.now();
    	Documento__c dinsert = new Documento__c();
        dinsert = [Select id, Name, Oferta__c, DocumentoEtapa__c, DocumentoEtapa__r.Ultimo_Documento__c, DocumentoEtapa__r.Obligatorio__c,
                   DocumentoEtapa__r.Tiempo_Proceso__c,
                   EtapaOferta__c, Desalojo__c, Cerrado__c, Iniciado__c, Fecha_Cierre__c, EtapaOferta__r.Etapa__c FROM Documento__c Where id =: idLnSelect];
        dinsert.Fecha_Inicio__c = dFrom;
	    dinsert.Fecha_Compromiso__c =wsUtility.addBusinessDays(dFrom, dinsert.DocumentoEtapa__r.Tiempo_Proceso__c);
	    dinsert.Fecha_Com_Controller__c = wsUtility.addBusinessDays(dFrom, dinsert.DocumentoEtapa__r.Tiempo_Proceso__c);
	    dinsert.Iniciado__c = true; 
	    dinsert.Cerrado__c = false;
	    
	    EtapaOferta__c doce = new EtapaOferta__c();
	    doce = [Select Estatus__c, HoraFinal__c from EtapaOferta__c Where id =: dinsert.EtapaOferta__c];
	    doce.Estatus__c = 'Abierta';
        doce.HoraFinal__c = null;
	    try
	    {
	      update dinsert;         
          update doce;
          CargaInfo();
	      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Info,'Paso Iniciado'));
	      
	    }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            
        }
	    
    }   
    
}