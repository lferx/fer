public with sharing class RecomendadorController {
    
    public Preca_Web__c preca{get;set;}
    public Preca_Web__c lstPrec{get;set;}
    public Account cuentaM{get;set;}
    public Date fechaNacimiento{get;set;}
    public String strNombre{get;set;}
    public String strApellido{get;set;}
    public String stremail{get;set;}
    public String strplaza{get;set;}
    public String strnss{get;set;}
    public String strcalle{get;set;}
    public String strcolonia{get;set;}
    public String strinterior{get;set;}
    public String strexterior{get;set;}
    public String strestado{get;set;}
    public String strcodigoPostal{get;set;}
    public String strtelefono{get;set;}
    public String strtelefonoCasa{get;set;}
    public String lada{get;set;}
    public String strPassword{get;set;} 
    public String strPasswordReapet{get;set;} 
    public String strBanco{get;set;} 
    public String strCuenta{get;set;} 
    public String strClabe{get;set;} 
    public String strpago{get;set;} 
    public Integer intmonto{get;set;}
    public String  correo2Usoregistro{get; set;}
    public Lead candidato{get;set;}
    public String nombre{get;set;}
    public String plaza{get;set;}
    public String correo{get;set;}
    public String labelRecomendador{get;set;}
    public String labelPromotor{get;set;}
    public String labelActivo{get;set;}
    public List<Account> lstAccount {get;set;}
    public List<Lead> lstLead {get;set;}
    public List<Preca_Web__c> lstPreca{get;set;}
    public Account cliente{get;set;}
    public Propiedad__c propiedad {get;set;}
    public List<List<Boleto__c>> lstBoletos{get;set;}
   
        
    
    
    public RecomendadorController(ApexPages.StandardController stdController) {
        this.preca = (Preca_Web__c)stdController.getRecord();
         propiedad = new Propiedad__c();
         
           if(!String.isEmpty(preca.Id)){
            preca = [SELECT 
                        Id,Name,Preca_Web__c.Estado__c,No_Interior__c,No_Exterior__c,Colonia__c,
                        Codigo_Postal__c,Calle__c,Address__c,Status__c,Phone__c,Tel_fono_Casa__c,Email__c,NSS__c,
                        Credito__c,Plaza__c,Fecha_Nacimiento__c,Apellido__c,Nombre__c,Fecha_de_nacimiento_sorteo__c
                        FROM Preca_Web__c WHERE Id =:preca.Id LIMIT 1];
            
            strNombre = preca.Nombre__c;
            strApellido = preca.Apellido__c;
            strcalle = preca.Calle__c;
            strexterior = preca.No_Exterior__c;
            strinterior = preca.No_Interior__c;
            strcolonia = preca.Colonia__c;
            strcodigoPostal = preca.Codigo_Postal__c;
            strestado = preca.Estado__c;
            strnss = preca.NSS__c;
            strtelefono = preca.Phone__c;
            strtelefonoCasa = preca.Tel_fono_Casa__c;
            stremail = preca.Email__c;
        }
        
         Boletos();

        
    }

    public void Boletos(){
    lstBoletos = new List<List<Boleto__c>>();
        
        List<Boleto__c> lstBoletosAux = [SELECT Id,Name FROM Boleto__c WHERE Preca_Web__r.Email__c =: strEmail OR Candidato__r.Email =: strEmail  OR Cliente__r.Email__c =:strEmail ORDER BY Name];
        
        
        List<Boleto__c> listTemp = new List<Boleto__c>();
        Integer indice = 0;
        for( Boleto__c boleto: lstBoletosAux ){
            indice = indice+1;
            listTemp.add( boleto );
            if(listTemp.size() == 5 || lstBoletosAux.size() == indice){
                lstBoletos.add( listTemp );
                listTemp = new List<Boleto__c>();
                  }
               } 
            }
   
     
    public Pagereference upsertPreca(){
        Pagereference pageRef;
        
        List< Preca_Web__c > lstPreca = [SELECT Id FROM Preca_Web__c WHERE Nombre__c =:strNombre AND Apellido__c =: strApellido AND Fecha_Nacimiento__c =: fechaNacimiento.format() ];
        List< Account > lstCuenta = [SELECT Id FROM Account WHERE Name=:(strNombre+' '+strApellido ) and Email__c=:stremail AND CLABE__c=:strClabe AND Tipo_promotor__c=:'Recomendador' ];
        ApexPages.Message myMsgs;
        this.logout();
        if(lstPreca != null && lstPreca.size() > 0){
            myMsgs = new ApexPages.Message(ApexPages.Severity.ERROR,'Los datos ingresados son Pertenecen a un usuario ya registrado por favor inicie session y conviertete en Recomendador');
            if(lstCuenta!=null && lstCuenta.size()>0){
            myMsgs = new ApexPages.Message(ApexPages.Severity.ERROR,'Los datos ingresaos Pertenecen a otro Recomendador por favor Verifica tus datos');
            }
            ApexPages.addMessage(myMsgs);
            pageRef = null;
            return pageRef;
        
        }
        
        
        cuentaM = new Account();
        labelRecomendador = 'Recomendador';
        labelPromotor = 'Promotor';
        labelActivo = 'Activo';
        preca.Nombre__c = strNombre.toUpperCase();
        preca.Apellido__c = strApellido.toUpperCase();
        preca.Fecha_Nacimiento__c = fechaNacimiento.format();
        preca.Fecha_de_nacimiento_sorteo__c = fechaNacimiento;
        preca.Calle__c = strcalle.toUpperCase();
        preca.No_Exterior__c = strexterior.toUpperCase();
        preca.No_Interior__c = strinterior.toUpperCase();
        preca.Colonia__c = strcolonia.toUpperCase();
        preca.Codigo_Postal__c = strcodigoPostal.toUpperCase();
        preca.Phone__c = lada.toUpperCase()+strtelefono.toUpperCase();
        preca.Email__c = stremail;
        preca.Estado__c = preca.Estado__c != null ? preca.Estado__c.toUpperCase() : preca.Estado__c;
        preca.Plaza__c = propiedad.Plaza__c;
        preca.Origen__c = labelRecomendador;
        preca.NSS__c = strnss.toUpperCase();
        cuentaM.Email__c = stremail;
        cuentaM.Usuario__c = stremail;
        cuentaM.Type = labelPromotor;
        cuentaM.Tipo_promotor__c = labelRecomendador;
        cuentaM.Estatus__c = labelActivo;
        cuentaM.Phone = strtelefono.toUpperCase();
        cuentaM.Name = strNombre+' '+strApellido;
        cuentaM.CLABE__c = strClabe;
        cuentaM.Banco__c = strBanco;
        cuentaM.Beneficiario__c = strNombre.toUpperCase();
        cuentaM.Numero_de_Seguro_Social__c = strnss.toUpperCase();
        cuentaM.Plaza__c = propiedad.Plaza__c;
        cuentaM.Cuenta_bancaria__c = strCuenta;
        
        

        
        if(strPassword == strPasswordReapet ){
            preca.Password__c = strPassword;
            cuentaM.Password__c = strPassword;
            try{
                List<Preca_Web__c> precalist = new List<Preca_Web__c>();
                precalist.add(preca);
                                
                Schema.SObjectField externalField = Preca_Web__c.Fields.Email__c;
                
                Database.Upsertresult[] upsertResult = Database.upsert(precalist,externalField,false);
                
               insert cuentaM;
            
                pageRef =  Page.SorteoLogin;
            }catch(Exception e){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
                ApexPages.addMessage(myMsg);
                pageRef = null;
            }
        }else{
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Las contraseñas ingresadas no coinciden');
            ApexPages.addMessage(myMsg);
            pageRef = null;
        }
        
        
        return pageRef;
        
    }
    public Pagereference ingresaCuentaRecomendador(){
         Pagereference pageRef;
        labelRecomendador = 'Recomendador';
        labelPromotor = 'Promotor';
        labelActivo = 'Activo';
        
         try{
        lstPrec = [SELECT Id,Email__c,Phone__c,Nombre__c,Plaza__c,Apellido__c FROM Preca_Web__c WHERE Email__c=:correo2Usoregistro LIMIT 1 ];
        cuentaM = new Account();
        cuentaM.Email__c=lstPrec.Email__c.toUpperCase();
        cuentaM.Usuario__c=lstPrec.Email__c.toUpperCase();
        cuentaM.Type=labelPromotor;
        cuentaM.Tipo_promotor__c=labelRecomendador;
        cuentaM.Estatus__c=labelActivo;
        cuentaM.Phone=lstPrec.Lada__c + lstPrec.Phone__c;
        cuentaM.Name=lstPrec.Nombre__c.toUpperCase()+' '+lstPrec.Apellido__c.toUpperCase();
        cuentaM.CLABE__c=strClabe.toUpperCase();
        cuentaM.Banco__c=strBanco.toUpperCase();
        cuentaM.Beneficiario__c=lstPrec.Nombre__c.toUpperCase()+' '+lstPrec.Apellido__c.toUpperCase();
        cuentaM.Numero_de_Seguro_Social__c=lstPrec.NSS__c.toUpperCase();
        cuentaM.Plaza__c=lstPrec.Plaza__c.toUpperCase();
        cuentaM.Cuenta_bancaria__c=strCuenta.toUpperCase(); 
         insert cuentaM;
        
         return  pageRef = page.Alta_Recomendado_Logeado;
          }catch(Exception e){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
                ApexPages.addMessage(myMsg);
                pageRef = null;
            }
        
           return pageRef;
        
        
    }
      public PageReference CheckIfLogged()
    {
       Cookie  logged = ApexPages.currentPage().getCookies().get('logged');
        if (logged == null) {
            PageReference pageRef = new PageReference('/SorteoLogin');
            pageRef.setRedirect(true);
            return pageRef;
        }
        return null;
    }
    public PageReference logout()
    { Cookie logged = new Cookie('logged','',null,0,false);
        ApexPages.currentPage().setCookies(new Cookie[]{logged});
        PageReference pageRef = new PageReference('/SorteoLogin');
        pageRef.setRedirect(true);
            return pageRef;}
}