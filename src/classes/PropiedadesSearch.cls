/*******************************************************************
 * Visualforce Development Cookbook Recipe 4_10
 * 
 * Custom controller for the "Form Based Searching" recipe.
 * Executes a search via SOQL based on the fields the user has 
 * entered on the associated Visualforce page.
 *******************************************************************/
public with sharing class PropiedadesSearch
{
     public ApexPages.StandardController controller {get; set;}
     public Account account;

     public List<Attachment> fotos {get; set;}


   //guardar Historial
    Public Historial_de_Envios_de_Ficha_Tecnica__c historial {get; set;}
/*    public Historial_de_Envios_de_Ficha_Tecnica__c getHistorial()
    {
        return historial;
    }
    */
   

//guardar Historial






  //-----paginacion

    
    //List to show the limited records on the page
    public List<PropiedadWrapper> PropiedadesShow {get;set;}
    public PropiedadWrapper pw2 {get;set;}
    public Id accountid {get;set;}
    
    //Navigation variables
    Integer counter = 0;//TO track the number of records parsed
    Integer limitSize = 5;//Number of records to be displayed
    Integer totalSize =0; //To Store the total number of records available
 //---------paginacion   
    
    

    public PropiedadesSearch(ApexPages.StandardController controller) {
    
        this.controller = controller;
        this.account= (Account)controller.getRecord();
        accountid=account.id;
        PropiedadesSearchInit();

    }

    // the search results
    
    public List<PropiedadWrapper> results { get; set;}
    
    // the account instance to capture the search criteria
    public Propiedad__c searchProp {get; set;}
    
    // the industry picklist options to allow selection of more than one
    public List<SelectOption> plazasOptions=new List<SelectOption>();
    public List<SelectOption> habitacionesOptions=new List<SelectOption>();
    public List<SelectOption> banosOptions=new List<SelectOption>();
    public List<SelectOption> tipoPropOptions=new List<SelectOption>();
    public List<SelectOption> nivPropOptions=new List<SelectOption>();
    
    // the chosen industries
    public String[] plazas{get; set;}
    public String[] habitaciones{get; set;}
    public String[] banos{get; set;}
    public String[] tipoprop{get; set;}
    public String[] nivprop{get; set;}
    public String queryStr{get; set;}
   

 
 public List<PropiedadWrapper> selectedResults {
        get {
            if (selectedResults== null) selectedResults= new List<PropiedadWrapper>();
            return selectedResults;
        }
        set;
    }       
    
    public List<String> resultsPDF {
        get {
            if (resultsPDF == null) resultsPDF = new List<String>();
            return resultsPDF ;
        }
        set;
    }
    

    
    
    // constructor
    public void PropiedadesSearchInit()
    {
        plazas=new List<String>();
        habitaciones=new List<String>();
        banos=new List<String>();
        tipoprop=new List<String>();
        nivprop=new List<String>();
        searchProp=new Propiedad__c();
        selectedResults= new List<PropiedadWrapper>();
        results = new List<PropiedadWrapper>();
    }
    
    //Return value
    public PageReference DummyAction () {
    return null;
    }
    
    
    // determine the industry options by interrogating the schema
    public List<SelectOption> getplazasOptions()
    {
       if (plazasOptions.isEmpty())
       {
           Schema.DescribeFieldResult fieldDesc = Propiedad__c.Plaza__c.getDescribe();
           List<Schema.PicklistEntry> plEntries = fieldDesc.getPicklistValues();
           
           for (Schema.PickListEntry plEntry : plEntries)
           {
              SelectOption option=new SelectOption(plEntry.getValue(), plEntry.getLabel());
              plazasOptions.add(option); 
           }
       }    
       
       return plazasOptions;
    }
    
        public List<SelectOption> gethabitacionesOptions()
    {
       if (habitacionesOptions.isEmpty())
       {
           Schema.DescribeFieldResult fieldDesc = Propiedad__c.N_de_Habitaciones__c.getDescribe();
           List<Schema.PicklistEntry> plEntries = fieldDesc.getPicklistValues();
           
           for (Schema.PickListEntry plEntry : plEntries)
           {
              SelectOption option=new SelectOption(plEntry.getValue(), plEntry.getLabel());
              habitacionesOptions.add(option); 
           }
       }    
       
       return habitacionesOptions;
    }
    
        public List<SelectOption> getbanosOptions()
    {
       if (banosOptions.isEmpty())
       {
           Schema.DescribeFieldResult fieldDesc = Propiedad__c.N_de_Ba_os__c.getDescribe();
           List<Schema.PicklistEntry> plEntries = fieldDesc.getPicklistValues();
           
           for (Schema.PickListEntry plEntry : plEntries)
           {
              SelectOption option=new SelectOption(plEntry.getValue(), plEntry.getLabel());
              banosOptions.add(option); 
           }
       }    
       
       return banosOptions;
    }
    
        public List<SelectOption> gettipoPropOptions()
    {
       if (tipoPropOptions.isEmpty())
       {
           Schema.DescribeFieldResult fieldDesc = Propiedad__c.Tipo__c.getDescribe();
           List<Schema.PicklistEntry> plEntries = fieldDesc.getPicklistValues();
           
           for (Schema.PickListEntry plEntry : plEntries)
           {
              SelectOption option=new SelectOption(plEntry.getValue(), plEntry.getLabel());
              tipoPropOptions.add(option);
           }
       }
       
       return tipoPropOptions;
    }
    
        public List<SelectOption> getnivPropOptions()
    {
       if (nivPropOptions.isEmpty())
       {
           Schema.DescribeFieldResult fieldDesc = Propiedad__c.Niveles_Plantas__c.getDescribe();
           List<Schema.PicklistEntry> plEntries = fieldDesc.getPicklistValues();
           
           for (Schema.PickListEntry plEntry : plEntries)
           {
              SelectOption option=new SelectOption(plEntry.getValue(), plEntry.getLabel());
              nivPropOptions.add(option); 
           }
       }    
       
       return nivPropOptions;
    }
    
    public void reset(){
 
 if (results== null) {
            results= new List<PropiedadWrapper>();
            PropiedadesShow= new List <PropiedadWrapper>(); // init the list if it is null
        } else {
            results.clear(); // clear out the current results if they exist
            plazas.clear();
            habitaciones.clear();
            banos.clear();
            tipoprop.clear();
            nivprop.clear();
            PropiedadesShow.clear();
        }
}
    
    // action method to search for accounts matching the criteria
    public PageReference executeSearch()
    {
        //Get all the contacts which are from Public realations lead source
        
        if (results== null) {
            results= new List<PropiedadWrapper>(); // init the list if it is null
        } else {
            results.clear(); // clear out the current results if they exist
        }
                if (PropiedadesShow== null) {
            PropiedadesShow= new List<PropiedadWrapper>(); // init the list if it is null
        } else {
            PropiedadesShow.clear(); // clear out the current results if they exist
        }
        
        
         String whereStr='';
        
        
        
        // -------------------- Search clauses------------
            // only add a name clause if the user has entered some text
        if (!String.IsEmpty(searchProp.Name))
        {
           String wcName = searchProp.Name ;
            whereStr+=' AND Name LIKE \'%' + wcName + '%\'';
          
           // whereStr+=' OR p.Name LIKE \'%' + wcName + '%\''; 
            
        }

      // only add a name clause if the user has entered some text
        if (!String.IsEmpty(searchProp.CP__c))
        {
            String wcCPc ='%' + searchProp.CP__c + '%';
            whereStr+=' AND p.CP__c LIKE \'%' + wcCPc + '%\'';
        }
        
            // only add a name clause if the user has entered some text
        if (!String.IsEmpty(searchProp.Colonia__c))
        {
            String wcColoniac='%' + searchProp.Colonia__c+ '%';
            whereStr+=' AND p.Colonia__c LIKE \'%' + wcColoniac+ '%\'';
        }
        
            // only add a name clause if the user has entered some text
        if (!String.IsEmpty(searchProp.Municipio__c))
        {
            String wcMunicipioc='%' + searchProp.Municipio__c+ '%';
            whereStr+=' AND p.Municipio__c  LIKE \'%' + wcMunicipioc+ '%\'';
        }
        
        
       // only add an industries clause if the user has selected one or more
        if   (null!=plazas) 
        {
          //  for (Integer idplazas=0; idplazas<plazas.size(); idplazas++)
          //  {
               // whereStr+=' AND p.Plaza__c LIKE \'%' + plazas[idplazas] + '%\'';
                              if   (plazas.size()<2) 
                              {
                               for (Integer idplazas=0; idplazas<plazas.size(); idplazas++)
                                  {
                                         whereStr+=' AND p.Plaza__c LIKE  \'%' + plazas[idplazas] + '%\'';
                                  }
                               }
                           if (plazas.size()>1)
                                {
                               for (Integer idplazas=0; idplazas<plazas.size(); idplazas++)
                                  {
                                              if (idplazas<1)
                                              {
                                                    whereStr+=' AND (p.Plaza__c LIKE  \'%' + plazas[idplazas] + '%\'';
                                               }
                                              if (idplazas>=1) 
                                               {
                                                whereStr+=' OR p.Plaza__c LIKE  \'%' + plazas[idplazas] + '%\'';
                                            //plazas.clear();
                                               }
                                   }
                                   whereStr += ')';
                               } 
                               
             //   if (idplazas>1)
             //   {
             //      for (Integer idplazas2=1; idplazas2<plazas.size(); idplazas2++)
             //      {   
             //          whereStr+=' OR p.Plaza__c LIKE  \'%' + plazas[idplazas2] + '%\')';
             //       }
             //   }
                
         //   }
            
            //plazas.clear();

        }
       
       // only add an industries clause if the user has selected one or more
        if   (null!=habitaciones)
        {
            
                            if   (habitaciones.size()<2) 
                              {
                               for (Integer idhab=0; idhab<habitaciones.size(); idhab++)
                                  {
                                         whereStr+=' AND p.N_de_Habitaciones__c LIKE  \'%' + habitaciones[idhab] + '%\'';
                                  }
                               }
                               
                           if (habitaciones.size()>1)
                              {
                               for (Integer idhab=0; idhab<habitaciones.size(); idhab++)
                                  {
                                              if (idhab<1)
                                              {
                                                    whereStr+=' AND (p.N_de_Habitaciones__c LIKE  \'%' + habitaciones[idhab] + '%\'';
                                               }
                                              if (idhab>=1) 
                                               {
                                                whereStr+=' OR p.N_de_Habitaciones__c LIKE  \'%' + habitaciones[idhab] + '%\'';
                                                
                                            //plazas.clear();
                                
                                               } 
                                
                                   }
                                   whereStr += ')';
                               } 
            
            // habitaciones.clear();
            
        }

       // only add an industries clause if the user has selected one or more
        if   (null!=banos)
              {
            // banos.clear();
            
            
                          if   (banos.size()<2) 
                              {
                               for (Integer idbanos=0; idbanos<banos.size(); idbanos++)
                                  {
                                         whereStr+=' AND p.N_de_Ba_os__c LIKE  \'%' + banos[idbanos] + '%\'';
                                  }
                               }
                               
                           if (banos.size()>1)
                              {
                               for (Integer idbanos=0; idbanos<banos.size(); idbanos++)
                                  {
                                              if (idbanos<1)
                                              {
                                                    whereStr+=' AND (p.N_de_Ba_os__c LIKE  \'%' + banos[idbanos] + '%\'';
                                               }
                                              if (idbanos>=1) 
                                               {
                                                whereStr+=' OR p.N_de_Ba_os__c LIKE  \'%' + banos[idbanos] + '%\'';
                                                
                                            //plazas.clear();
                                
                                               } 
                                
                                   }
                                   whereStr += ')';
                               } 
                               
                               

        }
        
       // only add an industries clause if the user has selected one or more
        if   (null!=tipoprop) 
        {

              //tipoprop.clear();
              
                         if   (tipoprop.size()<2) 
                              {
                               for (Integer idtipo=0; idtipo<tipoprop.size(); idtipo++)
                                  {
                                         whereStr+=' AND p.Tipo__c  LIKE  \'%' + tipoprop[idtipo] + '%\'';
                                  }
                               }
                               
                           if (tipoprop.size()>1)
                              {
                               for (Integer idtipo=0; idtipo<tipoprop.size(); idtipo++)
                                  {
                                              if (idtipo<1)
                                              {
                                                    whereStr+=' AND (p.Tipo__c LIKE  \'%' + tipoprop[idtipo] + '%\'';
                                               }
                                              if (idtipo>=1) 
                                               {
                                                whereStr+=' OR p.Tipo__c LIKE  \'%' + tipoprop[idtipo] + '%\'';
                                                
                                            //plazas.clear();
                                
                                               } 
                                   }
                                   whereStr += ')';
                               } 

        }
        
       // only add an industries clause if the user has selected one or more
        if  ( null!=nivprop )
        {
              //nivprop.clear();
              
                              if   (nivprop.size()<2) 
                              {
                               for (Integer idniv=0; idniv<nivprop.size(); idniv++)
                                  {
                                         whereStr+=' AND p.Niveles_Plantas__c  LIKE  \'%' + nivprop[idniv] + '%\'';
                                  }
                               }
                               
                           if (nivprop.size()>1)
                              {
                               for (Integer idniv=0; idniv<nivprop.size(); idniv++)
                                  {
                                              if (idniv<1)
                                              {
                                                    whereStr+=' AND (p.Niveles_Plantas__c LIKE  \'%' + nivprop[idniv] + '%\'';
                                               }
                                              if (idniv>=1) 
                                               {
                                                whereStr+=' OR p.Niveles_Plantas__c LIKE  \'%' + nivprop[idniv] + '%\'';
                                                
                                            //plazas.clear();
                                
                                               } 
                                   }
                                   whereStr += ')';
                               } 
                               
        }
      
     
        //------------------------search  activation ----------
        // only execute a search if the user entered some criteria
        if (''!=whereStr)
        {
            queryStr='SELECT Id, Name, Calle__c, Plaza__c, CP__c, Colonia__c,Municipio__c, N_de_Habitaciones__c, N_de_Ba_os__c, Tipo__c, Niveles_Plantas__c, NumeroExterior__c , NumeroInterior__c, Lote__c, Manzana__c , Estado__c, Terreno_m2__c, Construccion_m2__c, Estacionamiento__c, Descripcion_de_la_propiedad__c, Invadida__c, Escrituras__c, PrecioVenta__c FROM Propiedad__c p WHERE' + whereStr.substring(4)+ ' ORDER by Name ASC';
             //results=Database.query(queryStr);
             //-----------inicia codigo
             System.debug('query: ' + queryStr);
            for(Propiedad__c p : Database.query(queryStr)) {
            // create a new wrapper by passing it the category in the constructor
            PropiedadWrapper pw = new PropiedadWrapper (p);
            // add the wrapper to the results
            results.add(pw);
              }
        
       }
       if (''==whereStr)
       {
       queryStr='SELECT Id, Name, Calle__c, Plaza__c, CP__c, Colonia__c,Municipio__c, N_de_Habitaciones__c, N_de_Ba_os__c, Tipo__c, Niveles_Plantas__c, NumeroExterior__c , NumeroInterior__c, Lote__c, Manzana__c , Estado__c, Terreno_m2__c, Construccion_m2__c, Estacionamiento__c, Descripcion_de_la_propiedad__c, Invadida__c, Escrituras__c, PrecioVenta__c FROM Propiedad__c p ORDER by Name ASC';
             //results=Database.query(queryStr);
             //-----------inicia codigo
            for(Propiedad__c p : Database.query(queryStr)) {
            // create a new wrapper by passing it the category in the constructor
            PropiedadWrapper pw = new PropiedadWrapper (p);
            // add the wrapper to the results
            results.add(pw);
              }
       
       }
       
        if(results.isEmpty()==true)

                  {
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'NO SE ENCONTRARON RESULTADOS QUE COINCIDAN CON LOS FILTROS DE BÚSQUEDA INDICADOS.'));

                  }



if (''!=whereStr)
        {

     //Store the total size
        totalSize = results.size();
        
        //Intial adding of contacts to ContactsToShow
        //check the total records are more than limitSize and assign the records
        if((counter+limitSize) <= totalSize){
            for(Integer i=0;i<limitSize;i++){
                PropiedadesShow.add(results.get(i));
            }
        }else{
            for(Integer i=0;i<totalSize;i++){
                PropiedadesShow.add(results.get(i));
            }
        }
   }


if (''==whereStr)
        {

     //Store the total size
        totalSize = results.size();
        
        //Intial adding of contacts to ContactsToShow
        //check the total records are more than limitSize and assign the records
        if((counter+limitSize) <= totalSize){
            for(Integer i=0;i<limitSize;i++){
                PropiedadesShow.add(results.get(i));
            }
        }else{
            for(Integer i=0;i<totalSize;i++){
                PropiedadesShow.add(results.get(i));
            }
        }
   }
          whereStr= '';
          return null;
        
     }
     
     //----------inicia paginacion 
     
    
    //Navigation methods
    
    public void inicio(){
   
        PropiedadesShow.clear();
        counter=0;
        if((counter + limitSize) <= totalSize){
       
            for(Integer i=0;i<limitSize;i++){
                PropiedadesShow.add(results.get(i));
            }   
           
        } else{
       
            for(Integer i=0;i<totalSize;i++){
                PropiedadesShow.add(results.get(i));
            }       
           
        }
       
    }
   
    public void siguiente(){
   
        PropiedadesShow.clear();
        counter=counter+limitSize;
       
        if((counter+limitSize) <= totalSize){
            for(Integer i=counter-1;i<(counter+limitSize);i++){
                PropiedadesShow.add(results.get(i));
            }
        } else{
            for(Integer i=counter;i<totalSize;i++){
                PropiedadesShow.add(results.get(i));
            }
        }
    }
   
    public void anterior(){
   
        PropiedadesShow.clear();

        counter=counter-limitSize;       
       
        for(Integer i=counter;i<(counter+limitSize); i++){
            PropiedadesShow.add(results.get(i));
        }
    }

    public void ultimo (){
   
        PropiedadesShow.clear();
       
        if(math.mod(totalSize , limitSize) == 0){
            counter = limitSize * ((totalSize/limitSize)-1);
        } else if (math.mod(totalSize , limitSize) != 0){
            counter = limitSize * ((totalSize/limitSize));
        }
       
        for(Integer i=counter-1;i<totalSize-1;i++){
                PropiedadesShow.add(results.get(i));
        }
       
    }
   
    public Boolean getDisableNext(){
   
        if((counter + limitSize) >= totalSize )
            return true ;
        else
            return false ;
    }
   
    public Boolean getDisablePrevious(){
   
        if(counter == 0)
            return true ;
        else
            return false ;
    } 

//---------------termina paginacion
    
     //--------------inicia next  
        
        public PageReference next() {

        // clear out the currently selected categories
        selectedResults.clear();

        // add the selected categories to a new List
        for (PropiedadWrapper pw : results) {
            if (pw.checked)
                selectedResults.add(new PropiedadWrapper(pw.prop));
        }
        // ensure they selected at least one category or show an error message.
        if (selectedResults.size() > 0) {
            return Page.PDF_FichaTecnica;
        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Por favor selecciona como mínimo una propiedad'));

            return null;
        }       
    //---------termina next
    
        return null;
    }
    
    //------------------------------------------sendemail
    
 /* public ID accountId {get;set;}
  public String email {get;set;}

  public List<SelectOption> accounts {
    get {
      if (accounts == null) {
        accounts = new List<SelectOption>();
        accounts.add(new SelectOption('0017000000LgRMb','United Oil & Gas Corp.'));
        accounts.add(new SelectOption('0017000000LgRMV','Burlington Textiles Corp of America'));
      }
      return accounts;
    }
    set;
  }*/

public PageReference sendPdf(){
  // Reference the page, pass in a parameter to force PDF
  
        //----------------------
         // clear out the currently selected categories

            if (selectedResults== null) {selectedResults= new List<PropiedadWrapper>();}
            
            
        selectedResults.clear();
        resultsPDF.clear();
        
        // add the selected categories to a new List
        
         Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();

              
            if  (account.Email__c == null) {
                 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No es posible enviar la ficha técnica, ya que no existe email del Lead. Favor de Proporcionarlo'));
                return null;
             }
             
         else  if  (account.Email__c != null) {
             
            for (PropiedadWrapper pw3 : results ) {
            if (pw3.checked){
                selectedResults.add(new PropiedadWrapper(pw3.prop));
                resultsPDF.add(pw3.prop.id);
                //Id[] accountid = new Id[] {account.id};
                //Id accountid = account.id;
                Historial_de_Envios_de_Ficha_Tecnica__c historial = new Historial_de_Envios_de_Ficha_Tecnica__c (Nombre_de_la_cuenta__c = accountid );
                //historial.Nombre_de_la_Cuenta__c = accountid;
                historial.Fecha_de_Envio__c = datetime.now();
                historial.Folio_Propiedad__c = pw3.prop.id;
                //historial.Nombre_de_la_Cuenta__c = '0016300000IdZhe';
                historial.Plaza__c = pw3.prop.Plaza__c;
                system.debug(accountid);
                insert historial;
                //saveHistorial();
                pw2=pw3;
                
              }  
             
             }
             
               if  (selectedResults.size() <  6 && selectedResults.size()>0)  {   
                     return Page.PropiedadesSearch_Results;
             
                } 
          
      
             else if  (selectedResults.size() >  5) {
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Por favor selecciona máximo 5 propiedades'));
                  
                        return null;
                  }
                
             
           
           
            else if  (selectedResults.size() < 1 || selectedResults.size()==null) {
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Por favor selecciona por lo menos una propiedad'));
                        return null;
                  }
          
         }
          return null;
 
 }
 
 
 public pageReference sendpdffinal(){
          Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
                    PageReference pref = page.PDF_FichaTecnica;
                    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    
                   // pref.getParameters().put('id',pw.prop.id);
                   /* pref.getParameters().put('id',pw2.prop.id);
                    pref.setRedirect(true);*/
                    Blob b;
                    if(!Test.isRunningTest())
                      b = pref.getContent();
                    else{
                      b = Blob.valueOf('xxxxxx');
                    }
                    attach.setFileName('FichaTecnica.pdf');
                    semail.setFileAttachments(new Messaging.EmailFileAttachment[]{attach});
                    attach.setBody(b);
            
                    PageReference htmlPage = page.PDF_FichaTecnica_Email;
                    Blob body;
                    if(!Test.isRunningTest())
                      body = htmlPage.getContent();
                    else{
                      body = Blob.valueOf('xxxxxx');
                    }
                    String htmlBody = body.toString();
        
                    semail.setSubject('Revimex – Ficha Técnica de Propiedades');
                    String[] sendTo = new String[]{account.Email__c};
            
                    semail.setToAddresses(sendTo);
                    
                    semail.setHtmlBody(htmlBody);
                    //semail.setPlainTextBody('+Please find the attached book details+');
                    //semail.setFileAttachments(new Messaging.EmailFileAttachment[]{attach});
                     Messaging.sendEmail(new Messaging.SingleEmailMessage []{semail});
        
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'El envío de la Ficha Técnica fue realizado exitosamente'));
                     return null;
 }
 
      public PageReference back() {
        return Page.PropiedadesSearch;
    }  
 
public List<Attachment> getFoto() {

fotos = [SELECT Id,Name FROM Attachment WHERE ParentId = :selectedResults[0].prop.Id];
return fotos ;

 }


     //    }  poner
    //---------termina next
       
            
           
         //  } //quitar
         //   return null;
            
        //  }
        
     //}  
     
     //--------ver ficha técnica
        public Propiedad__c getProp() {
        return [SELECT Name, Id, Calle__c, Plaza__c, CP__c, Colonia__c,Municipio__c, N_de_Habitaciones__c, N_de_Ba_os__c, Tipo__c, Niveles_Plantas__c, NumeroExterior__c , NumeroInterior__c, Lote__c, Manzana__c , Estado__c, Terreno_m2__c, Construccion_m2__c, Estacionamiento__c, Descripcion_de_la_propiedad__c, Invadida__c, Escrituras__c, PrecioVenta__c FROM Propiedad__c
                WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
    }
   
     public PageReference saveHistorial() {
      insert historial;
       
      return null;
    }   
     
     //--------termina ver ficha técnica
    
     /*    // ensure they selected at least one category or show an error message.
        if (results.size() > 0) {
            return Page.PDF_FichaTecnica;
        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select at least one Property.'));
            return null;
        }    
    */ //return null;
  
    //--------------termina codigo
    
       // return null;
        
        
    //termina codigo-----------------------------------    
        
    }

/*eliminar ---------

     PageReference pdf =  Page.PDF_FichaTecnica;
     
        // add the selected categories to a new List
        for (PropiedadWrapper pw : results) {
            if (pw.checked)
                selectedResults.add(new PropiedadWrapper(pw.prop));
        }
        // ensure they selected at least one category or show an error message.
        if (selectedResults.size() > 0) {
         
             return Page.PDF_FichaTecnica;
   
          // pdf.getParameters().put('id',(String)account.id);
        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Please select at least one Property.'));
            return null;
        }   

     //pdf.getParameters().put('p','p');
     pdf.setRedirect(true);
     // Grab it!
     Blob b = pdf.getContent();
     // Create an email
     Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
      email.setSubject('From getDeliverAsPDF!');
     String [] toAddresses = new String[] {account.Email__c};
     email.setToAddresses(toAddresses);
     
     //---------insertar pdf data -------
        
     //-------------
     
     //email.setPlainTextBody(texto);
     // Create an email attachment
     Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
     efa.setFileName('MyPDF.pdf'); // neat - set name of PDF
     efa.setBody(b); //attach the PDF
     email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
     // send it, ignoring any errors (bad!)
     Messaging.SendEmailResult [] r =
             Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        return null;
    }
 
   /* 
    
public PageReference sendPdf(){
pagereference Pg = Page.PDF_FichaTecnica;
Blob pdf1 = pg.getcontentAsPdf();
Document d = new Document();
d.FolderId = UserInfo.getUserId();
d.Body = Pdf1;
d.Name = 'pdf_file.pdf';
d.ContentType = 'application/pdf';
d.Type = 'pdf';
insert d;
return null;
}

*/
/*
 public PageReference sendPdf() {

    PageReference pdf = Page.PdfGeneratorTemplate;
    // add parent id to the parameters for standardcontroller
    pdf.getParameters().put('id',accountId);

    // the contents of the attachment from the pdf
    Blob body;

    try {

      // returns the output of the page as a PDF
      body = pdf.getContent();

    // need to pass unit test -- current bug  
    } catch (VisualforceException e) {
      body = Blob.valueOf('Some Text');
    }
    
    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setContentType('application/pdf');
    attach.setFileName('testPdf.pdf');
    attach.setInline(false);
    attach.Body = body;

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setUseSignature(false);
   //  mail.setToAddresses(new String[] { email });
    mail.setToAddresses(new String[] { account.Email__c});
    mail.setSubject('PDF Email Demo');
    mail.setHtmlBody('Here is the email you requested! Check the attachment!');
    mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 

    // Send the email
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with PDF sent to '+account.Name));

    return null;

  }
  */
    
   // eliminar------------ */