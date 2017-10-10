public class PrecaWebController 
{
    public String fname {get;set;}
    public String lname {get;set;}
    public String nss {get;set;}
    public String email {get;set;}
    public Decimal credito {get;set;}
    public String plaza {get;set;}
    public String bday {get;set;}

    public String ufname {get;set;}
    public String ulname {get;set;}
    public String unss {get;set;}
    public String uemail {get;set;}
    public Decimal ucredito {get;set;}
    public String uplaza {get;set;}
    public String ubday {get;set;}

    public String precaId {get;set;}
    public list <Preca_Web__c> precs {get;set;}  
    public string searchstring {get;set;}

    public PrecaWebController()
    {
         
    }

    public PageReference setId()
    {
        precaId = null;
        precaId = ApexPages.currentPage().getParameters().get('precaId');
        System.debug(precaId);
        if (ApexPages.currentPage().getParameters().get('precaId') != null) {
            Preca_Web__c preca = [SELECT Name,Id,Nombre__c,Apellido__c,NSS__c,Email__c,Credito__c,Plaza__c,Fecha_Nacimiento__c FROM Preca_Web__c  WHERE Id =:precaId];
            ufname   = preca.Nombre__c;
            ulname   = preca.Apellido__c;
            unss     = preca.NSS__c;
            uemail   = preca.Email__c;
            ucredito = preca.Credito__c;
            uplaza   = preca.Plaza__c;
            ubday    = preca.Fecha_Nacimiento__c;
        }
        return null;
    }

    public void search()
    {  
        String searchquery='SELECT name,id,Nombre__c,Apellido__c,NSS__c,Email__c,Credito__c,Plaza__c,Fecha_Nacimiento__c FROM Preca_Web__c WHERE NSS__c = \''+searchstring+'\' Limit 20';  
        precs = Database.query(searchquery);  
    }

    public void clear()
    {
        if (precs.size() > 0) {
            precs.clear();  
        }
    } 

    public PageReference createPreca()
    {
        try {
            System.debug('Nueva preca');
            Preca_Web__c preca = new Preca_Web__c();
            preca.Nombre__c = fname;
            preca.Apellido__c = lname;
            preca.NSS__c = nss;
            preca.Email__c = email;
            preca.Credito__c = credito;
            preca.Plaza__c = plaza;
            preca.Fecha_Nacimiento__c = bday;
            System.debug(preca);
            insert preca;
        } catch (Exception e) {

        }
        return null;
    }

    public PageReference updatePreca()
    {
        PageReference re = new PageReference('/');       
        re.setRedirect(false);

        if(precaId != null){
            Preca_Web__c preca = [SELECT Name,Id,Nombre__c,Apellido__c,NSS__c,Email__c,Credito__c,Plaza__c,Fecha_Nacimiento__c FROM Preca_Web__c  WHERE Id =:precaId];
            preca.Nombre__c = ufname;
            preca.Apellido__c = ulname;
            preca.NSS__c = unss;
            preca.Email__c = uemail;
            preca.Credito__c = ucredito;
            preca.Plaza__c = uplaza;
            preca.Fecha_Nacimiento__c = ubday;
            System.debug(preca);
            update preca;
            //return null;
        }
            
      
        return re;
    }

    public List<SelectOption> getPlazaOptions() {
        List<SelectOption> plazaOptions = new List<SelectOption>();
        plazaOptions.add(new SelectOption('','-None-'));
        plazaOptions.add(new SelectOption('Aguascalientes','Aguascalientes'));
        plazaOptions.add(new SelectOption('Bahia de Banderas','Bahia de Banderas'));
        plazaOptions.add(new SelectOption('Boca de Rio','Boca de Rio'));
        plazaOptions.add(new SelectOption('Campeche','Campeche'));
        plazaOptions.add(new SelectOption('Cancun','Cancun'));
        plazaOptions.add(new SelectOption('Celaya','Celaya'));
        plazaOptions.add(new SelectOption('Chiapas','Chiapas'));
        plazaOptions.add(new SelectOption('Chihuahua','Chihuahua'));
        plazaOptions.add(new SelectOption('Ciudad Acuna','Ciudad Acuna'));
        plazaOptions.add(new SelectOption('Ciudad Juarez','Ciudad Juarez'));
        plazaOptions.add(new SelectOption('Ciudad Madero','Ciudad Madero'));
        plazaOptions.add(new SelectOption('Coahuila','Coahuila'));
        plazaOptions.add(new SelectOption('Coatzacoalcos','Coatzacoalcos'));
        plazaOptions.add(new SelectOption('Colima','Colima'));
        plazaOptions.add(new SelectOption('Dif-Mex','Dif-Mex'));
        plazaOptions.add(new SelectOption('Durango','Durango'));
        plazaOptions.add(new SelectOption('Ecatepec','Ecatepec'));
        plazaOptions.add(new SelectOption('Ensenada','Ensenada'));
        plazaOptions.add(new SelectOption('Estado de Mexico','Estado de Mexico'));
        plazaOptions.add(new SelectOption('Guadalajara','Guadalajara'));
        plazaOptions.add(new SelectOption('Guerrero','Guerrero'));
        plazaOptions.add(new SelectOption('Hermosillo','Hermosillo'));
        plazaOptions.add(new SelectOption('Hidalgo','Hidalgo'));
        plazaOptions.add(new SelectOption('Huehuetoca','Huehuetoca'));
        plazaOptions.add(new SelectOption('Irapuato','Irapuato'));
        plazaOptions.add(new SelectOption('Ixtapaluca','Ixtapaluca'));
        plazaOptions.add(new SelectOption('Leon','Leon'));
        plazaOptions.add(new SelectOption('Los Cabos','Los Cabos'));
        plazaOptions.add(new SelectOption('Metepec','Metepec'));
        plazaOptions.add(new SelectOption('Mexicali','Mexicali'));
        plazaOptions.add(new SelectOption('Monterrey','Monterrey'));
        plazaOptions.add(new SelectOption('Morelia','Morelia'));
        plazaOptions.add(new SelectOption('Morelos','Morelos'));
        plazaOptions.add(new SelectOption('Nogales','Nogales'));
        plazaOptions.add(new SelectOption('Nuevo Laredo','Nuevo Laredo'));
        plazaOptions.add(new SelectOption('Orizaba','Orizaba'));
        plazaOptions.add(new SelectOption('Piedras Negras','Piedras Negras'));
        plazaOptions.add(new SelectOption('Puebla','Puebla'));
        plazaOptions.add(new SelectOption('Queretaro','Queretaro'));
        plazaOptions.add(new SelectOption('Sabinas','Sabinas'));
        plazaOptions.add(new SelectOption('San Juan del Rio','San Juan del Rio'));
        plazaOptions.add(new SelectOption('Sinaloa','Sinaloa'));
        plazaOptions.add(new SelectOption('Tecamac','Tecamac'));
        plazaOptions.add(new SelectOption('Tijuana','Tijuana'));
        plazaOptions.add(new SelectOption('Tlaxcala','Tlaxcala'));
        plazaOptions.add(new SelectOption('Toanala','Toanala'));
        plazaOptions.add(new SelectOption('Toluca','Toluca'));
        plazaOptions.add(new SelectOption('Torreon','Torreon'));
        plazaOptions.add(new SelectOption('Tultepec','Tultepec'));
        plazaOptions.add(new SelectOption('Tultitlan','Tultitlan'));
        plazaOptions.add(new SelectOption('Vallarta','Vallarta'));
        plazaOptions.add(new SelectOption('Veracruz','Veracruz'));
        plazaOptions.add(new SelectOption('Xalapa','Xalapa'));
        return plazaOptions;
    }
}