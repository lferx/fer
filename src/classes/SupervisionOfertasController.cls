public with sharing class SupervisionOfertasController {
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
   
   public SupervisionOfertasController()
   {
   	  system.debug('Entré a IniciaController');
   	  ofertasXhoja = 50;
      offset = 0;
      ilimit = ofertasXhoja;
      Integer i = 1;
   	  hojasActual = 1;
   	  filterst = 'Todos';
   	  filterzone = 'Todas';
   	  filtergte = 'Todos';
   	  list<Oferta__c> wofertas = new list<Oferta__c>();
   	  loadInfo();
   	  system.debug('Este es el primer map de documentos.......' + offset);
   	  
   	  
     }
   public void loadInfo()
   {
   	  
   	  list<Oferta__c> lof = new list<Oferta__c>();
   	  if ( filterst == 'Todos' && filterzone == 'Todas' && filtergte == 'Todos')
   	  {  	    
   	    wofertas = [SELECT id, Name, Etapa__c, Plaza__c, Estatus__c, Owner.Name FROM Oferta__c WHERE Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada' LIMIT :iLimit OFFSET :offset]; 
   	    iofertastotal = [SELECT Count() FROM Oferta__c WHERE Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada'];
   	  }else if(filterst != 'Todos' && filterzone != 'Todas' && filtergte != 'Todos')
   	  {
   	  	wofertas = [SELECT id, Name, Etapa__c, Plaza__c, Estatus__c, Owner.Name FROM Oferta__c WHERE Estatus__c =: filterst AND Plaza__c =: filterzone  AND OwnerId =: filtergte AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada' LIMIT :iLimit OFFSET :offset ];
   	  	iofertastotal = [SELECT Count() FROM Oferta__c WHERE Estatus__c =: filterst AND Plaza__c =: filterzone  AND OwnerId =: filtergte AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada'];
   	  }else if(filterst == 'Todos' && filterzone != 'Todas' && filtergte != 'Todos')
   	  {
   	  	wofertas = [SELECT id, Name, Etapa__c, Plaza__c, Estatus__c, Owner.Name FROM Oferta__c WHERE Plaza__c =: filterzone  AND OwnerId =: filtergte AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada' LIMIT :iLimit OFFSET :offset ];
   	  	iofertastotal = [SELECT Count() FROM Oferta__c WHERE Plaza__c =: filterzone  AND OwnerId =: filtergte AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada'];
   	  }else if(filterst != 'Todos' && filterzone == 'Todas' && filtergte != 'Todos')
   	  {
   	  	wofertas = [SELECT id, Name, Etapa__c, Plaza__c, Estatus__c, Owner.Name FROM Oferta__c WHERE Estatus__c =: filterst  AND OwnerId =: filtergte AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada' LIMIT :iLimit OFFSET :offset ];
   	  	iofertastotal = [SELECT Count() FROM Oferta__c WHERE Estatus__c =: filterst  AND OwnerId =: filtergte AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada'];
   	  }else if(filterst != 'Todos' && filterzone != 'Todas' && filtergte == 'Todos')
   	  {
   	  	wofertas = [SELECT id, Name, Etapa__c, Plaza__c, Estatus__c, Owner.Name FROM Oferta__c WHERE Estatus__c =: filterst  AND Plaza__c =: filterzone AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada' LIMIT :iLimit OFFSET :offset ];
   	  	iofertastotal = [SELECT Count() FROM Oferta__c WHERE Estatus__c =: filterst  AND Plaza__c =: filterzone AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada'];
   	  }else if(filterst != 'Todos' && filterzone == 'Todas' && filtergte == 'Todos')
   	  {
   	  	wofertas = [SELECT id, Name, Etapa__c, Plaza__c, Estatus__c, Owner.Name FROM Oferta__c WHERE Estatus__c =: filterst AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada' LIMIT :iLimit OFFSET :offset ];
   	  	iofertastotal = [SELECT Count() FROM Oferta__c WHERE Estatus__c =: filterst AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada'];
   	  }else if(filterst == 'Todos' && filterzone != 'Todas' && filtergte == 'Todos')
   	  {
   	  	wofertas = [SELECT id, Name, Etapa__c, Plaza__c, Estatus__c, Owner.Name FROM Oferta__c WHERE Plaza__c =: filterzone  AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada' LIMIT :iLimit OFFSET :offset ];
   	  	iofertastotal = [SELECT Count() FROM Oferta__c WHERE Plaza__c =: filterzone  AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada'];
   	  }else if(filterst == 'Todos' && filterzone == 'Todas' && filtergte != 'Todos')
   	  {
   	  	wofertas = [SELECT id, Name, Etapa__c, Plaza__c, Estatus__c, Owner.Name FROM Oferta__c WHERE OwnerId =: filtergte AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada' LIMIT :iLimit OFFSET :offset ];
   	  	iofertastotal = [SELECT Count() FROM Oferta__c WHERE OwnerId =: filtergte AND Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada'];
   	  }
   	  if (filterofta != null)
   	  {
   	  	wofertas = [SELECT id, Name, Etapa__c, Plaza__c, Estatus__c, Owner.Name FROM Oferta__c WHERE name =: filterofta LIMIT :iLimit OFFSET :offset ];
   	  	iofertastotal = [SELECT Count() FROM Oferta__c WHERE name =: filterofta];
   	  }
   	  //wofertas = new list<wrapOfertas>();
   	  numHojas = 0; 
      Double dsizeQ = Double.valueOf(iofertasTotal)/Double.valueOf(ofertasXhoja);
      numHojas = Integer.valueOf(Math.ceil(dsizeQ)); 
   	  system.debug('Este es el wofertas.....' + wofertas);
   	  system.debug('Este es el offset.......' + offset);
   	  system.debug('Este es la hoja actual..' + hojasActual);
   }
   
   public List<SelectOption> getlistviewoptions() {
            Schema.DescribeFieldResult statusof = Oferta__c.Estatus__c.getDescribe();

            List<Schema.PicklistEntry> statusofValues = statusof.getPicklistValues();
            
            List<SelectOption> options = new List<SelectOption>();
            //options.add(new SelectOption('-- Selecciona Estatus --', '-- Selecciona Estatus --')); 
            options.add(new SelectOption('Todos','Todos'));
            if (statusofValues != null && statusofValues[0] != null) {
	            for (Schema.PicklistEntry p : statusofValues)
	            { 
	               options.add(new SelectOption(p.getValue(),p.getValue())); 
	     
	            } 
            }
            return options;
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
   public void cargaInfo()
   {
   	  ofertasXhoja = 50;
      offset = 0;
      ilimit = ofertasXhoja;
      Integer i = 1;
   	  hojasActual = 1;
   	  list<Oferta__c> wofertas = new list<Oferta__c>();
   	  loadInfo();
   }  
   public void Anterior()
    { 
        
        
        offset = offset - ofertasXhoja;
        hojasActual = hojasActual-1;
        loadinfo();      
    }  
   public void Siguiente()
    { 
        
        offset = offset + ofertasXhoja;
        hojasActual = hojasActual+1;
        loadinfo();    
    } 
   public void NumPaginaActual()
    { 
        offset = (hojasActual * ofertasXhoja)-ofertasXhoja;
        if (hojasActual>numHojas)
            hojasActual = numHojas;
        if (numHojas==0 || hojasActual == null)
            hojasActual = 1;
        loadInfo();  
    } 
   public Pagereference GenerarPasos()
   {
   	    return new PageReference('/apex/IniciarPasosEtapa?retURL=%2F&sfdc.override=1&ido=' + idLnSelect);
   	  
   }
   public Pagereference Modificar()
    {
        return new PageReference('/apex/ModificarFechas?retURL=%2F&sfdc.override=1&ido=' + idLnSelect);
    }  
   
}