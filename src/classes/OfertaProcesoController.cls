global with sharing class OfertaProcesoController {
    public list<Etapa__c> etapas{get;set;}
    public Map<String, List<EtapaOferta__c>> mapEtapasCompra{get;set;}
    public Map<String, List<EtapaOferta__c>> mapEtapasVenta{get;set;}
    public List<EtapaOferta__c> etapasOferta{get;set;}
    public List<EtapaOferta__c> etapasOfertaCompra{get;set;}
    public List<EtapaOferta__c> etapasOfertaVenta{get;set;}
    public List<ClienteOferta__c> clientesOferta {get;set;}
    public List<PromotorOferta__c> promotoresOferta {get;set;}
    
    public transient ApexPages.Component componenteGeneral{get;set;}
    public String idEtapaOferta {get;set;}
    public string idOferta {get;set;}
    public boolean bBloqueada {get;set;}
    public String idGanador{get;set;}
    public String mensaje{get;set;}
    public String nombreEtapa {get;set;}
    public ApexPages.StandardController stdctl { get; set; }
    public String Beneficiario{get; set;}
    public String NSS{get; set;}
    public String RFC{get; set;}
    public String Tel{get; set;}
    public String NombreBanco{get; set;}
    public String Cuenta{get; set;}
    public String TipodePersona{get; set;}
    public String CLABE{get; set;}
    
    public String idItem{get;set;}
    public String nombreExpediente{get;set;}
    public Oferta__c oferta {get;set;}
    public Boolean muestraBoton {get;set;}
    public Integer iDocRed {get;set;}
    public OfertaProcesoController(ApexPages.StandardController controller){
        stdctl = controller;
        clienteOfertaEdit = new ClienteOferta__c();
        idOferta = controller.getId();
        cargarMapa();
        clientesOferta = [SELECT id, Contacto__c,Contacto__r.Name, Estatus2__c, Cuenta__c, Cuenta__r.Name,PromotorOferta__r.Cuenta__r.Name  FROM ClienteOferta__c WHERE Oferta__c =: idOferta ];
        promotoresOferta = [SELECT id, Contacto__c,Contacto__r.Name, Cuenta__c, Cuenta__r.Name,Cuenta__r.RecordType.Name FROM PromotorOferta__c WHERE Oferta__c =: idOferta ];
        oferta = [SELECT Id, Name,ClienteFinal__c,Promotor__c, Bloqueada__c, Fecha_Desbloqueo__c, Etapa__c, Estatus__c FROM oferta__c WHERE Id =: idOferta];
        iDocRed = 0;
        iDocRed = [Select Count() From Documento__c Where DocumentoEtapa__r.Obligatorio__c =: true and Semaforo__c =: 'Rojo' and Iniciado__c =: true and Fecha_Inicio__c !=: null and Oferta__c =: idOferta];
        
        for(ClienteOferta__c co : clientesOferta){
            if(co.Cuenta__c == oferta.ClienteFinal__c){
                idGanador = co.Id;
            }
        }
        UserRecordAccess ura = [SELECT RecordId,HasReadAccess,HasEditAccess FROM UserRecordAccess  WHERE UserId =: UserInfo.getUserId() AND RecordId =: idOferta];
        muestraBoton = ura.HasReadAccess && ura.HasEditAccess;
    }
    public PageReference CheckReds()
    {
    
        DateTime dthoy = system.now();
        String etactual = '';   
        User usrdes = new User();
        system.debug('Este es el rol actual ' + UserInfo.getUserRoleId());   
        if(UserInfo.getUserRoleId()!='00Ei0000000iRIlEAM'){
        for (EtapaOferta__c etofnvet :[Select id, name, Estatus__c, NumEtapa__c, Etapa__r.name From EtapaOferta__c Where Estatus__c =: 'Abierta' and Oferta__c =: oferta.id and Etapa__r.EstatusOferta__c IN ('Compra','Venta') Order By NumEtapa__c asc])
        {
            etactual = etofnvet.Etapa__r.name;         
            system.debug('Esta es la etapa actual' + etactual);          
            break;
        }
        if (etactual != '' && oferta.Etapa__c != etactual && oferta.Estatus__c != 'Descartada' && oferta.Etapa__c != 'Finalizada'){
            oferta.Etapa__c = etactual;
        }
          system.debug('Este es el usuario actual' + UserInfo.getUserId());   
          
        if (iDocRed > 0 && (UserInfo.getUserId() != '005i0000001W6vuAAC' || UserInfo.getUserId() != '00531000007dOl3AAE' || UserInfo.getUserId() != '005i0000001W2vNAAS'))
        {
            system.debug('aqui hay errores '); 
            oferta.Bloqueada__c = true;
            update oferta;
        } else
        {
            system.debug('else esto funca normal aqui no hay errores'); 
            oferta.Bloqueada__c = false;
            update oferta;
        }
        if (UserInfo.getUserId() == '005i0000001W6vuAAC' || UserInfo.getUserId() == '00531000007dOl3AAE' || UserInfo.getUserId() == '005i0000001W2vNAAS')
        {
            system.debug('aqui entro joan '); 
            bBloqueada = false; 
        }else
        {
            system.debug('aqui no entro joan '); 
            if (oferta.Estatus__c == 'Descartada')
            {
                
                usrdes = [Select Id, Profile.name From User Where Id =: UserInfo.getUserId()]; 
                if (usrdes.Profile.name == 'Administrador del sistema' || usrdes.Profile.name == 'Admin Compras')
                {
                   bBloqueada = false;
                }else
                {
                   bBloqueada = true;
                   return new PageReference('/apex/BloqueoMsg?retURL=%2F&sfdc.override=1&id=' + oferta.id);
                }
                
               
            }else
            {
                if(oferta.Bloqueada__c == true && (oferta.Fecha_Desbloqueo__c == null || oferta.Fecha_Desbloqueo__c < dthoy))
                {
                    bBloqueada = true;      
                        
                    return new PageReference('/apex/BloqueoMsg?retURL=%2F&sfdc.override=1&id=' + oferta.id);
                    
                }else
                {
                    bBloqueada = false;
                }
            }
        }
        }
        return null;
    }
    public PageReference Terminar()
    {
        system.debug('Entré aqui que es le metodo terminar');
        return stdctl.cancel();
    }
    public class DocumentoWrapper{
        public DocumentoEtapa__c documentoEtapa {get;set;}
        public Documento__c documento {get;set;}
        
        public DocumentoWrapper(DocumentoEtapa__c documentoEtapa, Documento__c documento){
            this.documentoEtapa = documentoEtapa;
            this.documento = documento;
        }
    }
    
    public Map<String, List<DocumentoWrapper>> mapDocumentos{
        get{
            if(idOferta != null && mapDocumentos == null){
                mapDocumentos = new Map<String, List<DocumentoWrapper>>();
                for(EtapaOferta__c etapa : [Select Id, Name, Oferta__c, Etapa__c From EtapaOferta__c Where Oferta__c = :idOferta]){
                    if(!mapDocumentos.containsKey(etapa.Etapa__c)){
                        mapDocumentos.put(etapa.Etapa__c, new List<DocumentoWrapper>());
                    }
                }
                for(DocumentoEtapa__c doc : [Select Id, Name, Orden__c, Obligatorio__c, Etapa__c, NombreUsuario__c, (Select Id, Name, NumFiles__c, NumFiles_MasFilesPadre__c, Cerrado__c, Iniciado__c, Presentar__c From Documentos__r Where EtapaOferta__r.Oferta__c =: idOferta) From DocumentoEtapa__c Where Etapa__c IN: mapDocumentos.keySet() AND Activo__c = true order by Orden__c]){
                    DocumentoWrapper dw = new DocumentoWrapper(doc, null);
                    if(doc.Documentos__r.size() > 0){
                        dw.documento = doc.Documentos__r[0];
                    } 
                    mapDocumentos.get(doc.Etapa__c).add(dw);
                }
            }
            return mapDocumentos;
        }set;
    }
    
    public void cargarMapa(){
        String perfil = userinfo.getProfileId();
        
        etapas = [SELECT id, Name FROM Etapa__c WHERE Activa__c =: true];
        etapasOferta = [Select id, Name, Etapa__c,Etapa__r.EstatusOferta__c, Etapa__r.Name, Etapa__r.Descripcion__c, Etapa__r.Descripcion2__c, EstatusTiempo__c, EstatusFinal__c From EtapaOferta__c Where Etapa__c IN: etapas AND Oferta__c =: idOferta order by Etapa__r.Orden__c];
        
        etapasOfertaCompra =[Select id, Name, Avance__c, Etapa__c,Etapa__r.EstatusOferta__c, Etapa__r.Name, Etapa__r.Descripcion__c, Etapa__r.Descripcion2__c, EstatusTiempo__c, EstatusFinal__c, Etapa__r.Orden__c,Etapa__r.Inversores__c
                                    From EtapaOferta__c Where Etapa__c IN: etapas AND Oferta__c =: idOferta
                                    AND Etapa__r.EstatusOferta__c =: 'Compra' order by Etapa__r.Orden__c];
        
        if(perfil == Constants.INVERSOR_PROFILE_ID || perfil == Constants.INVERSORFF_PROFILE_ID){
            etapasOfertaCompra =[Select id, Name, Avance__c, Etapa__c,Etapa__r.EstatusOferta__c, Etapa__r.Name, Etapa__r.Descripcion__c, Etapa__r.Descripcion2__c, EstatusTiempo__c, EstatusFinal__c, Etapa__r.Orden__c,Etapa__r.Inversores__c
                                    From EtapaOferta__c Where Etapa__c IN: etapas AND Oferta__c =: idOferta
                                    AND Etapa__r.EstatusOferta__c =: 'Compra'  AND  Etapa__r.Inversores__c = true order by Etapa__r.Orden__c];
        }
        
        etapasOfertaVenta =[Select id, Name, Avance__c, Etapa__c,Etapa__r.EstatusOferta__c, Etapa__r.Name, Etapa__r.Descripcion__c, Etapa__r.Descripcion2__c, EstatusTiempo__c, EstatusFinal__c, Etapa__r.Orden__c,Etapa__r.Inversores__c
                                    From EtapaOferta__c Where Etapa__c IN: etapas AND Oferta__c =: idOferta
                                    AND Etapa__r.EstatusOferta__c =: 'Venta' order by Etapa__r.Orden__c];
        if(perfil == Constants.INVERSOR_PROFILE_ID || perfil == Constants.INVERSORFF_PROFILE_ID){
            etapasOfertaVenta =[Select id, Name, Avance__c, Etapa__c,Etapa__r.EstatusOferta__c, Etapa__r.Name, Etapa__r.Descripcion__c, Etapa__r.Descripcion2__c, EstatusTiempo__c, EstatusFinal__c, Etapa__r.Orden__c,Etapa__r.Inversores__c
                                    From EtapaOferta__c Where Etapa__c IN: etapas AND Oferta__c =: idOferta
                                    AND Etapa__r.EstatusOferta__c =: 'Venta' AND  Etapa__r.Inversores__c = true order by Etapa__r.Orden__c];
        }
        
        mapEtapasCompra = new Map<String, List<EtapaOferta__c>>();
        mapEtapasVenta = new Map<String, List<EtapaOferta__c>>();
        
        
        for(Etapa__c etapa : etapas){
            for(EtapaOferta__c eOferta : etapasOfertaCompra){
                if(eOferta.Etapa__c == etapa.Id){
                    mapEtapasCompra.put(etapa.Name, new List<EtapaOferta__c>());
                    mapEtapasCompra.get(etapa.Name).add(eOferta);
                    break;
                }
            }
        }
        for(Etapa__c etapa : etapas){
            for(EtapaOferta__c eOferta : etapasOfertaVenta){
                if(eOferta.Etapa__c == etapa.Id){
                    mapEtapasVenta.put(etapa.Name, new List<EtapaOferta__c>());
                    mapEtapasVenta.get(etapa.Name).add(eOferta);
                    break;
                }
            }
        }
        
        
    }
    public List<SelectOption> getListaClienteOferta() {
        List<SelectOption> options = new List<SelectOption>();
        if(clientesOferta != null){
            for(ClienteOferta__c c :clientesOferta){
                options.add(new SelectOption(c.Id, c.Cuenta__r.Name)); 
            }
        }
        return options;
    }
    
    public void guardarGanador(){
        try{
            if(idGanador !=  null){
                boolean cambiocli = false;
                ClienteOferta__c co = [SELECT id, Cuenta__c,Estatus2__c,PromotorOferta__c,PromotorOferta__r.Cuenta__c FROM ClienteOferta__c WHERE id =: idGanador];
                if (oferta.ClienteFinal__c != null)
                    cambiocli = true;
                oferta.ClienteFinal__c = co.Cuenta__c;
                if(co.PromotorOferta__c != null){
                    oferta.Promotor__c = co.PromotorOferta__r.Cuenta__c;
                }
                if (cambiocli == true)
                {
                    String etactual = '';   
                    for (EtapaOferta__c etofnvet :[Select id, name, Estatus__c, NumEtapa__c, Etapa__r.name From EtapaOferta__c Where Etapa__r.NumEtapa__c =: 9 and Oferta__c =: oferta.id and Etapa__r.EstatusOferta__c IN ('Compra','Venta') Order By NumEtapa__c asc])
                    {
                        etactual = etofnvet.Etapa__r.name;         
                        system.debug('Esta es la etapa actual' + etactual);          
                        break;
                    }
                    if (etactual != ''){
                        oferta.Etapa__c = etactual;
                    }
                }
                update oferta;
                if (cambiocli)
                {
                    RegresaEtapa9();
                }
            }
        }catch(Exception e){
            mensaje = e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, e.getMessage()));
        }
    }
    public PageReference RegresaEtapa9a()
    {       
        oferta.ClienteFinal__c = null;
                
        oferta.Promotor__c = null;
                
        String etactual = '';   
        for (EtapaOferta__c etofnvet :[Select id, name, Estatus__c, NumEtapa__c, Etapa__r.name From EtapaOferta__c Where Etapa__r.NumEtapa__c =: 9 and Oferta__c =: oferta.id and Etapa__r.EstatusOferta__c IN ('Compra','Venta') Order By NumEtapa__c asc])
        {
             etactual = etofnvet.Etapa__r.name;         
             system.debug('Esta es la etapa actual' + etactual);          
             break;
        }
        if (etactual != ''){
             oferta.Etapa__c = etactual;
        }
                
        update oferta;
              
        RegresaEtapa9();
        
        PageReference pageRef= new PageReference('/a08/o');
        pageRef.setredirect(true);
        return pageRef;
        
       
                    
    }
    public void RegresaEtapa9()
    {
        // Borra y reinicia documentos/pasos
                    list<Documento__c> ldocborrar = new list<Documento__c>();
                    boolean primerpaso = false;
                    map<String, Id> mEtapaof = new map<String, Id>();
                    list<Id> iddocetapap = new list<Id>();
                    string namedoc;
                    set<Id> sidEtapasOf = new set<Id>();
                    Historial_Ofertas__c History = new Historial_Ofertas__c();
                        History.Oferta_name__c   = oferta.id;
                        History.Fecha_de_Eliminiacion__c = System.today();
                        insert History;
                    For (Documento__c docrein :[Select id, name,Fecha_Inicio__c, Iniciado__c,EtapaOferta__c, DocumentoEtapa__r.Borrar_al_Reiniciar__c, Historial__c, Oferta__c,
                                                DocumentoEtapa__r.Etapa_Paso_Anterior__c
                                                From Documento__c Where 
                                                DocumentoEtapa__r.Borrar_al_Reiniciar__c =: true and Oferta__c =: oferta.id
                                                Order by EtapaOferta__r.NumEtapa__c, DocumentoEtapa__r.Orden__c])
                    {
                        if (docrein.DocumentoEtapa__r.Etapa_Paso_Anterior__c <= 8)
                        {
                            mEtapaof.put(docrein.DocumentoEtapa__c,docrein.EtapaOferta__c);
                            iddocetapap.add(docrein.DocumentoEtapa__c);
                            namedoc = docrein.name;
                            primerpaso = true;
                        }
                        docrein.Oferta__c=null;
                        docrein.EtapaOferta__c=null;
                        docrein.Historial__c=History.id; 
                        ldocborrar.add(docrein);
                        sidEtapasOf.add(docrein.EtapaOferta__c);
                    }
                    if (ldocborrar.size()>0)
                    {

                        update ldocborrar;
                    }
                    DateTime dFrom = DateTime.now();
                    list<DocumentoEtapa__c> ldocep = new list<DocumentoEtapa__c>();
                    list<Documento__c> ldocins = new list<Documento__c>();
                    ldocep = [SELECT Id, Name, Tipo__c, NA_Contado__c, Etapa_Doc_a_Iniciar__c,Etapa_Paso_Anterior__c, Ultimo_Documento__c, Paso_Anterior__c, Orden__c, 
                             Tiempo_Proceso__c, Etapa__r.NumEtapa__c FROM DocumentoEtapa__c WHERE id IN:iddocetapap];
                    for (DocumentoEtapa__c docep :ldocep)
                    {
                        Documento__c dinsert = new Documento__c();
                        dinsert.Oferta__c = oferta.id;
                        dinsert.EtapaOferta__c = mEtapaof.get(docep.id);
                        dinsert.DocumentoEtapa__c = docep.id;
                        dinsert.Name = docep.Name;
                        dinsert.Tipo__c = docep.Tipo__c;
                        dinsert.Fecha_Inicio__c = dFrom;
                        dinsert.Fecha_Compromiso__c = wsUtility.addBusinessDays(dFrom, docep.Tiempo_Proceso__c);
                        dinsert.Fecha_Com_Controller__c = wsUtility.addBusinessDays(dFrom, docep.Tiempo_Proceso__c);
                        dinsert.Iniciado__c = true;
                        dinsert.Cerrado__c = false;
                        ldocins.add(dinsert);
                    }
                    for (Documento__c docs :[Select id, name,Fecha_Inicio__c, Iniciado__c,EtapaOferta__c, DocumentoEtapa__r.Abrir_al_Reiniciar__c, 
                                                DocumentoEtapa__r.Etapa_Paso_Anterior__c, DocumentoEtapa__r.Tiempo_Proceso__c, Fecha_Compromiso__c,
                                                Fecha_Com_Controller__c, Cerrado__c
                                                From Documento__c Where 
                                                DocumentoEtapa__r.Abrir_al_Reiniciar__c =: true and Oferta__c =: oferta.id
                                                Order by EtapaOferta__r.NumEtapa__c, DocumentoEtapa__r.Orden__c])
                    {
                        docs.Fecha_Inicio__c = dFrom;
                        docs.Fecha_Compromiso__c = wsUtility.addBusinessDays(dFrom, docs.DocumentoEtapa__r.Tiempo_Proceso__c);
                        docs.Fecha_Com_Controller__c = wsUtility.addBusinessDays(dFrom, docs.DocumentoEtapa__r.Tiempo_Proceso__c);
                        docs.Iniciado__c = true;
                        docs.Cerrado__c = false;
                        ldocins.add(docs);
                    }
                    list<EtapaOferta__c> ldoce = new list<EtapaOferta__c>();
                    for (EtapaOferta__c doce : [Select NumEtapa__c, Estatus__c, HoraFinal__c from EtapaOferta__c Where id IN :sidEtapasOf])
                    {
                        if (doce.NumEtapa__c == 9)
                        {
                            doce.Estatus__c = 'Abierta';
                            doce.HoraFinal__c = null;
                            ldoce.add(doce);
                        }else
                        {
                            doce.Estatus__c = '';
                            doce.HoraFinal__c = null;
                            ldoce.add(doce);
                        }
                    }
                    for (EtapaOferta__c doce : [Select NumEtapa__c, Estatus__c, HoraFinal__c from EtapaOferta__c Where Etapa__r.NumEtapa__c =: 10 AND Oferta__c =: oferta.id])
                    {
                        
                        doce.Estatus__c = '';
                        doce.HoraFinal__c = null;
                        ldoce.add(doce);
                        
                    }
                    
                    
                    upsert ldocins;         
                    update ldoce;
    }
    /*public void GeneraCDates()
    {
        list<Documento__c> lDocOfertaDel = new list<Documento__c>();
        lDocOfertaDel = [SELECT DocumentoEtapa__c, EtapaOferta__c, Fecha_Compromiso_Plan__c, Fecha_Inicio__c, Fecha_Inicio_Plan__c, Fecha_Compromiso__c, Fecha_Com_Controller__c, Cerrado__c, Presentar__c, Iniciado__c, Oferta__c FROM Documento__c WHERE Oferta__c =: IdOferta];
        if (lDocOfertaDel.size()>0)
        {
            Delete lDocOfertaDel;
        }
        map<Id,list<DocumentoEtapa__c>> mDocEtapa = new map<Id, list<DocumentoEtapa__c>>();
        list<Id> lEtapaIds = new list<Id>();
        for (Etapa__c etapa :[SELECT Id,NumEtapa__c, EstatusOferta__c, Name FROM Etapa__c WHERE Activa__c =: true AND (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta') ORDER BY NumEtapa__c])
        {
             list<DocumentoEtapa__c> lDocEtapaAux = new list<DocumentoEtapa__c>();
             lDocEtapaAux = [SELECT Id, Name, Activo__c, Etapa__c, Obligatorio__c, Orden__c, Etapa_Paso_Anterior__c, Paso_Anterior__c, Etapa_Doc_a_Iniciar__c, Doc_a_Iniciar__c, Inicia_Proceso_Venta__c, Tiempo_Proceso__c, Ruta_Critica__c, Tipo__c FROM DocumentoEtapa__c WHERE Activo__c =: true AND Etapa__c =: etapa.Id ORDER BY Orden__c ];
             mDocEtapa.put(etapa.Id, lDocEtapaAux);
             lEtapaIds.add(etapa.Id);
        }
        list<Documento__c> docIns = new list<Documento__c>();
        for(EtapaOferta__c etof :[SELECT Etapa__c, Oferta__c FROM EtapaOferta__c WHERE Oferta__c =: IdOferta AND Etapa__c IN :lEtapaIds])
        {
            
            for (DocumentoEtapa__c doce :mDocEtapa.get(etof.Etapa__c))
            {
              if(doce.Activo__c == true)
              {
                Documento__c docNew = new Documento__c();
                docNew.Oferta__c = IdOferta;
                docNew.EtapaOferta__c = etof.Id;
                docNew.DocumentoEtapa__c = doce.Id;
                docNew.Name = doce.Name;
                docNew.Tipo__c = doce.Tipo__c;
                docIns.add(docNew);
              }
            }
        }
        upsert docIns;
        boolean ret;
        ret = wsUtility.GenerateComDates(IdOferta);
        if (ret == true)
        {
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.INFO,'Las fechas compromiso han sido generadas');
            ApexPages.addMessage(errormsg);
        }else
        {
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'Se ha producido un error al generar las fechas compromiso');
            ApexPages.addMessage(errormsg);
        }
    }
    public PageReference ShowGantt()
    {
        return new PageReference('/apex/OfertaProceso?id=a08f0000003I69r&sfdc.override=1');
    }*/
    public void recargarPagina(){
        mapDocumentos = null;
        cargarMapa();
        clientesOferta = [SELECT id, Contacto__c,Contacto__r.Name, Estatus2__c, Cuenta__c, Cuenta__r.Name,PromotorOferta__r.Cuenta__r.Name  FROM ClienteOferta__c WHERE Oferta__c =: idOferta];
        promotoresOferta = [SELECT id, Contacto__c,Contacto__r.Name, Cuenta__c, Cuenta__r.Name,Cuenta__r.RecordType.Name FROM PromotorOferta__c WHERE Oferta__c =: idOferta];
    }
    
    public void crearComponente(){
        //System.debug('Propiead' + idOferta +' , Etapa: ' + idEtapaOferta );
        //componenteGeneral = new Component.c.etapaEntregable(propiedadVal = idOferta, etapaVal = idEtapaOferta , etapa =  nombreEtapa);
    }
    
    public void descartarOferta(){
        Oferta__c oferta = [Select Id, Etapa__c From Oferta__c Where Id =:idOferta ];
        oferta.Etapa__c = 'Descartada';
        oferta.Estatus__c = 'Descartada';
        update oferta;
    }
    
    public void seleccionaClienteOferta(){
        for(ClienteOferta__c co : clientesOferta){
            if(clienteOfertaEdit.Id == co.Id){
                clienteOfertaEdit = co;
            }
        }
    }
    
    public ClienteOferta__c clienteOfertaEdit {get;set;}
    
    public void editarCliente(){
        update clienteOfertaEdit;
    }
    
    public List<SelectOption> getPromotores() {
        List<SelectOption> options = new List<SelectOption>();
        for(PromotorOferta__c co : [SELECT Id, Cuenta__c, Cuenta__r.Name, Cuenta__r.Contacto__c, Cuenta__r.Contacto__r.Name, Cuenta__r.Id, Contacto__r.id,Contacto__r.Name FROM PromotorOferta__c WHERE Oferta__c =: oferta.Id]) {
            options.add(new SelectOption( co.Id,  co.Cuenta__r.Name));
        }
        return options;
    }
    @isTest(SeeAllData=true)
    public static void test() { 
        Etapa__c etapa = new Etapa__c();
        etapa = [Select id From Etapa__c Where NumEtapa__c =: 9];
        
        Etapa__c etapaVenta = new Etapa__c();
        etapaVenta = [Select id From Etapa__c Where NumEtapa__c =: 13];
        
        DocumentoEtapa__c de = new DocumentoEtapa__c();
        de = [Select id, name From DocumentoEtapa__c Where Etapa__c =: etapa.id and Orden__c =: 2 ];
        
        Propiedad__c p = new Propiedad__c();
        p.Name = 'PTEST999';
        p.GeneraOferta__c = true;
        insert p;
        
        Oferta__c oferta = [Select Id, Name, Propiedad__c From Oferta__c Where Propiedad__c =: p.Id];
        map<integer, EtapaOferta__c> etofaux = new map<integer,EtapaOferta__c>();
        integer i = 0;
        for (EtapaOferta__c eto :[SELECT id, Name, Etapa__c FROM EtapaOferta__c Where Oferta__c =: oferta.id])
        {
            etofaux.put(i,eto);
            i++;
        }
       /* Documento__c doc = new Documento__c();
        doc.Tipo__c = 'TEST';
        doc.Oferta__c = oferta.Id;
        doc.Name = 'IFE';
        doc.EtapaOferta__c = etofaux.get(0).Id;
        doc.DocumentoEtapa__c = de.Id;*/
        //insert doc;
        
        Attachment attach = new Attachment();
        attach.Name = 'Nuevo';
       //attach.ParentId = doc.Id;
        attach.Body = Blob.valueOf('body');
        //insert attach;
        
        Account a = new Account();
        a.Name = 'cuenta';
        a.RecordTypeId = Constants.MAP_RECORDTYPES_DEVNAME.get('Cliente').Id;
        a.Type = 'Cliente';
        insert a;
        Contact con = new Contact();
        con.AccountId = a.Id;
        con.FirstName = 'Steve';
        con.LastName = 'Jobs';
        con.Email = 'ctc@ctc.com';
        insert con;
        ClienteOferta__c cliente = new ClienteOferta__c();
        cliente.Oferta__c = oferta.Id;
        cliente.Cuenta__c = a.Id;
        cliente.Contacto__c = con.Id;
        insert cliente;
        
        Test.startTest();
        ApexPages.StandardController scOferta = new ApexPages.StandardController(oferta);
        OfertaProcesoController controllerOferta = new  OfertaProcesoController(scOferta);
        controllerOferta.cargarMapa();
        controllerOferta.mapDocumentos.values();
        controllerOferta.crearComponente();
        controllerOferta.getListaClienteOferta();
        controllerOferta.idGanador = cliente.Id;
        controllerOferta.guardarGanador();
        controllerOferta.recargarPagina();
        controllerOferta.descartarOferta();
        controllerOferta.CheckReds();
        controllerOferta.Terminar();
        controllerOferta.getPromotores();
        controllerOferta.RegresaEtapa9a();
        Test.stopTest();
    }
    
    
}