public with sharing class RecomendadorBaseController {

    public Date fechaNacimiento{get;set;}
    public String strNombre{get;set;}
    public String strApellido{get;set;}
    public String stremail{get;set;}
    public String strplaza{get;set;}
    public String strnss{get;set;}  
    public String strtelefono{get;set;}
    public String lada{get;set;}
    public Propiedad__c propiedad {get;set;}  
    public String strpago{get;set;} 
    public Double intmonto{get;set;}
    public String  correo2Usoregistro{get; set;}
    public Lead candidato{get;set;}
    public String nombre{get;set;}
    public String plaza{get;set;}
    public String correo{get;set;}
    public String id{get;set;}
    public List<account> Recomendados{get;set;}
    public String recomendador{get;set;}
    public List<Account> lstAccount {get;set;}
    public List<Lead> lstLead {get;set;}
    public List<Preca_Web__c>lstPreca{get;set;}
    public List<Boleto__c> listTemp{get;set;}
    public List<Boleto__c> lstBoletosAux{get;set;}
    public List<List<Boleto__c>> lstBoletos{get;set;}
    public List<Lead> Candidatos{get;set;}
  
    public List<Oferta__c> RecomendadosOferta1{get;set;}
    public List<Oferta__c> RecomendadosOferta2{get;set;}

    
        public RecomendadorBaseController() {
        this.CheckIfLogged();
        strEmail = Apexpages.currentPage().getParameters().get('email');
        
          
       Datos();
       boletos();
       getAccounts(); 
       getOfertas();
       getLead();
            } 
    
    public RecomendadorBaseController(ApexPages.StandardController stdController) {
        this.CheckIfLogged();       
        strEmail = Apexpages.currentPage().getParameters().get('email');
       Datos();
       boletos();
       getAccounts(); 
       getOfertas();
       getLead();
            } 
            
    public void Datos()
    {
   try{
        lstAccount = [SELECT Id,Name,Email__c,Numero_de_Seguro_Social__c,Plaza__c FROM Account WHERE  Email__c =:strEmail and Type =:'Recomendador'  ];
        
            nombre = lstAccount[0].Name;
            plaza = lstAccount[0].Plaza__c;
            correo = lstAccount[0].Email__c;
            id=lstAccount[0].Id;       
          }catch(exception x)
        {
                
        }        
    }     
            
            
    public void boletos()
    {

     if(lstBoletos==null&&lstBoletosAux==null&&listTemp==null){
        lstBoletos = new List<List<Boleto__c>>();
     lstBoletosAux = [SELECT Id,Name FROM Boleto__c WHERE Preca_Web__r.Email__c =: strEmail OR Candidato__r.Email =: strEmail  OR Cliente__r.Email__c =:strEmail ORDER BY Name];
     listTemp = new List<Boleto__c>();
        }
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

  
    public PageReference IngresaRecomendado()
    {
                try{
                        candidato = new Lead();
                candidato.LastName= strApellido.toUpperCase();
                candidato.Company='REVIMEX';
                candidato.Email=stremail; 
                candidato.Credito__c=intmonto; 
                candidato.Status='Abrir'; 
                candidato.NSS__c= strnss;
                candidato.DoNotCall= false;
                candidato.FirstName= strNombre.toUpperCase();
                candidato.Plaza__c= strplaza;
                candidato.Promotor__c= id;
                candidato.Usuario_Captura__c= nombre;
                candidato.Phone= strtelefono;          
                        insert candidato;
                        }catch(exception x)
                                {
                                   return null;     
                                }  
                return null;
        }
  
    
    
    public PageReference logout()
    { Cookie logged = new Cookie('logged','',null,0,false);
        ApexPages.currentPage().setCookies(new Cookie[]{logged});
        PageReference pageRef = new PageReference('/SorteoLogin');
        pageRef.setRedirect(true);
            return pageRef;}
            
        public PageReference CheckIfLogged()
        {
            Cookie logged = ApexPages.currentPage().getCookies().get('logged');
                if (logged == null) {
                    PageReference pageRef = new PageReference('/SorteoLogin');
                    pageRef.setRedirect(true);
                        return pageRef;
                }
                        return null; 
        }
//<!--Llena los Recomendados y los busca en la tabla de Leads-->
        public List<Lead> getLead() {
            Lead error = new Lead();
           try{
              Candidatos = [select Id, Promotor__c, Plaza__c, Email, Name from Lead where  Promotor__c=: id];
           }catch(exception x){
                 PageReference pageRef = new PageReference('');
                 pageRef.setRedirect(true);    
                 error.Email='Sin@Recomendadores.Registrados';
                 error.Plaza__c='Sin Plaza asignada';
                 Candidatos.add(error);
                    return Candidatos ;
       }
        return Candidatos;
    }
//    <!--Llena los Recomendados y los busca en la tabla de cuentas-->
    public List<account> getAccounts() {
            account error = new account();
       try{
              Recomendados = [select Id, Promotor__c, Phone, Plaza__c, Email__c, Name from account where  Promotor__c=: id];
       
       }catch(exception x){
             PageReference pageRef = new PageReference('');
             pageRef.setRedirect(true);
            
             error.Email__c='Sin@Recomendadores.Registrados';
             error.Plaza__c='Sin Plaza asignada';
             Recomendados.add(error);
                return Recomendados ;
       }
        return Recomendados;
    }
//     <!--Llena los Recomendados y los busca en la tabla de ofertas-->
     public List<Oferta__c> getOfertas() {
            Oferta__c Oferta = new Oferta__c();
       try{
              
              for(Integer i=0; i<Recomendados.size(); i++)
                  {
              RecomendadosOferta1.add( [select Id, NombreCliente__c, Etapa__c,Estatus__c from Oferta__c where  ClienteFinal__c=: (Recomendados[i].id) and (Etapa__c=:'Compilación expediente cliente' or  Etapa__c=:'Cierre oferta')]);
                  }
       }catch(exception x){
             PageReference pageRef = new PageReference('');
             pageRef.setRedirect(true);
            
            
                return RecomendadosOferta1 ;
       }
        return RecomendadosOferta1;
    }
}