public with sharing class FormularioCuestionarioController {
        
        public Account Lead{get;set;}
        public Date fechaNacimiento{get;set;}
        public String strNombre{get;set;}
        public String strApellidoPaterno{get;set;}
        public String strApellidoMaterno{get;set;}
        public String stremail{get;set;}
        public String strplaza{get;set;}
        public String strtelefono{get;set;}
        public String strnss{get;set;}
        public String strorigen{get;set;}
        public String strtelefonoCasa{get;set;}
        public Propiedad__c propiedad {get;set;} 
        
    public FormularioCuestionarioController(ApexPages.StandardController stdController){
         this.Lead = (Account)stdController.getRecord();
        propiedad = new Propiedad__c();
    }
    
      public Pagereference InsertarLead(){
      Pagereference pageRef;
        //List<Account> listAccount = [SELECT Id,Registrado__c FROM Account WHERE Email__c = :stremail LIMIT 1];
        if(strNombre!=null &&strApellidoPaterno!=null&&strtelefono!=null){
        Lead = new Account();
        Lead.Plaza__c=strplaza;
        Lead.Name= strNombre+' '+strApellidoPaterno+' '+strApellidoMaterno;
        Lead.Fecha_de_nacimiento__c=fechaNacimiento;
        Lead.Phone=strtelefono;
        Lead.TelefonosAdicionales__c=strtelefonoCasa;
        Lead.Origen__c='Web Home';
        Lead.Numero_de_Seguro_Social__c=strnss;
        Lead.Email__c=stremail;
        Lead.Type ='Lead';
        try{
        insert Lead;
        }
        catch(Exception e){
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
                    ApexPages.addMessage(myMsg);
                    pageRef = null;
        }
        pageRef =Page.PageControllerCuestionarioweb;
        
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'En breve un Colaborador se estará comunicando con usted Gracias');
        strNombre='';
        strApellidoPaterno='';
        stremail='';
        strplaza='';
        strtelefono='';
        
        }else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Los Campos nos permiten contactarte Por favor llena la mayoria');

        pageRef=null;
        }
            return  pageRef;
      }
    
    
}