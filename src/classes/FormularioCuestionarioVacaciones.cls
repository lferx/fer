public with sharing class FormularioCuestionarioVacaciones {
        
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
        public String Descripcion{get;set;}  
        
    public FormularioCuestionarioVacaciones(ApexPages.StandardController stdController){
        this.Lead = (Account)stdController.getRecord();
        propiedad = new Propiedad__c();
    }
    
      public Pagereference InsertarLead(){
      Pagereference pageRef;
        //List<Account> listAccount = [SELECT Id,Registrado__c FROM Account WHERE Email__c = :stremail LIMIT 1];
        if(strNombre!=null &&strtelefono!=null){
        Lead = new Account();
        Lead.Plaza__c=strplaza;
        Lead.Name= strNombre+' '+strApellidoPaterno+' '+strApellidoMaterno;
        Lead.Fecha_de_nacimiento__c=fechaNacimiento;
        Lead.Phone=strtelefono;
        Lead.TelefonosAdicionales__c=strtelefonoCasa;
        Lead.Origen__c='GoogleVacaciones1';
        Lead.Numero_de_Seguro_Social__c=strnss;
        Lead.Email__c=stremail;
        Lead.Type ='Lead';
        Lead.RecordTypeId = '01231000001NXgjAAG';
        Lead.Description= Descripcion; 
        try{
        insert Lead;
        }
        catch(Exception e){
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
                    ApexPages.addMessage(myMsg);
                    pageRef = null;
        }
        pageRef = Page.gracias_vacaciones;
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'En breve un Colaborador se estara comunicando con usted Gracias');
        }else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Los Campos nos permiten encontrarte Por favor llena la mayoria');

        pageRef=null;
        }
            return  pageRef;
      }
    
    
}