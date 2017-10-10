@isTest(SeeAllData=true)
private class TEST_GeolocalizacionController  {
  
  @isTest static void test_method_one() {

    Account acc = new Account();
    acc.Name = 'test';
    acc.Usuario__c = 'test';
    acc.Password__c = '12345';

    insert acc;

    Propiedad__c propiedad  = new Propiedad__c();
    propiedad.Name = 'test';
    propiedad.Punto__Latitude__s = 19.3352378054;
    propiedad.Punto__Longitude__s = -99.1600018862;
    insert propiedad;


    Oferta__c oferta = new Oferta__c();
    oferta.Name = 'test';
    oferta.Propiedad__c = propiedad.Id;
    oferta.Fecha_Desbloqueo__c =  Datetime.now().addDays(15);
    oferta.Bloqueada__c = false;

    insert oferta;

    ClienteOferta__c cof  =new ClienteOferta__c();
    cof.Cuenta__c = acc.Id;
    cof.Oferta__c = oferta.Id;
    insert cof;

  

    GeolocalizacionController controlador = new GeolocalizacionController();

    PageReference apstmp =controlador.getOfertasPerAccount();
    PageReference uitmp = controlador.updateInteresado();
    PageReference aotmp = controlador.asignarOferta();
    PageReference ucctmp = controlador.updateContacted();



    PageReference pageRef = Page.Login;
       
       pageRef.getParameters().put('Cuenta',acc.Id);
       pageRef.getParameters().put('coi',cof.Id);
       pageRef.getParameters().put('ofertc',oferta.Id);
       pageRef.getParameters().put('accid',acc.Id);
       pageRef.getParameters().put('propiedadId',propiedad.Id);

       

       
    Test.setCurrentPage(pageRef);






    String u                      =controlador.user;
    String pass                   = controlador.pass;

    

    controlador.user = acc.Usuario__c;
    controlador.pass = acc.Password__c;

    Decimal lat                   = controlador.lat;
    Decimal lng                   = controlador.lng;
    Decimal lat2                  = controlador.plat;
    Decimal lng2                  = controlador.plng;
    
    String s                      = controlador.searchstring;
    Propiedad__c pp               = controlador.propiedad;
    List<Account> la              = controlador.accs;
    List<Oferta__c> ofer            = controlador.oferts;
    String accid                  = controlador.accid;
    Boolean ccc                   = controlador.contacted;
    
    String ofertc                 = controlador.ofertc;
    String comments               = controlador.comments;
    


    controlador.comments = 'comentario prubea';
    

    String coi                    = controlador.coi;
    controlador.coi = cof.id;
    PageReference addComments = controlador.addComments();

    

    List<ClienteOferta__c> lo     = controlador.getLista_cuentas_ofertas();
    controlador.setLista_cuentas_ofertas (lo);

    List<GeolocalizacionController.CuentaWrapper> lcuanetas = controlador.lista_cuentas;
    List<ClienteOferta__c> lista_cuentas_ofertas = controlador.lista_cuentas_ofertas;

 
    PageReference aps=controlador.getOfertasPerAccount();
    PageReference ui = controlador.updateInteresado();
    PageReference ao = controlador.asignarOferta();
    PageReference ucc = controlador.updateContacted();
    
    
   

    controlador.searchstring = propiedad.Name;

    controlador.search();
    controlador.clear();
    PageReference sif = controlador.setId();
    PageReference upps  = controlador.updatePropiedad();

    GeolocalizacionController.CuentaWrapper cw = new GeolocalizacionController.CuentaWrapper();
    Account cc = cw.cuenta_wrapper;
    List<GeolocalizacionController.OfertaWrapper> low = cw.ofertas;

    GeolocalizacionController.OfertaWrapper ow  = new GeolocalizacionController.OfertaWrapper();
    ClienteOferta__c co =  ow.oferta;
   
  }
}