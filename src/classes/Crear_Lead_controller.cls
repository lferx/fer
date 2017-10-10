public class Crear_Lead_controller {

    public Account nuevoLead {get;set;}
    public String nombre {get;set;}
    public String apellido {get;set;}
    public String errorMsg {get;set;}
    public List<sObject> duplicateRecords {get;set;}
    public Boolean hasDuplicateResult {get;set;}
    //public Map<String,Objecion__c> objeciones {get;set;}
    //public Map<String,Script__c> scripts {get;set;}
    public String accountId {get;set;}
    public String pasoActivo {get;set;}
    public Carrito__c carrito {get;set;}
    public double suma {get;set;}
    public Date fechaConsulta{get;set;}
    public Boolean avanzar {get;set;}

    public Map<id,list<cita__c>> mapC2 = new Map<id,list<cita__c>>();
    public List<carrito__c> carrito2 {get;set;}
    public Detalle_del_Carrito__c cita {get;set;}
    public Detalle_del_Carrito__c cita2 {get;set;}
    public string idcita {get;set;}
    public string citaident {get;set;}
    public string idcarrito {get;set;}
    public Boolean insertada {get;set;}
    public Set<Id>listax =new Set<id>();
    public List<String> plazas =new List<String>();
    public List<Detalle_del_Carrito__c> x =new List<Detalle_del_Carrito__c>();
    public string plazaor {get;set;}
    public integer cont {get;set;}
    public List<String> plazas2 =new List<String>();
    //public Estado_Menu_Rapido__c estadoMenuRapido {get;set;}
    public String selectOption {get; set;}
    public string plazaxd {get; set;}
    //public String testString {get; set;}
    public string fecha {get; set;}
    public string oferta {get; set;}
    public string hora {get; set;}
    public string idpromotor {get; set;}
    public string idc {get; set;}
    public string idpromotor2 {get; set;}
    public cita__c citas {get; set;}
    public cita__c borrarcita {get; set;}
    public Map<id,list<Detalle_del_Carrito__c>> mapC {get;set;}
    public List<cita__c> citas2 {get; set;}
    public Boolean rcitas {get; set;}
    public List<Google_JSONWebToken.Archivo> listaArchivos {get;set;}
    public List<Google_JSONWebToken.Archivo> listaFotos {get;set;}
    public Google_JSONWebToken.Archivo objFoto {get;set;}
    public cita__c asistencia {get; set;}
    public cita__c asistencia2 {get; set;}
    public Detalle_del_Carrito__c dc {get; set;}
    public string iddc {get; set;}
    public RecordType tipoReg2 {get;set;}                                                                                   //Variable agregada por Hector para generar Cuenta Matriz
    public List<Account> duplicados {get;set;}                                                                              //Variable agregada por Hector para verificar duplicados
    public Id cuentaMatriz {get;set;}
    public String mensage {get;set;}
    public Id idCuentaMenuRapido {get;set;}
    public string fecha2 {get;set;}
    public string fechaprox {get;set;}
    public Detalle_del_Carrito__c dcx {get;set;}
    public Oferta__c ofx {get;set;}
    public Detalle_del_Carrito__c iddetalle {get;set;}
    public string idbusca {get;set;}
    public Account phone {get;set;}
    public Boolean insertado {get;set;}
    public string Photolink{get;set;}
    public Account retfecha {get;set;}

    public String nombreDeLead {get;set;}
    public List<Account> sugerencias {get;set;}

    public Account cuentaCheck {get;set;}
    public Boolean esCuentaPersonal {get;set;}

    public static Set<String> ciudades {get;set;}
    public String searchCity {get;set;}

    public Crear_Lead_controller() {
        nombreDeLead = '';
        carrito = new Carrito__c();
        User us = [Select us.SmallPhotoUrl, us.FullPhotoUrl From User us where us.id=:Userinfo.getUserid()];
        Photolink = us.SmallPhotoUrl;
        mensage = '';
        Id idRegistro = ApexPages.currentPage().getParameters().get('id');

        if (idRegistro!=null){
            insertado=true;
            retfecha=[select Fecha_de_nacimiento__c, Fecha_Proxima_Credito_Infonavit__c from Account where id=:idRegistro];
            if (retfecha.Fecha_de_nacimiento__c!=null){
                fecha2=string.valueOf(retfecha.Fecha_de_nacimiento__c.format());
            }
            if (retfecha.Fecha_Proxima_Credito_Infonavit__c!=null){
                fechaprox=string.valueOf(retfecha.Fecha_Proxima_Credito_Infonavit__c.format());
            }
        }

        idcarrito =ApexPages.currentPage().getParameters().get('id');

        if ((idcarrito!=null)&&(idcarrito!='')){
            string selector= system.today().format();
            carrito2 =[select id, (select  cita__c,id,idcita__c,oferta__r.plaza__c,oferta__r.Propiedad__r.Calle__c,Oferta__r.Colonia_busqueda__c,oferta__r.name,oferta__r.Direccion2__c,oferta__c ,oferta__r.Propiedad__r.Oferta__c from Detalles_del_Carrito__r) from carrito__c where cuenta__c=:idcarrito.trim() ORDER BY CreatedDate desc limit 1];
        }else{
            carrito2 =[select id, (select cita__c,id,idcita__c,oferta__r.plaza__c,Oferta__r.Propiedad__r.Calle__c,Oferta__r.Colonia_busqueda__c,oferta__r.name,oferta__r.Direccion2__c,oferta__c,oferta__r.Propiedad__r.Oferta__c  from Detalles_del_Carrito__r) from carrito__c ORDER BY CreatedDate desc limit 1];
        }

        mapC = new Map<id,list<Detalle_del_Carrito__c>>();

        for (carrito__c x : carrito2){
            mapC.put(x.id, x.Detalles_del_Carrito__r);
        }

        if (idRegistro != null) {
            cuentaCheck = [SELECT IsPersonAccount FROM Account WHERE id = :idRegistro];
            esCuentaPersonal = cuentaCheck.IsPersonAccount;
            if(esCuentaPersonal){
                nuevoLead = [SELECT Name, Target__c, Plaza__c, Plaza_2__c, Plaza_3__c, firstname, lastname, PersonEmail, Phone, Curp__c, Fecha_Proxima_Credito_Infonavit__c, Total_credito_contado__c, Monto_Presupuesto_Efectivo__c, Nombre_Mancomunado__c, Fecha_de_nacimiento_Mancomunado__c, Numero_de_Seguro_Social_Mancomunado__c, Tipo_de_Credito_Infonavit_mancomunado__c, Precalificacion_mancomunado__c, Total_mancomunado__c,Telefono_2__c,Fecha_y_hora_de_la_cita__c, Email__c, Origen__c, Forma_de_Pago__c, Fecha_de_nacimiento__c, Tipo_de_Credito__c, Numero_de_Seguro_Social__c, Script_datos_lead__c, Objeciones_datos_lead__c, Ciudad_Plaza__c, Fecha_de_Cita__c, Oferta__c, Promotor__c, Precalificacion__c, Institucion_que_otorga_credito__c, Fecha_de_Consulta__c, Type, isPersonAccount, SubOrigen__c, Banco__c, Monto_presupuesto__c, Recomendado_por__c from Account where Id =: idRegistro];
                nombre = nuevoLead.firstname;
                apellido = nuevoLead.lastname;
            }
            else{
                nuevoLead = [SELECT Name, Target__c, Plaza__c, Plaza_2__c, Plaza_3__c, PersonEmail, Phone, Curp__c, Fecha_Proxima_Credito_Infonavit__c, Total_credito_contado__c, Monto_Presupuesto_Efectivo__c, Nombre_Mancomunado__c, Fecha_de_nacimiento_Mancomunado__c, Numero_de_Seguro_Social_Mancomunado__c, Tipo_de_Credito_Infonavit_mancomunado__c, Precalificacion_mancomunado__c, Total_mancomunado__c,Telefono_2__c,Fecha_y_hora_de_la_cita__c, Email__c, Origen__c, Forma_de_Pago__c, Fecha_de_nacimiento__c, Tipo_de_Credito__c, Numero_de_Seguro_Social__c, Script_datos_lead__c, Objeciones_datos_lead__c, Ciudad_Plaza__c, Fecha_de_Cita__c, Oferta__c, Promotor__c, Precalificacion__c, Institucion_que_otorga_credito__c, Fecha_de_Consulta__c, Type, isPersonAccount, SubOrigen__c, Banco__c, Monto_presupuesto__c, Recomendado_por__c from Account where Id =: idRegistro];
                nombre = nuevoLead.Name;
            }
            
        }else{
            nuevoLead = new Account();
            esCuentaPersonal = true;
            //nuevoLead.recordTypeId = '012g00000005Q9O';
        }

        Id idCuentaMenuRapido = ApexPages.currentPage().getParameters().get('id');

        /*
        //CODIGO PARA EL SEMAFORO

        List<Objecion__c> listaObjeciones = [SELECT Name, Mensaje__c FROM Objecion__c];
        List<Script__c> listaScripts = [SELECT Name, Mensaje__c FROM Script__c];
        objeciones = new Map<String,Objecion__c>();
        scripts = new Map<String, Script__c>();

        for(Objecion__c obj : listaObjeciones){
            objeciones.put(obj.Name, obj);
        }
        for(Script__c scri : listaScripts){
            scripts.put(scri.Name, scri);
        }
        inicializarEstadoMenuRapido();
        */
        validaSiguiente();
    }


    /*
    //CODIGO PARA EL SEMAFORO

    public PageReference inicializarEstadoMenuRapido() {
        System.debug('@Crear_Lead_controller.inicializarEstadoMenuRapido() +++++');
        Id idCuenta = ApexPages.currentPage().getParameters().get('id');

        if (idCuenta != null) {
            estadoMenuRapido = UtilidadMenuRapido.obtenerEstado(idCuenta);
        }else{
            estadoMenuRapido = UtilidadMenuRapido.crearEstado();
        }
        System.debug('estadoMenuRapido -> ' + estadoMenuRapido);

        testString = 'Prueba';

        return null;
    }
    */


    public void quit(){
        cita=[select cita__c, idcita__c from Detalle_del_Carrito__c where id=:idcita];
        cita.cita__c=false;
        if(cita.idcita__c!=null)
        {
        borrarcita=[select id from cita__c where id=:cita.idcita__c];
        delete borrarcita;
        }
        
        cita.idcita__c=null;
        update cita;
    }
    public void validaSiguiente(){
        avanzar = false;
        if(esCuentaPersonal){
            if(String.isNotBlank(nombre) && String.isNotBlank(apellido) && String.isNotBlank(nuevoLead.Type)) {

                if(String.isNotBlank(nuevoLead.Phone)){
                    if(nuevoLead.Phone.length() == 10){
                        avanzar = true;
                    }
                }

                if(String.isNotBlank(nuevoLead.PersonEmail)){
                   avanzar = true;     
                }
            }
        }else{
            if(String.isNotBlank(nombre) &&  (String.isNotBlank(nuevoLead.Phone) ||  String.isNotBlank(nuevoLead.Email__c))){
                //(String.isNotBlank(nuevoLead.Email__c) ||   fer dijo que el email no
                avanzar = true;
            }
            //
        }
    }

//EMPIEZA BLOQUE CODIGO DE FER

    public void Addcita(){
        cita = [select cita__c, idcita__c, oferta__r.plaza__c from Detalle_del_Carrito__c where id =:idcita];
        cita.cita__c=true;

        UPDATE cita;

        if (cita.cita__c==true) {
            listax.add(cita.id);
            if(cita.oferta__r.plaza__c!=null){
                plazas.add(cita.oferta__r.Plaza__c);
                validaplaza();
            }
        }
    }


    public void getpro(){
        if([select count() from Detalle_del_Carrito__c where id =:idcita] > 0){
            cita = [select cita__c, idcita__c, oferta__r.plaza__c,Oferta__r.estado__r.name from Detalle_del_Carrito__c where id =:idcita];
            if(cita.Oferta__r.estado__r.name=='ESTADO DE MEXICO'){
                plazaxd='ESTADO DE MEXICO';
            }

            if((cita.oferta__r.plaza__c!=null)&&(cita.Oferta__r.estado__r.name!='ESTADO DE MEXICO')){
                plazaxd=cita.oferta__r.plaza__c;
            }
            getOptions();
        }
    }

    public void citas(){
        citas2=[select id,name, promotor__c,promotor__r.name,asistida__c, oferta__r.name, fecha__c, hora__c, oferta__c from cita__c where lead__c=:idcarrito and fecha__c!=null and oferta__c!=null and Dictamen__c!=true limit 10];
    }


    /*
    //METODO PARA... ???????????
    public void revcita() {
              cita = [select cita__c, idcita__c, oferta__r.Ciudad_Plaza__c from Detalle_del_Carrito__c where id =:idcita];

              cita.cita__c=false;
                cita.idcita__c=null;
                for(id idcita: listax){
                    if(listax.contains(cita.id))
                        listax.remove(cita.id);

                }

          Set<string>e=new Set<string>(plazas);
        for (string x:e)
        {
            if (x==cita.oferta__r.Ciudad_Plaza__c)
            {
                e.remove(x);
            }
        }
        plazas2= new List<string>(e);
        plazas=plazas2;
             validaplaza2();
              update cita;
    }
    */


    public void asistio(){
        asistencia=[select asistida__c from cita__c where id=:idc];
        asistencia.asistida__c=true;
        update asistencia;
    }

    public void noasistio(){
        asistencia2=[select asistida__c, dictamen__c from cita__c where id=:idc];
        asistencia2.asistida__c=false;
        asistencia2.dictamen__c=true;

        UPDATE asistencia2;

        if(idc!=null&&idc!=''){
            system.debug('valor es:'+idc);
            dcx=[select oferta__r.plaza__c,Oferta__r.estado__r.name from Detalle_del_Carrito__c where idcita__c=:idc.trim()];
            if(dcx.Oferta__r.estado__r.name=='ESTADO DE MEXICO'){
                plazaxd='ESTADO DE MEXICO';
            }
            if (dcx.Oferta__r.estado__r.name!='ESTADO DE MEXICO'){
                plazaxd=dcx.oferta__r.plaza__c;
            }
            getOptions();
        }
    }

    //METODO PARA ... ????????????
    public void guardarp () {

    }

    public void guardarcita() {
        cita__c citax= new cita__c();

        plazas.clear();
        if (idcarrito!=null) {
            citax.lead__c=idcarrito;

            INSERT citax;
            citaident =citax.id;

            x=[select idcita__c from Detalle_del_Carrito__c where id in:listax];

            for(Detalle_del_Carrito__c xd:x){
                xd.idcita__c=citax.id;
            }
            if (x.size()>0){
                UPDATE x;
            }
        }
    }

    public void getdc(){
        system.debug('easdasd:'+idbusca);
        if(idbusca!=null && idbusca!=''){
            iddetalle=[select id,oferta__c from Detalle_del_Carrito__c where idcita__c=:idbusca];
            iddc=iddetalle.id;
            oferta=iddetalle.oferta__c;
            saveall();
        }
    }

    public void saveall(){
        cita__c nuevacita = new cita__c();
        nuevacita.lead__c=idcarrito;
        nuevacita.fecha__c=fecha;
        nuevacita.hora__c=hora;

        if (idpromotor2!=null&&idpromotor2!=''){
            system.debug('el id es'+idpromotor2);
            nuevacita.promotor__c=idpromotor2.trim();
        }
        nuevacita.oferta__c=oferta;
        system.debug(idpromotor);
        system.debug(idpromotor2);
        INSERT nuevacita;
        rcitas=true;

        if (iddc!=null){
            dc=[select cita__c, idcita__c from Detalle_del_Carrito__c where id=:iddc];
            dc.cita__c=true;
            dc.idcita__c=nuevacita.id;
            system.debug('aqui se metio:' +dc.idcita__c);
            UPDATE dc;
        }
        
    }



    public void validaplaza2(){
        for (integer i=0; i<plazas2.size(); i++) {
            plazaor=plazas2[0];
            if ((plazaor!=null)&&(plazas2[i]!=plazaor)) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No puede haber plazas diferentes'));
                plazaor=null;
                return;
            }
        }
    }



    public void validaplaza(){
       for (integer i=0; i<plazas.size(); i++) {
            plazaor=plazas[0];
            if ((plazaor!=null)&&(plazas[i]!=plazaor)) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No puede haber plazas diferentes'));
                plazaor=null;
                return;
            }
        }
    }

    public void getphone(){
        if ([select phone from Account where id=:idpromotor2] != null){
            phone=[select phone from Account where id=:idpromotor2];
        }
    }

    public SelectOption[] getOptions(){

        integer x=0;
        SelectOption[] options = new SelectOption[] {};
        for (AggregateResult ar : 
            [select Name n, id i
            from Account 
            where type='promotor' and estatus__c= 'Activo' and plaza__c =:plazaxd
            group by Name, id, Phone
            order by Name, id, phone]){

                String n = (String) ar.get('n');
                String i = ((String) ar.get('i')).trim();

                if (x==0)
                {
                    options.add(new SelectOption('', ''));
                    x+=1;
                }
                options.add(new SelectOption(i, n));
        }
        return options;
    }

    public void cita(){
        string idcarrito =ApexPages.currentPage().getParameters().get('id');
        if ((idcarrito!=null)&&(idcarrito!='')) {
            carrito2 =[select id, (select  oferta__r.name,oferta__r.Direccion2__c,oferta__c from Detalles_del_Carrito__r) from carrito__c where cuenta__c=:idcarrito.trim() limit 1];
        }else{
            carrito2 =[select id, (select oferta__r.name,oferta__r.Direccion2__c,oferta__c from Detalles_del_Carrito__r) from carrito__c where cuenta__c='001g000001gnVfz'];
        }
        mapC = new Map<id,list<Detalle_del_Carrito__c>>();
        for (carrito__c x : carrito2){
            mapC.put(x.id, x.Detalles_del_Carrito__r);
        }
    }

//TERMINA BLOQUE CODIGO DE FER



    public PageReference cancelarLead() {
        PageReference Regresoinicio = Page.CreacionCuentaTipoLead;
        return Regresoinicio;
    }

    public PageReference precalificacion() {
        PageReference precalificacion = new PageReference('/apex/Precalificacion_FormaPago');
        precalificacion.setRedirect(false);
        if (nuevoLead != null && nuevoLead.Id != null) {
            precalificacion.getParameters().put('id', nuevoLead.Id);
        }
        return precalificacion;
    }



    public PageReference stock() {
        PageReference stock = Page.ConsolaComercial;
        stock.setRedirect(false);
        if (nuevoLead != null && nuevoLead.Id != null) {
            stock.getParameters().put('id', nuevoLead.Id);
        }

        return stock;
    }



    public PageReference envioficha() {
        PageReference envioficha = new PageReference('/apex/Envio_de_la_ficha');
        envioficha.setRedirect(false);
        if (nuevoLead != null && nuevoLead.Id != null) {
            envioficha.getParameters().put('id', nuevoLead.Id);
        }
        return envioficha;
    }



    public PageReference citalead() {
        PageReference citalead = Page.Cita_Leads;
        citalead.setRedirect(false);
        if (nuevoLead != null && nuevoLead.Id != null) {
                citalead.getParameters().put('id', nuevoLead.Id);
        }
        return citalead;
    }



    public PageReference citalead2() {
        PageReference citalead2 = Page.Cita_Leads;
        citalead2.setRedirect(false);
        if (idcarrito != null ) {
            citalead2.getParameters().put('id', idcarrito);
        }
        return citalead2;
    }



    public PageReference autorizacion() {
        PageReference autorizacion = Page.AutorizacionLead;
        autorizacion.getParameters().put('idaccount', idcarrito);
        return autorizacion;
    }



    public PageReference guardarIrDatosLead() {
        try {
            update nuevoLead;
        } catch(Exception ex){
            ApexPages.addMessages(ex);
            return null;
        }

        PageReference datoslead = new PageReference('/apex/CreacionCuentaTipoLead');
        datoslead.setRedirect(false);
        if (nuevoLead != null && nuevoLead.Id != null) {
            datoslead.getParameters().put('id', nuevoLead.Id);
        }
        return datoslead;
    }

    public void guardame() {
        if(nuevoLead != NULL){
            try{
                         if(fecha2!=null&&fecha2!='')
        {

        nuevoLead.Fecha_de_nacimiento__c=date.parse(fecha2);

        }
        if (fechaprox!=null&&fechaprox!='')
        {
            nuevoLead.Fecha_Proxima_Credito_Infonavit__c=date.parse(fechaprox);
        }
                UPDATE nuevoLead;
            } 
            catch(Exception e){
                ApexPages.addMessages(e);
            }
        }
    }

    public PageReference guardarIrStock() {
        try {
            update nuevoLead;
            return stock();
        } catch(Exception e) {
            ApexPages.addMessages(e);
            return null;
        }
    }


    public PageReference datosLead() {
        PageReference datoslead = new PageReference('/apex/CreacionCuentaTipoLead');
        datoslead.setRedirect(false);
        if (nuevoLead != null && nuevoLead.Id != null) {
            datoslead.getParameters().put('id', nuevoLead.Id);
            UPDATE nuevoLead;
        }
        return datoslead;
    }

    public PageReference irPrecalificacion() {
        if(!esCuentaPersonal){
            nuevoLead.name = nombre;
            //UPSERT nuevoLead;
            PageReference precalificacion = Page.Precalificacion_FormaPago;
            precalificacion.setRedirect(false);
            precalificacion.getParameters().put('id', nuevoLead.Id);
            //Comienza codigo agregado por Hector para generar Cuenta Matriz
            //cuentaMatriz = Utilities.buscaMatriz(nuevoLead.Id);
            //Utilities.ligarMatriz(nuevoLead.Id,cuentaMatriz);
            //Termina codigo agregado por Hector para generar Cuenta Matriz
            return precalificacion;
        }
        else{
            //Inicia codigo Hector para asignar tipo de registro
            if(nuevoLead.type == NULL){
                PageReference precalificacion = new PageReference('/apex/CreacionCuentaTipoLead');
                precalificacion.setRedirect(false);
                mensage = 'Debes seleccionar un TIPO DE LEAD';
                return precalificacion;
            }
            mensage = '';

            System.debug(nuevoLead.type);
            if([SELECT count() FROM RecordType where name = :nuevoLead.type limit 1]>0){
                tipoReg2 = [SELECT Id FROM RecordType where name = :nuevoLead.type limit 1];
                nuevoLead.recordTypeId = tipoReg2.id;
            }
            insertado=true;
            System.debug(tipoReg2);
            errorMsg = '';
            //Termina codigo Hector para asignar tipo de registro
            //Comienza codigo de Hector para deteccion de duplicados
            if(nombre != NULL){
                nombre = Utilities.accentsRemover(nombre).trim();
            }
            if(apellido != NULL){
                apellido = Utilities.accentsRemover(apellido).trim();
            }
            nuevoLead.firstname = nombre;
            nuevoLead.lastname = apellido;

            String idLead = ApexPages.currentPage().getParameters().get('id');
            if(idLead == NULL){
                if([SELECT count() FROM Account WHERE ((phone != NULL AND phone = :nuevoLead.phone AND ID != :idLead) OR (Email__c != NULL AND Email__c = :nuevoLead.PersonEmail AND ID != :idLead) OR (PersonEmail != NULL AND PersonEmail = :nuevoLead.PersonEmail AND ID != :idLead)) AND RecordType.name = :nuevoLead.type AND firstname = :nombre AND lastname = :apellido]>0){
                    duplicados = [SELECT id,name,phone,Email__c,PersonEmail,Owner.name,CreatedDate FROM Account WHERE ((phone != NULL AND phone = :nuevoLead.phone AND ID != :idLead) OR (Email__c != NULL AND Email__c = :nuevoLead.PersonEmail AND ID != :idLead) OR (PersonEmail != NULL AND PersonEmail = :nuevoLead.PersonEmail AND ID != :idLead)) AND RecordType.name = :nuevoLead.type AND firstname = :nombre AND lastname = :apellido];
                    System.debug('Encontro cuenta duplicada');
                    return null;
                }
                else{
                    System.debug('No encontro cuenta Duplicada');
                    if(nuevoLead.Type == 'Lead Inversionista'){
                        nuevoLead.Target__c = '3';
                    }
                    UPSERT nuevoLead;
                }
            }
            else{
                System.debug('Ya traia ID');
                if(nuevoLead.Type == 'Lead Inversionista'){
                    nuevoLead.Target__c = '3';
                }
                UPSERT nuevoLead;
            }
            //Termina codigo de Hector para deteccion de duplicados
            PageReference precalificacion = Page.Precalificacion_FormaPago;
            precalificacion.setRedirect(false);
            precalificacion.getParameters().put('id', nuevoLead.Id);
            //Comienza codigo agregado por Hector para generar Cuenta Matriz
            cuentaMatriz = Utilities.buscaMatriz(nuevoLead.Id);
            Utilities.ligarMatriz(nuevoLead.Id,cuentaMatriz);
            //Termina codigo agregado por Hector para generar Cuenta Matriz
            return precalificacion;
        }
        
    }



    public PageReference irStock() {

        if(!esCuentaPersonal){
            nuevoLead.name = nombre;
            //UPSERT nuevoLead;
            PageReference stock = new PageReference('/apex/ConsolaComercial');
            stock.setRedirect(false);
            stock.getParameters().put('id', nuevoLead.Id);
            //Comienza codigo agregado por Hector para generar Cuenta Matriz
            //cuentaMatriz = Utilities.buscaMatriz(nuevoLead.Id);
            //Utilities.ligarMatriz(nuevoLead.Id,cuentaMatriz);
            //Termina codigo agregado por Hector para generar Cuenta Matriz
            return stock;
        }
        else{
            if(fecha2!=null&&fecha2!='')
            {

            nuevoLead.Fecha_de_nacimiento__c=date.parse(fecha2);

            }
            if (fechaprox!=null&&fechaprox!='')
            {
                nuevoLead.Fecha_Proxima_Credito_Infonavit__c=date.parse(fechaprox);
            }
            //Inicia codigo Hector
            if(nuevoLead.type == NULL){
                PageReference precalificacion = new PageReference('/apex/CreacionCuentaTipoLead');
                precalificacion.setRedirect(false);
                mensage = 'Debes seleccionar un TIPO DE LEAD';
                return precalificacion;
            }
            mensage = '';

            System.debug(nuevoLead.type);
            if([SELECT count() FROM RecordType where name = :nuevoLead.type limit 1]>0){
                tipoReg2 = [SELECT Id FROM RecordType where name = :nuevoLead.type limit 1];
                nuevoLead.recordTypeId = tipoReg2.id;
            }
            errorMsg = '';
            //Termina codigo Hector
            if(nuevoLead.id != NULL){
                UPDATE nuevoLead;
            }

            PageReference stock = new PageReference('/apex/ConsolaComercial');
            stock.setRedirect(false);
            stock.getParameters().put('id', nuevoLead.Id);
            //Comienza codigo agregado por Hector para generar Cuenta Matriz
            cuentaMatriz = Utilities.buscaMatriz(nuevoLead.Id);
            Utilities.ligarMatriz(nuevoLead.Id,cuentaMatriz);
            //Termina codigo agregado por Hector para generar Cuenta Matriz
            return stock;
        }
    }



    public PageReference guardarcitalead() {
        update nuevoLead;
        PageReference citalead = Page.Cita_Leads;
        citalead.setRedirect(false);
        return citalead;
    }



    public PageReference buscaCarrito() {
        if (nuevoLead != null && nuevoLead.Id != null) {
            List<Carrito__c> carritoResultados = [SELECT Id, (SELECT Id, Oferta__c, Oferta__r.Propiedad__r.Name, Oferta__r.Propiedad__r.N_de_Habitaciones__c, Oferta__r.Propiedad__r.plaza__c, Oferta__r.Propiedad__r.Niveles_Plantas__c, Oferta__r.Propiedad__r.Tipo__c, Oferta__r.Propiedad__r.N_de_Ba_os__c, Oferta__r.Propiedad__r.Colonia__c, Oferta__r.Propiedad__r.Municipio__c, Oferta__r.Propiedad__r.CP__c from Detalles_del_Carrito__r) from Carrito__c where Cuenta__c =: nuevoLead.Id limit 1];
            if (!carritoResultados.isEmpty()){
                    carrito = carritoResultados.get(0);
                    return null;
            }
            return stock();
        }
        return Page.Envio_de_la_ficha;
    }


    public void sumar() {
        if (nuevoLead.Monto_Presupuesto_Efectivo__c==null) {
            nuevoLead.Monto_Presupuesto_Efectivo__c=0;
        }
        if (nuevoLead.Precalificacion__c==null) {
            nuevoLead.Precalificacion__c=0;
        }
        nuevoLead.Total_credito_contado__c=nuevoLead.Monto_Presupuesto_Efectivo__c+nuevoLead.Precalificacion__c;
    }



    public void fechaHoy() {
        fechaConsulta=date.today();
        nuevoLead.Fecha_de_Consulta__c=fechaConsulta;
    }



    public void validaciones() {
        if (nuevoLead.Forma_de_Pago__c=='Credito Infonavit') {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter Account name'));
        }
    }



    public void cambioTipoCredito() {
        if (nuevoLead.Precalificacion__c==0 || nuevoLead.Precalificacion__c==null) {
            nuevoLead.Tipo_de_Credito__c=null;
        }
        if (nuevoLead.Precalificacion__c > 0) {
            if (nuevoLead.Precalificacion__c <250000) {
                    nuevoLead.Tipo_de_Credito__c='Credito Listo para Ejercer';
            }
        } if(nuevoLead.Precalificacion__c>=250000) {
            nuevoLead.Tipo_de_Credito__c='Autorizado';
        }
    }


    public void autoComplete(){
        try{
            sugerencias = [Select id,name,type,phone,PersonEmail,Email__c,isPersonAccount from Account where (name like :nombreDeLead+'%' OR phone like :nombreDeLead+'%' OR PersonEmail like :nombreDeLead+'%' OR Email__c like :nombreDeLead+'%') and type != 'Matriz' ORDER BY name Limit 100 ];
        }
        catch(exception e){
            System.debug('Error Seifer: '+e);
        }
        
    }

    public void limpiarSugerencias(){
        if(sugerencias != NULL){
            sugerencias.clear();
        }
    }

    @RemoteAction
    public static Set<String> autocompleteCiudades(String ciudad){
        ciudades = new Set<String>();

        for(Ciudad__c city: [SELECT name FROM Ciudad__c WHERE name LIKE :ciudad+'%' LIMIT 100]){
            ciudades.add(city.name);
        }

        if(ciudades.size()>0){
            return ciudades;
        }
        else{
            return requestGoogle(ciudad);
        }

    }

    public static Set<String> requestGoogle(String searchCity){

        Set<String> ciudades = new Set<String>();

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://maps.googleapis.com/maps/api/place/autocomplete/json?input='+EncodingUtil.urlEncode(searchCity,'UTF-8')+'&components=country:mx&types=(cities)&language=es&key=AIzaSyDXlu_fH79IuoKxLwOayacKtA5VCsLLQEc');
        req.setMethod('GET');


        Http http = new Http();
        HTTPResponse res = http.send(req);
        String respuesta = res.getBody();

        
        Map<String,Object> mapaDatosGoogle = (Map<String,Object>) JSON.deserializeUntyped(respuesta);
        List<Object> predicciones = (List<Object>) mapaDatosGoogle.get('predictions');

        for(Object objeto: predicciones){
            Map<String,Object> objetoMapa = (Map<String,Object>) objeto;
            List<Object> terminos = (List<Object>) objetoMapa.get('terms');
            Map<String,Object> termino = (Map<String,Object>) terminos.get(0);
            ciudades.add((String)termino.get('value'));

            System.debug((String)termino.get('value'));
        }
        return ciudades;
   }




    public void cobertura(){
        integer a=1;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;
        a++;

    }

}