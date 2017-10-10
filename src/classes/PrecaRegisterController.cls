public with sharing class PrecaRegisterController {
    
    public Preca_Web__c preca{get;set;}
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
    public String strPassword{get;set;} 
    public String strPasswordReapet{get;set;}
    public Propiedad__c propiedad {get;set;} 
   
    public PrecaRegisterController(ApexPages.StandardController stdController) {
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
            //preca.Fecha_Nacimiento__c = date.today().format();
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
    }
    
     
    public Pagereference upsertPreca(){
        Pagereference pageRef;
        
        List< Preca_Web__c > lstPreca = [SELECT Id FROM Preca_Web__c WHERE Nombre__c =:strNombre AND Apellido__c =: strApellido AND Fecha_Nacimiento__c =: fechaNacimiento.format() AND Registrado__c = true];
        List<Account> listAccount = [SELECT Id,Registrado__c FROM Account WHERE Email__c = :stremail];
        
        if(listAccount != null && listAccount.size() > 0 && listAccount[0].Registrado__c == true){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'El correo electronico que estas ingresando ya esta registrado, por favor comuniquese a los telefonos de Revimex');
            ApexPages.addMessage(myMsg);
            pageRef = null;
            return pageRef;
        } else if(lstPreca != null && lstPreca.size() > 0){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'El nombre y fecha de nacimiento se encuentran duplicados por favor comuniquese a los telefonos de Revimex');
            ApexPages.addMessage(myMsg);
            pageRef = null;
            return pageRef;
        } else if (listAccount != null && listAccount.size() > 0 && listAccount[0].Registrado__c == false) {
            Account acc = listAccount[0];
            acc.Name = strNombre.toUpperCase() + ' ' + strApellido.toUpperCase();
            acc.Plaza__c = strplaza;
            acc.Email__c = stremail;
            acc.Phone = strtelefono.toUpperCase();
            acc.Numero_de_Seguro_Social__c = strnss.toUpperCase();
            acc.Registrado__c = true;

            if(strPassword == strPasswordReapet ){
                acc.Password__c = strPassword;
                try{
                    List<Account> la = new List<Account>();
                    la.add(acc);             
                    Schema.SObjectField externalField = Account.Fields.Email__c;
                    
                    Database.Upsertresult[] upsertResult = Database.upsert(la,externalField,false);

                    Sorteo__c sorteo = [SELECT Id, Name FROM Sorteo__c WHERE Fecha_de_inicio__c <=: System.today() AND Fecha_de_fin__c >=: System.today() limit 1];
                    Boleto__c boleto = new Boleto__c();
                    boleto.Sorteo__c = sorteo.Id;
                    boleto.Cliente__c = acc.Id;
                    boleto.Estado__c = 'Activo';
                    insert boleto;
                
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


        preca.Nombre__c = strNombre.toUpperCase();
        preca.Apellido__c = strApellido.toUpperCase();
        preca.Fecha_Nacimiento__c = fechaNacimiento.format();
        preca.Fecha_de_nacimiento_sorteo__c = fechaNacimiento;
        preca.Calle__c = strcalle.toUpperCase();
        preca.No_Exterior__c = strexterior.toUpperCase();
        preca.No_Interior__c = strinterior.toUpperCase();
        preca.Colonia__c = strcolonia.toUpperCase();
        preca.Codigo_Postal__c = strcodigoPostal.toUpperCase();
        preca.Phone__c = strtelefono.toUpperCase();
        preca.Tel_fono_Casa__c = strtelefonoCasa.toUpperCase();
        preca.Email__c = stremail;
        preca.Estado__c = preca.Estado__c != null ? preca.Estado__c.toUpperCase() : preca.Estado__c ;
        preca.Plaza__c = propiedad.Plaza__c;
        //preca.Correo_electr_nico_WF__c = stremail;
        preca.Origen__c ='Revimex Web';
        preca.Registrado__c = true;
        
        preca.NSS__c = strnss.toUpperCase();
        
        if(strPassword == strPasswordReapet ){
            preca.Password__c = strPassword;
            try{
                List<Preca_Web__c> precalist = new List<Preca_Web__c>();
                precalist.add(preca);
                                
                Schema.SObjectField externalField = Preca_Web__c.Fields.Email__c;
                
                Database.Upsertresult[] upsertResult = Database.upsert(precalist,externalField,false);
                Sorteo__c sorteo = [SELECT Id, Name FROM Sorteo__c WHERE Fecha_de_inicio__c <=: System.today() AND Fecha_de_fin__c >=: System.today() limit 1];
                Boleto__c boleto = new Boleto__c();
                boleto.Sorteo__c = sorteo.Id;
                boleto.Preca_Web__c = preca.Id;
                boleto.Estado__c = 'Activo';
                insert boleto;
            
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


}