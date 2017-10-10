public with sharing class ExRepEjExcelController {
   public String filterst {get;set;}
   public String filterzone {get;set;}
   public String filtergte {get;set;}
   public String filterofta {get;set;}
   public list<Oferta__c> wofertas {get;set;}
   private static map<id, Documento__c> mdocofer = new map<id, Documento__c>();
   public map<id, Documento__c> mdocmap = new map<id, Documento__c>();
   public set<id> oferids = new set<id>();
   public integer offset{get;set;} 
   public integer iLimit; 
   public Integer numHojas{get;set;} 
   public Integer hojasActual{get;set;} 
   public Integer iofertasTotal{get;set;}
   public Integer ofertasXhoja{get;set;}
   public String idLnSelect {get;set;}
   public ExRepEjExcelController()
   {
   	    filterzone = 'Todas';
   	    filtergte = 'Todos';
   }
   public List<SelectOption> getlistzoneoptions() {
            Schema.DescribeFieldResult plazas = Propiedad__c.Plaza__c.getDescribe();

            List<Schema.PicklistEntry> plazaValues = plazas.getPicklistValues();
            
            List<SelectOption> options = new List<SelectOption>();
            //options.add(new SelectOption('-- Selecciona Plaza --', '-- Selecciona Plaza --'));
            options.add(new SelectOption('Todas','Todas'));
            if (plazaValues != null && plazaValues[0] != null) {
	            for (Schema.PicklistEntry p : plazaValues)
	            { 
	               options.add(new SelectOption(p.getValue(),p.getValue())); 
	     
	            } 
            }
            
            return options;
     }
     public List<SelectOption> getlistgteoptions() {
            
            set<String> sUsers = new set<String>();
            For (Oferta__c o :[Select OwnerId, Owner.Name From Oferta__c Where Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada'])
            {
            	sUsers.add(o.OwnerId);
            }
            List<SelectOption> options = new List<SelectOption>();
            //options.add(new SelectOption('-- Selecciona Gerente --', '-- Selecciona Gerente --'));
            options.add(new SelectOption('Todos','Todos'));
            
	        for (User p : [Select Id,Name From User Where Id IN :sUsers])
	        { 
	            options.add(new SelectOption(p.Id,p.Name)); 
	     
	        } 
            
            
            return options;
     }
     public void ProcessInfo()
     {
     	map<String, set<String>> mDocumentosFaltantes = new map<String, set<String>>();
        for (Documento__c docfal :[Select id, name, DocumentoEtapa__r.NombreUsuario__c, EtapaOferta__c From Documento__c Where Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND 
                                   EtapaOferta__r.Estatus__c =: 'Abierta' AND Cerrado__c =: true AND Oferta__r.FechaCobro__c =: null Order By Oferta__c, EtapaOferta__r.Etapa__r.NumEtapa__c, DocumentoEtapa__r.Orden__c])
        {
        	if(mDocumentosFaltantes.get(docfal.EtapaOferta__c) == null)
   	    	{
   	    		mDocumentosFaltantes.put(docfal.EtapaOferta__c, new set<String> {docfal.DocumentoEtapa__r.NombreUsuario__c});
   	    	}else
   	    	{
   	    		mDocumentosFaltantes.get(docfal.EtapaOferta__c).add(docfal.DocumentoEtapa__r.NombreUsuario__c);
   	    	}
        }
        map<String, list<String>> mDocEtapa = new map<String, list<String>>();
        for (DocumentoEtapa__c docet :[Select id, NombreUsuario__c, Etapa__r.NumEtapa__c From DocumentoEtapa__c Order By Orden__c])
        {
            if(mDocEtapa.get(docet.Etapa__c) == null)
   	    	{
   	    		mDocEtapa.put(docet.Etapa__c, new list<String> {docet.NombreUsuario__c});
   	    	}else
   	    	{
   	    		mDocEtapa.get(docet.Etapa__c).add(docet.NombreUsuario__c);
   	    	}	
        }
        list<EtapaOferta__c> letofup = new list<EtapaOferta__c>();
        for (EtapaOferta__c oft :[Select id, name,Etapa__c, DocumentosFaltantes__c From EtapaOferta__c  
								Where Estatus__c =: 'Abierta' AND Oferta__r.FechaCobro__c =: null
                                 AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Etapa__r.NumEtapa__c >: 7])
        {
        	String DocFaltante = '';
		    for (String sdocfal :mDocEtapa.get(oft.Etapa__c))
		    {
				if(mDocumentosFaltantes.get(oft.id) == null)
				{
				   DocFaltante = DocFaltante + sdocfal + ';'; 
				}else if(!mDocumentosFaltantes.get(oft.id).Contains(sdocfal))
				{
				   DocFaltante = DocFaltante + sdocfal + ';'; 
				}
		    }
		    if (oft.DocumentosFaltantes__c != DocFaltante)
		    {
			    oft.DocumentosFaltantes__c = DocFaltante;
			    letofup.add(oft);
		    }
        }
        if (letofup.size() > 0)
            update letofup;
     }
     public PageReference ExpRepEj()
     {
    	ProcessInfo();
    	return new PageReference('/apex/RepEjExcel?retURL=%2F&sfdc.override=1&sop=999&fpza=' + filterzone + '&fgte=' + filtergte);
     }
}