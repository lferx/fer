public class CheckInController 
{
    public String user{get;set;}
    public String pass{get;set;}
    public Decimal lat {get;set;}
    public Decimal lng {get;set;}
    public Decimal plat {get;set;}
    public Decimal plng {get;set;}
    public String searchstring {get;set;}
    public Propiedad__c propiedad {get;set;}
    public List<Account> accs {get;set;}
    public List<Oferta__c> oferts {get;set;}
    public Boolean contacted {get;set;}
    public String accid {get;set;}
    public String coi {get;set;}
    public String ofertc {get;set;}
    public String comments {get;set;}
    public List<CuentaWrapper> lista_cuentas{get;set;} // lista de cuentas wrapper
    public List<ClienteOferta__c> lista_cuentas_ofertas; // lista de cuentas wrapper

    public CheckInController() 
    {
       
    }

    public List<ClienteOferta__c> getLista_cuentas_ofertas()
    {
        return this.lista_cuentas_ofertas;
    }

    public void setLista_cuentas_ofertas(List<ClienteOferta__c> l)
    {
        this.lista_cuentas_ofertas = l;
    }

    public Account promotor {
        get{
            Cookie logged = ApexPages.currentPage().getCookies().get('logged');
            if (logged != null) {
                promotor = [SELECT Id,Name FROM Account WHERE Id = :logged.getValue()];
            }
            return promotor;
        }
        set;
    }

    public PageReference getPromotorAccounts()
    {
        System.debug('@@@ LOGGED: '+ApexPages.currentPage().getCookies().get('logged'));
        Cookie logged = ApexPages.currentPage().getCookies().get('logged');
        if (logged == null) {
            PageReference pageRef = new PageReference('/');
            pageRef.setRedirect(true);
            return pageRef;
        }
        if (logged != null) {
            lista_cuentas = new  List<CuentaWrapper>();

            //loop sobre la cuenta para obtener las ofertas
            for(Account cuenta: [SELECT Id,Name,Contactado__c, (SELECT Id, Oferta__r.Propiedad__r.Name FROM Clientes_ofertas__r) FROM Account WHERE Promotor__c = :logged.getValue()]){

                CuentaWrapper cuenta_wrapper_instance = new CuentaWrapper();//instancia del wrapper

                cuenta_wrapper_instance.cuenta_wrapper= cuenta; //asignar la cuenta

                List<OfertaWrapper> list_oferta_temp = new List<OfertaWrapper>(); // lista temporal

                if(cuenta.Clientes_ofertas__r.size()>0){ // validamos que existan ofertas

                    for(ClienteOferta__c ofe:cuenta.Clientes_ofertas__r){

                        OfertaWrapper ofertas = new OfertaWrapper(); // instancia de oferta wrapper
                        ofertas.oferta = ofe;
                        list_oferta_temp.add(ofertas); // agregamos las ofertas en temporal
                    }
                }

                cuenta_wrapper_instance.ofertas = list_oferta_temp; // asigno las ofertas a nivel de cuenta wrapper

                lista_cuentas.add(cuenta_wrapper_instance); //agrego cuenta y ofertas en la lista
            }
            System.debug('## lista cuentas: ' + lista_cuentas);
        }
        return null;
    }

    public PageReference getOfertasPerAccount()
    {
        System.debug('@@@ LOGGED: '+ApexPages.currentPage().getCookies().get('logged'));
        Cookie logged = ApexPages.currentPage().getCookies().get('logged');
        if (logged == null) {
            PageReference pageRef = new PageReference('/');
            pageRef.setRedirect(true);
            return pageRef;
        }
        String cuentaId = null;
        cuentaId = ApexPages.currentPage().getParameters().get('Cuenta');
        if (cuentaId != null) {
            try {
                lista_cuentas_ofertas = [SELECT Id, Name, Interesado__c, Propiedad__c,Nombre_Oferta__c,Comentarios__c, Oferta__c FROM ClienteOferta__c WHERE Cuenta__c = :cuentaId];
                List<String> ids = new List<String>();
                List<String> plazas = new List<String>();
                Account accounttmp = [SELECT Id, Name, Plaza__c FROM Account WHERE Id = :cuentaId];
                plazas.add(accounttmp.Plaza__c);
                for(ClienteOferta__c co:lista_cuentas_ofertas) {
                    ids.add(co.Oferta__c);
                    Oferta__c o = [SELECT Id, Plaza__c FROM Oferta__c WHERE Id = :co.Oferta__c];
                    plazas.add(o.Plaza__c);
                }
                Map<String, Configuracion_Etapa_Lead__c> mapConfig = Configuracion_Etapa_Lead__c.getAll();
                Set<String> setEtapas = new Set<String>();
                for(Configuracion_Etapa_Lead__c configEtapa : mapConfig.values()) {
                    setEtapas.add(configEtapa.Name);
                }
                oferts = [SELECT Id, Name,Plaza__c,ValorReferencia__c,(SELECT Id, Name FROM Propiedades__r) FROM Oferta__c WHERE Id NOT IN :ids AND Plaza__c IN :plazas AND ValorReferencia__c != null AND Etapa__c IN :setEtapas LIMIT 70];
                System.debug('## Ofertas: ' + oferts);
            } catch(Exception e) {
                System.debug('## Error getting ofertas: '+e);
            }
        }
        return null;
    }

    public PageReference addComments()
    {
        coi = ApexPages.currentPage().getParameters().get('Oferta');
        String cuentaId = null;
        System.debug('## Comments: '+comments);
        System.debug('@@ Coi: '+coi);
        if (coi != null && comments != null) {
            try {
                ClienteOferta__c a = [SELECT Id,Cuenta__c, Name, Interesado__c, Propiedad__c, Oferta__c,Comentarios__c FROM ClienteOferta__c WHERE Id = :coi];
                cuentaId = a.Cuenta__c;
                a.Comentarios__c = comments;
                update a;
                PageReference pageRef = new PageReference('/CheckIn/OfertasCuenta?Cuenta='+cuentaId);
                return pageRef;
            } catch(Exception e) {
                System.debug('## Error updating: '+e);
            }
        }
        return null;
    }

    public PageReference updateInteresado()
    {
        coi = ApexPages.currentPage().getParameters().get('coi');
        System.debug('## coi: ' + coi);

        String cuentaId = null;
        cuentaId = ApexPages.currentPage().getParameters().get('Cuenta');
        PageReference pageRef = new PageReference('/CheckIn/OfertasCuenta?Cuenta='+cuentaId);
        pageRef.setRedirect(true);
        if (coi != null) {
            try {
                ClienteOferta__c a = [SELECT Id, Name, Interesado__c, Propiedad__c, Oferta__c FROM ClienteOferta__c WHERE Id = :coi];
                a.Interesado__c = true;
                update a;
            } catch(Exception e) {
                System.debug('## Error updating: '+e);
            }
        }
        return pageRef;
    }

    public PageReference asignarOferta()
    {
        ofertc = ApexPages.currentPage().getParameters().get('ofertc');
        System.debug('## ofertc: ' + ofertc);

        String cuentaId = null;
        cuentaId = ApexPages.currentPage().getParameters().get('Cuenta');
        PageReference pageRef = new PageReference('/CheckIn/OfertasCuenta?Cuenta='+cuentaId);
        pageRef.setRedirect(true);
        if (ofertc != null && cuentaId != null) {
            try {
                ClienteOferta__c co = new ClienteOferta__c();
                co.Cuenta__c = cuentaId;
                co.Oferta__c = ofertc;
                insert co;
                System.debug('## CO: '+co);
            } catch(Exception e) {
                System.debug('## Error insert: '+e);
            }
        }
        return pageRef;
    }

    public PageReference updateContacted()
    {
        accid = ApexPages.currentPage().getParameters().get('accid');
        System.debug('## accid: ' + accid);
        if (accid != null) {
            try {
                Account a = [SELECT Id, Contactado__c, Name FROM Account WHERE Id = :accid];

                System.debug('## A: ' + a);
                a.Contactado__c = true;
                update a;
            } catch(Exception e) {
                System.debug('## Error updating: '+e);
            }
        }

        PageReference re = new PageReference('/CheckIn/PromotorLeads');
        re.setRedirect(true);
        return re;
    }


    public PageReference login()
    {
        if (user != '' && pass != '') {
            try {
                Account promotor = [SELECT Id,Usuario__c, Password__c FROM Account WHERE Usuario__c = :user AND Password__c = :pass AND Estatus__c = 'Activo'];
                Cookie logged = new Cookie('logged',String.valueOf(promotor.Id),null,-1,false);
                ApexPages.currentPage().setCookies(new Cookie[]{logged});
                PageReference pageRef = new PageReference('/CheckInSearch');
                pageRef.setRedirect(true);
                return pageRef;
            } catch(Exception e){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Usuario y/o Contraseña incorrectos.'));
            }
        }
        return null;
    }

    public PageReference logout()
    {
        Cookie logged = new Cookie('logged','',null,0,false);
        ApexPages.currentPage().setCookies(new Cookie[]{logged});
        PageReference pageRef = new PageReference('/');
        pageRef.setRedirect(true);
        return pageRef;
    }

    public PageReference CheckIfLogged()
    {
        Cookie logged = ApexPages.currentPage().getCookies().get('logged');
        if (logged == null) {
            PageReference pageRef = new PageReference('/');
            pageRef.setRedirect(true);
            return pageRef;
        }
        return null;
    }

    public void search()
    {  
        try {
            String searchquery='SELECT Id,Name,Punto__Latitude__s, Punto__Longitude__s FROM Propiedad__c WHERE Name = \''+searchstring+'\' Limit 1';  
            propiedad = Database.query(searchquery);  
        } catch (Exception e) {
            propiedad = null;
        }
    }

    public void clear()
    {
        if (propiedad != null) {
            propiedad = null;  
        }
    }

    public PageReference setId()
    {
        Cookie logged = ApexPages.currentPage().getCookies().get('logged');
        if (logged == null) {
            PageReference pageRef = new PageReference('/');
            pageRef.setRedirect(true);
            return pageRef;
        }
        String propiedadId = null;
        propiedadId = ApexPages.currentPage().getParameters().get('propiedadId');
        if (propiedadId != null) {
            Propiedad__c prop = [SELECT Id,Name,Punto__Latitude__s, Punto__Longitude__s FROM Propiedad__c WHERE Id =:propiedadId];
            propiedad = prop;
            if (prop.Punto__Latitude__s != NULL && prop.Punto__Longitude__s != NULL) {
                plat   = prop.Punto__Latitude__s;
                plng   = prop.Punto__Longitude__s;
                lat   = prop.Punto__Latitude__s;
                lng   = prop.Punto__Longitude__s;
            } else {
                //Zocalo del DF
                plat = 19.432632;
                plng = -99.133298;
                lat = 19.432632;
                lng = -99.133298;
            }
        }
        return null;
    }

    public PageReference updatePropiedad()
    {
        String propiedadId = null;
        propiedadId = ApexPages.currentPage().getParameters().get('propiedadId');
        PageReference pageRef = new PageReference('/CheckIn/UpdatePunto?propiedadId='+propiedadId);
        pageRef.setRedirect(true);
        if (propiedadId != null) {
            Propiedad__c prop = [SELECT Id,Name,Punto__Latitude__s, Punto__Longitude__s FROM Propiedad__c WHERE Id =:propiedadId];
            prop.Punto__Latitude__s   = lat;
            prop.Punto__Longitude__s  = lng;
            update prop;
            plat   = prop.Punto__Latitude__s;
            plng   = prop.Punto__Longitude__s;
        }
        return pageRef;
    }

    public class CuentaWrapper
    {
        public Account cuenta_wrapper{get;set;}
        public List<OfertaWrapper> ofertas{get;set;}
    }

    public class OfertaWrapper
    { 
        public ClienteOferta__c oferta{get;set;}
    }

    @RemoteAction
    public static String deleteCookie(){
        Cookie counter = ApexPages.currentPage().getCookies().get('logged');

        counter = null;



        return '';

    }
}