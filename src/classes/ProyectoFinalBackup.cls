public with sharing class ProyectoFinalBackup {
 public List<Oferta__c> Etapas {get;set;}
    //Menu Pincipal Primera Parte
   public String filterst {get;set;}
   public String filterzone {get;set;}
   public String filterzone2 {get;set;}
   public String filterzone3 {get;set;}
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
   //variables agregadas por Hector
   public List<Estados__c> estados {get;set;}
   public List<Ciudad__c> ciudades {get;set;}
   public List<ColoniaFraccionamiento__c> colonias {get;set;}
   
   
   public list<Documento__c> ldocplaza {get;set;}
   public date dhoy {get;set;}
   public datetime dthoy;
   public date dIniSem;
   public date dFinSem; 
   public string shoy {get;set;}
   public string stockhoy {get;set;}
   public map<String, User> musers = new map<String, User>();
       
   public integer iRmetaMensual {get;set;}
   public integer iRmetaDiaria {get;set;}
   public integer iEmetaSemanal {get;set;}
   public integer iEmetaDiaria {get;set;}
   public integer iOmetaSemanal {get;set;}
   public integer iOmetaDiaria {get;set;}
   
   
   //Menu Secundario Segunda Parte
   
   public list<Oferta__c> lofertas {get; set;}
   public string sEtapa {get; set;}
   public integer itotal {get; set;}
    
   
   
   
   //Otros
   public map<Integer, String> mEtapaName = new map<Integer, String>();
   list<EtapaOferta__c> lEtapaOfI {get; set;}
   list<EtapaOferta__c> lEtapaOfF {get; set;}
   public map<Integer, list<EtapaOferta__c>> mEtapaOfE = new map<Integer, list<EtapaOferta__c>>();
   public map<Integer, list<EtapaOferta__c>> mEtapaOfS = new map<Integer, list<EtapaOferta__c>>();
   public map<Integer, Integer> mResEtEnt = new map<Integer, Integer>();
   public map<Integer, Integer> mResEtSal = new map<Integer, Integer>();
   
   
    
     
    
    
    
    
    
    //Inicio FILTROS
    
    
    
     {
         filterzone = 'Todas';
         filtergte = 'Completo';
         filterzone2 = 'Todo Tipo';
         filterzone3 = 'Seleccion';
         
   }
   
   //Prueba inicio
    public List<SelectOption> getlistzoneoptions2() {
            /*
            Schema.DescribeFieldResult plazas = Propiedad__c.Tipo__c.getDescribe();

            List<Schema.PicklistEntry> plazaValues = plazas.getPicklistValues();
            
            List<SelectOption> options = new List<SelectOption>();
            //options.add(new SelectOption('-- Selecciona Plaza --', '-- Selecciona Plaza --'));
            options.add(new SelectOption('Todo Tipo','Todo Tipo'));
            if (plazaValues != null && plazaValues[0] != null) {
              for (Schema.PicklistEntry p : plazaValues)
              { 
                 options.add(new SelectOption(p.getValue(),p.getValue())); 
       
              } 
            }
            */
            
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('Todas','Todas'));
            
            for(ColoniaFraccionamiento__c col: colonias){
                
                options.add(new SelectOption(col.Name,col.Name));
            }
            
            return options;
     }
   
   //Prueba Final
   
  
   
   //Prueba inicio
    public List<SelectOption> getlistzoneoptions3() {
            Schema.DescribeFieldResult plazas = Propiedad__c.Niveles_Plantas__c.getDescribe();

            List<Schema.PicklistEntry> plazaValues = plazas.getPicklistValues();
            
            List<SelectOption> options = new List<SelectOption>();
            //options.add(new SelectOption('-- Selecciona Plaza --', '-- Selecciona Plaza --'));
            options.add(new SelectOption('Seleccion','Seleccion'));
            if (plazaValues != null && plazaValues[0] != null) {
              for (Schema.PicklistEntry p : plazaValues)
              { 
                 options.add(new SelectOption(p.getValue(),p.getValue())); 
       
              } 
            }
            
            return options;
     }
   
   //Prueba Final
   
   public List<SelectOption> getlistzoneoptions() {
   
            /*Schema.DescribeFieldResult plazas = Propiedad__c.Plaza__c.getDescribe();

            List<Schema.PicklistEntry> plazaValues = plazas.getPicklistValues();
            
            List<SelectOption> options = new List<SelectOption>();
            //options.add(new SelectOption('-- Selecciona Plaza --', '-- Selecciona Plaza --'));
            options.add(new SelectOption('Todas','Completo'));
            if (plazaValues != null && plazaValues[0] != null) {
              for (Schema.PicklistEntry p : plazaValues)
              { 
                 options.add(new SelectOption(p.getValue(),p.getValue())); 
       
              } 
            }
            */
            
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('Todas','Completo'));
            
            for(Estados__c edo: estados){
                
                options.add(new SelectOption(edo.Name,edo.Name));
            }
            
            return options;
     }
     
     public List<SelectOption> getlistgteoptions() {
            /*
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
            */
            
          List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('Todos','Todos'));
            
            for(Ciudad__c cd: ciudades){
                
                options.add(new SelectOption(cd.Name,cd.Name));
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
      return new PageReference('/apex/RepEjExcel2?retURL=%2F&sfdc.override=1&sop=999&fpza=' + filterzone + '&fgte=' + filtergte);
     }
     
     public PageReference ExpRepEj2()
     {
      ProcessInfo();
      return new PageReference('/apex/RepEjExcel3?retURL=%2F&sfdc.override=1&sop=999&fpza=' + filterzone + '&fgte=' + filtergte);
     }
     
     
     //INICIO STOCK
     
     public ProyectoFinalBackup()
    { 
        //agregado por Hector
        estados = [Select Name FROM Estados__c];
        ciudades = [Select Name FROM Ciudad__c];
        colonias = [Select Name FROM ColoniaFraccionamiento__c];
        
        
        
        
    {
     /*Etapas = [Select Etapa__c,Plaza__c,Oferta__c.name,Oferta__c.Owner.Name,PrecioVenta__c,ValorReferencia__c,Promotor__c from Oferta__c WHERE FechaCobro__c = null AND FechaPago__c != null AND Estatus__c != 'Descartada' AND Etapa__c IN ('Compilación expediente compra','Compra final','Escrituras en proceso registro','Compilación expediente cliente') ]; */
       Etapas = [Select id, name, Owner.name, Propiedad__r.Plaza__c,Propiedad__r.Tipo__c,Direccion2__c,Propiedad__r.Colonia__c,Propiedad__r.Terreno_m2__c,Propiedad__r.Construccion_m2__c,Propiedad__r.N_de_Habitaciones__c,Propiedad__r.N_de_Ba_os__c,PrecioVenta__c,ValorReferencia__c,EtapaOferta__r.NumEtapa__c From Oferta__c 
                 WHERE FechaCobro__c = null 
                 AND FechaPago__c != null 
                 AND Estatus__c != 'Descartada' 
                 AND Etapa__c IN ('Compilación expediente compra','Compra final','Escrituras en proceso registro','Compilación expediente cliente')];
                 system.debug(estados);
                 system.debug('Hola');
   }
     
     }
 }