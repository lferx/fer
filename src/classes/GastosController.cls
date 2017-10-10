public with sharing class GastosController{
    public Gasto__c gasto {get;set;}
    public Gasto__c gastoNew {get;set;}
    public Oferta__c oferta {get;set;}
    public map<Gasto__c,WrapGasto> mapGasto {get;set;}
    public list<WrapGasto> gastos {get;set;}
    public list<Gasto__c> gastosDelete {get;set;}
    public map<Id,ConceptoCatalogo__c> mapConceptoCatalogo {get;set;}
    //public string perfilActual {get;set;}
    public User userActual {get;set;}
    public static final string GERENTE = 'Gerente';
    public static final string CONTADOR = 'Contador';
    
    public boolean priceEditNew {get;set;} 
    public string ideo {get;set;}
    
    public class WrapGasto{
        public boolean selected {get;set;}
        public boolean priceEdit {get;set;}
        public boolean isNew {get;set;}
        public Gasto__c gasto {get;set;}
        public WrapGasto(){
            priceEdit = true;
            selected = false;
            isNew = true;
            gasto = new Gasto__c();
        }
    }
    public GastosController(ApexPages.StandardController stdController) {
       
        String ido = ApexPages.currentPage().getParameters().get('ido');
        ideo = ApexPages.currentPage().getParameters().get('ideo'); //Etapa oferta, no usado
        try{
        	if (Test.isRunningTest())
            {
               oferta = [SELECT id,name FROM Oferta__c Limit 1];
	           gasto.Oferta__c = oferta.id;	
            }else
            {
	           gasto = (Gasto__c)stdController.getRecord();
	           if(ido != null && ido != ''){
	               oferta = [SELECT id,name FROM Oferta__c WHERE Id =: ido];
	               gasto.Oferta__c = oferta.id;
	           }else if(gasto != null){
	               //No estoy seguro si esto se usaria  
	               oferta = [SELECT id,name FROM Oferta__c WHERE Id =: gasto.Oferta__c];
	           }
            }   
           
        }catch(exception e){
        
        }
        gastoNew = new Gasto__c();
        gastoNew.Tipo__c  = 'Manual';
        priceEditNew = true;
        //gastoNew.GLA__c = mapConceptoGla.get(gastoNew.Concepto__c);
        mapGasto = new map<Gasto__c,WrapGasto>();
        gastos = new list<WrapGasto>();
        gastosDelete = new list<Gasto__c>();
        mapConceptoCatalogo = new map<id,ConceptoCatalogo__c>();
        /*Sustituir para obtenre el perfil actual*/
        //perfilActual = CONTADOR;
        userActual = [SELECT id, Name, PermisoGasto__c FROM User WHERE id =: UserInfo.getUserId() ];
        loadInfo();
        cargarSolicitudesExistentes();
    }
    
    public void loadInfo(){
   
            gastos = new list<WrapGasto>();
            list<Gasto__c> gastosExistentes  = new list<Gasto__c>();
            String sQuery = 'SELECT  Id,EnviarCxP__c, ErrorDuplicado__c, PayableInvoice__c, Cancelado__c ,EtapaOferta__c,Name,MensajeError1__c, MensajeError2__c,MensajeError3__c,Oferta__c, Concepto__c,Concepto__r.Name,Concepto__r.Categoria__c,Concepto__r.CampoImporteOrigen__c, Account__c, Fecha__c,' +
                            'AprobacionDuplicado__c, GLA__c, FolioFactura__c, Importe__c,Estatus__c,EtapaOferta__r.Etapa__r.Name, Comentario__c,SolicitudPago__c,Oferta__r.Inversor__c, Oferta__r.Inversor__r.Alias__c, Oferta__r.Plaza__c,Account__r.Name,ImporteFinal__c,AplicarIVA__c,Concepto__r.Subtipo__c  ' +
                            'FROM Gasto__c';
            
          String sWhere = '';
          String sOrder = ' ORDER BY CreatedDate DESC,Oferta__r.Inversor__c,Oferta__r.Inversor__r.Alias__c, Oferta__r.Plaza__c,Gasto__c.Account__c,Concepto__r.Categoria__c';
            
            sWhere = ' WHERE OwnerId = \'' + UserInfo.getUserId() + '\' AND (Estatus__c = \'Nuevo\' OR Estatus__c = \'Rechazado\')';
            sWhere = sWhere + ' AND SolicitudPago__c = null';
            sQuery = sQuery + sWhere + sOrder;
            if(oferta != null){
                gastoNew.Oferta__c = oferta.Id;
            }
          try{
                gastosExistentes = Database.query(sQuery);
            }catch(Exception e){
                String mensajeExp = recortarMsjError('' + e.getMessage()); 
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , mensajeExp));
            }       
            
            for(Gasto__c gastoExistente: gastosExistentes){
                WrapGasto wg = new WrapGasto();
                wg.isNew = false;
                wg.gasto = gastoExistente;
                gastos.add(wg);
                if(!mapGasto.containskey(gastoExistente)){
                    mapGasto.put(gastoExistente, wg);
                }
            }
        
    }
    
    public List<SelectOption> getConceptoGastos() {
            List<SelectOption> options = new List<SelectOption>();
            for (ConceptoCatalogo__c concepto : [SELECT Id,Name,GLA__c,CampoImporteOrigen__c FROM ConceptoCatalogo__c Where ObjetoSuma__c = 'Oferta__c' AND Activo__c = true Order by Name]){
                options.add(new SelectOption(concepto.Id,concepto.Name));
            }
            return options;
     }
     
     public List<SelectOption> getEtapasOferta() {
            List<SelectOption> options = new List<SelectOption>();
            String idOferta = oferta != null ? oferta.id : gastoNew.Oferta__c; 
            for (EtapaOferta__c eo : [SELECT Id,Name,Etapa__r.Name FROM EtapaOferta__c WHERE Oferta__c =: idOferta ORDER BY etapa__r.Orden__c]){
                options.add(new SelectOption(eo.Id,eo.Etapa__r.Name ));
            }
            return options;
     }
     
    public void obtainEtapasOferta(){
        String idOferta = String.valueOf(ApexPages.currentPage().getParameters().get('idOferta'));
        try{
            gastoNew.Oferta__c = idOferta;
            getEtapasOferta();
        }catch(Exception e){
            String mensajeExp = recortarMsjError('' + e.getMessage()); 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , mensajeExp));
        }
    }
    
    public map<String,String> mapConceptoGla {
        get{
            if(mapConceptoGla == null){
                mapConceptoGla = new map<String,String>();
                for (ConceptoCatalogo__c concepto : [SELECT Id,Name,GLA__c,GLA_Proveedor__c, CampoImporteOrigen__c,Categoria__c FROM ConceptoCatalogo__c]){
                    if(!mapConceptoGla.containsKey(concepto.id)){
                        if(concepto.GLA_Proveedor__c == false){
                            mapConceptoGla.put(concepto.Id,concepto.Gla__c);
                        }
                    }
                    if(!mapConceptoCatalogo.containsKey(concepto.Id)){
                        mapConceptoCatalogo.put(concepto.Id,concepto);
                    }
                }
            }
           return mapConceptoGla;
        }
        set;
    }
    
    public PageReference obtainGLANew(){
        String idConcepto = String.valueOf(ApexPages.currentPage().getParameters().get('idConcepto'));
        String idAccount = String.valueOf(ApexPages.currentPage().getParameters().get('idAccount'));
        String idOferta = String.valueOf(ApexPages.currentPage().getParameters().get('idOferta'));
        String squery = '';
        
        
        /*if(mapConceptoGla.containsKey(idConcepto)){
            gastoNew.GLA__c = mapConceptoGla.get(idConcepto);
        }else if(mapConceptoCatalogo.containsKey(idConcepto)){
              if(mapConceptoCatalogo.get(idConcepto).GLA_Proveedor__c == true){
                  if(!idAccount.equals('')){
                     Account cuenta = [SELECT id, c2g__CODAAccountsPayableControl__c FROM Account WHERE id =: idAccount];
                     gastoNew.GLA__c = cuenta.c2g__CODAAccountsPayableControl__c;
                   }
              }
        }*/
        
        if(mapConceptoCatalogo.containsKey(idConcepto) && idOferta != null){
           if(mapConceptoCatalogo.get(idConcepto).CampoImporteOrigen__c != null ){
               try{
                   squery = 'SELECT id,Name,' + mapConceptoCatalogo.get(idConcepto).CampoImporteOrigen__c + ' FROM Oferta__c WHERE id = \'' + idOferta + '\'';
                   List<Oferta__c> ofertas = Database.query(squery);
                   if(ofertas != null){
                       gastoNew.Importe__c = (Decimal)ofertas[0].get(mapConceptoCatalogo.get(idConcepto).CampoImporteOrigen__c);
                       priceEditNew = false;
                   }
               }catch(Exception e){
                   String mensajeExp = recortarMsjError('' + e.getMessage()); 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , mensajeExp));
               }
           }
        }
        //System.debug('ALGO : ' + idConcepto+ ',' + idAccount + ','+ idOferta +','+ squery);
        return null;
    }
    
     public PageReference obtainGLA(){
        String idConcepto = String.valueOf(ApexPages.currentPage().getParameters().get('idConcepto'));
        String idAccount = String.valueOf(ApexPages.currentPage().getParameters().get('idAccount'));
        Integer index = Integer.valueOf(ApexPages.currentPage().getParameters().get('index'));
        
        if(mapConceptoGla.containsKey(idConcepto)){
            gastos.get(index).gasto.GLA__c = mapConceptoGla.get(idConcepto);
        }else if(mapConceptoCatalogo.containsKey(idConcepto)){
              if(mapConceptoCatalogo.get(idConcepto).GLA_Proveedor__c == true){
                  if(!idAccount.equals('')){
                     Account cuenta = [SELECT id, c2g__CODAAccountsPayableControl__c FROM Account WHERE id =: idAccount];
                     gastos.get(index).gasto.GLA__c = cuenta.c2g__CODAAccountsPayableControl__c;
                   }
              }
        }
        return null;
    }
    
    public PageReference duplicateGasto(){
        list<WrapGasto> newGastos = new list<WrapGasto>();
        for(WrapGasto wg:gastos){
            if(wg.selected == true){
                System.debug('SELECTED ' + wg.gasto);
                 WrapGasto wgCopy = new WrapGasto();
                 wgCopy.gasto = wg.gasto.clone(false,true);
                 newGastos.add(wgCopy);
               
            }
        }
        if(newGastos.size() > 0){
            gastos.addAll(newGastos);
        }
        return null;
    }
    
    public void addGasto(){
        WrapGasto wg = new WrapGasto();
        //gastoNew.Oferta__c = oferta.id;
        wg.gasto = gastoNew;
        wg.selected = true;
        //mapGasto.put(gastoNew,wg);
        wg.priceEdit = priceEditNew;
        gastos.add(wg);
        gastoNew = new Gasto__c();
        priceEditNew = true;
        if(oferta != null){
            gastoNew.Oferta__c = oferta.Id;
        }   
    }
    
    public void deleteGasto(){
        list<WrapGasto> copyGastos = new list<WrapGasto>(); 
        for(Integer i = 0; i < gastos.size() ; i++){
            if(gastos.get(i).selected == true){
                if(gastos.get(i).gasto.id != null){
                     Gasto__c ga = gastos.get(i).gasto; // Modificación 05/10/2014
                     ga.Cancelado__c = true; // Modificación 05/10/2014
                     gastosDelete.add(gastos.get(i).gasto);
                }
                copyGastos.add(gastos.get(i)); // Modificación 05/10/2014
            }else{
                copyGastos.add(gastos.get(i));
            }
            
        }
        gastos = copyGastos;
    }
    
    public void saveGastos(){
        list<Gasto__c> gastosUpdate = new list<Gasto__c>();
        for(WrapGasto wg : gastos){
             if(wg.gasto.AprobacionDuplicado__c != 'Pendiente'){
             	gastosUpdate.add(wg.gasto);
             }
        }
        try{       
          upsert gastosUpdate;
          if(gastosDelete.size() > 0 ){
             //delete gastosDelete;
             update gastosDelete;  // Modificación 05/10/2014
             gastosDelete = new list<Gasto__c>();
          }
          loadInfo();
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM ,'Datos guardados correctamente'));
        }catch(Exception e){
             System.debug('error SAVE' + e.getMessage()  );
             String mensajeExp = recortarMsjError('' + e.getMessage()); 
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , mensajeExp));
        }
    }
    
    public PageReference regresar(){
        PageReference pagref = new PageReference('/' + oferta.Id);
        return pagref;
    }
    
    /*
    RJP
    Métodos de la funcionalidad de agrupación
    */
    public String msgAgruparGastos {get;set;}
    public String agrupacionSelected {get;set;}
    public List<SelectOption> soAgrupaciones {get;set;}
    public List<WrapGasto> gastosAgrupacionSelected {get;set;}
    public Map<Id, SolicitudPago__c > mapSolicitudPago {get;set;}
    public Gasto__c gastoMuestraSelected {get;set;}
    public SolicitudPago__c solicitudPago {get;set;}
   
    public map<SolicitudPago__c,list<WrapGasto>> mapSolicitudesGasto {get;set;}
    public  list<SolicitudPago__c> solicitudExistentes {get;set;} 
    public  list<WrapSolicitud> solicitudesPago {get;set;} 
    
    public class WrapSolicitud{
      public boolean selected {get;set;}
        public SolicitudPago__c solicitud {get;set;}
        public List<WrapGasto> gastos {get;set;}
        public WrapSolicitud(){
            gastos = new List<WrapGasto>();
        }
    }
 
    public PageReference iniciaAgruparGastos(){
        gastosAgrupacionSelected = new list<WrapGasto>();
        msgAgruparGastos = '';
        agrupacionSelected = 'Nuevo';
        for(WrapGasto wg:gastos){
            if(wg.selected == true){
               gastosAgrupacionSelected.add(wg);
            }
        }
        
        Integer veces = 0;
        String sKeyGlobal = '';
        String sKey = '';
        /*RJP-Crear el metodo aparte de llenado de mapConceptoCatalogo, sacarlo de mapConceptoGla*/
        map<String,String> mapConceptoGlaClon = mapConceptoGla;
        
        if(gastosAgrupacionSelected.size() <= 0){
            msgAgruparGastos = 'Seleccione uno o más gastos';
        }
        //try{
            for(WrapGasto wg :  gastosAgrupacionSelected){
                 if(wg.gasto.id != null && wg.gasto.AprobacionDuplicado__c == 'Rechazado'){
                    msgAgruparGastos += wg.gasto.Name +' - Está duplicado y requiere autorización especial antes de agrupar. Puedes entrar al gasto y dar click en "Solicitar aprobación de duplicado".\n'; 
                    //break;
                }
                 if(wg.gasto.id == null){
                    msgAgruparGastos = 'Debe guarar todos los gastos antes de agrupar'; 
                    break;
                }
                if(veces == 0){
                    gastoMuestraSelected = wg.gasto;
                    sKeyGlobal = gastoMuestraSelected.Oferta__r.Inversor__c + gastoMuestraSelected.Oferta__r.Plaza__c + gastoMuestraSelected.Account__c + mapConceptoCatalogo.get(gastoMuestraSelected.Concepto__c).Categoria__c ;
                }else{
                    sKey = wg.gasto.Oferta__r.Inversor__c + wg.gasto.Oferta__r.Plaza__c + wg.gasto.Account__c + mapConceptoCatalogo.get(wg.gasto.Concepto__c).Categoria__c ;
                    if(!sKeyGlobal.equals(sKey)){
                       msgAgruparGastos = 'Debe seleccionar gastos con el mismo beneficiario, plaza, categoría y empresa (inversor)'; 
                       break;
                    }
                }
                veces++;
            }
                      
            if(!msgAgruparGastos.equals('')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , msgAgruparGastos));
            }else{
                soAgrupaciones = new List<SelectOption>();
                soAgrupaciones.add(new SelectOption('Nuevo','Nueva agrupación'));
                try{
                    mapSolicitudPago = new Map<ID, SolicitudPago__c>([SELECT id,Name,Account__c,FolioFactura__c , Tipo__c 
                                                                        FROM SolicitudPago__c 
                                                                        WHERE Account__c =: gastoMuestraSelected.Account__c 
                                                                        AND Tipo__c =: gastoMuestraSelected.Concepto__r.Categoria__c 
                                                                        AND Empresa__c =: gastoMuestraSelected.Oferta__r.Inversor__c
                                                                        AND Plaza__c =: gastoMuestraSelected.Oferta__r.Plaza__c
                                                                        AND OwnerId =: UserInfo.getUserId() 
                                                                        AND EnviarCxP__c = false]); 
                    for(SolicitudPago__c ag : mapSolicitudPago.values()){
                        soAgrupaciones.add(new SelectOption(ag.Id,ag.Name));
                    } 
                }catch(Exception e){
                    
                }
                if(agrupacionSelected.equals('Nuevo')){
                    String name = gastoMuestraSelected.Account__r.Name + getFolioSolicitud(gastoMuestraSelected.Account__c);
                    solicitudPago = new SolicitudPago__c();
                    solicitudPago.Name = name;
                    solicitudPago.FolioFactura__c = name;
                    solicitudPago.Account__c = gastoMuestraSelected.Account__c;
                    solicitudPago.Empresa__c = gastoMuestraSelected.Oferta__r.Inversor__c;
                    solicitudPago.Tipo__c = mapConceptoCatalogo.get(gastoMuestraSelected.Concepto__c).Categoria__c;
                    solicitudPago.Plaza__c = gastoMuestraSelected.Oferta__r.Plaza__c;
                }
            }
        //}catch(Exception e){
          //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , e.getMessage()));
        //}
        return null;
    }
    
    public PageReference guardarAgrupacion(){
        List<Gasto__c> gastosUpdate = new List<Gasto__c>();
        try{
            upsert solicitudPago;
            Double totalSolicitud = 0.0;
            if(solicitudPago.Id != null){
                for(WrapGasto wg : gastosAgrupacionSelected){
                    wg.gasto.SolicitudPago__c = solicitudPago.Id;
                    totalSolicitud = totalSolicitud + wg.gasto.Importe__c;
                    gastosUpdate.add(wg.gasto);
                }
            }
            upsert gastosUpdate;
            loadInfo();
            cargarSolicitudesExistentes();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM , 'Agrupación creada correctamente'));
        }catch(Exception e){
            msgAgruparGastos = e.getMessage();
            String mensajeExp = recortarMsjError('' + e.getMessage()); 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , mensajeExp));
        }
        return null;
    }
    
    public void cargarSolicitudesExistentes(){
        mapSolicitudesGasto = new map<SolicitudPago__c,list<WrapGasto>>();
        solicitudesPago = new list<WrapSolicitud>();
        
        set<Id>idSolicitudes = new set<Id>();
        
        solicitudExistentes = [SELECT id,Name,Estatus__c,Tipo__c,Datos_bancarios__c,Plaza__c,FolioFactura__c, ImporteFinal__c , Rechazado__c,
                                     Processed__c, Cancelado__c, Process__c, Account__c, EnviarCxP__c, Importe__c, Account__r.EstatusInfoCuenta__c, Account__r.Name,
                                     MotivoRechazo__c
                                     FROM SolicitudPago__c  WHERE Estatus__c IN ('Rechazado','Nuevo') AND  OwnerId =: UserInfo.getUserId() 
                              ORDER BY CreatedDate DESC];
        for(SolicitudPago__c sp:solicitudExistentes){
            idSolicitudes.add(sp.Id);
            if(!mapSolicitudesGasto.containsKey(sp)){
                mapSolicitudesGasto.put(sp,new list<WrapGasto>());
            }
        }
        list<Gasto__c> gastosConSolicitud = [SELECT id,Name,ImporteFinal__c,AplicarIVA__c ,Account__c,EnviarCxP__c,Importe__c,Rechazado__c, 
                                             Tipo__c,SolicitudPago__c,Comentario__c,Oferta__c,Concepto__c,MensajeError1__c,MensajeError2__c,MensajeError3__c, 
                                             Cancelado__c, AprobacionDuplicado__c, ErrorDuplicado__c
                                             FROM Gasto__c WHERE SolicitudPago__c IN : idSolicitudes];
        for(SolicitudPago__c sp:solicitudExistentes){
            WrapSolicitud ws = new WrapSolicitud();
            ws.solicitud = sp;
            for(Gasto__c gasto:gastosConSolicitud){
                if(sp.Id == gasto.SolicitudPago__c){
                    WrapGasto wg = new WrapGasto();
                    wg.gasto = gasto;
                    wg.isNew = false;
                    mapSolicitudesGasto.get(sp).add(wg);
                    ws.gastos.add(wg);
                }
            }
            solicitudesPago.add(ws);
        }
        //solicitudesPago.sort();
    }
    
    public void desagruparGasto(){
        list<Gasto__c> gastos = new list<Gasto__c>();
        for(WrapSolicitud ws:solicitudesPago){
            for(WrapGasto wg:ws.gastos){
                if(wg.selected){
                    gastos.add(wg.gasto);
                }
            }
        }
        
        for(Gasto__c gasto:gastos){
            gasto.SolicitudPago__c = null;
        }
        
        try{
            update gastos;
            loadInfo();
            cargarSolicitudesExistentes();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM , 'Datos guardos correctamente'));
        }catch(Exception e){
          String mensajeExp = recortarMsjError('' + e.getMessage()); 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , mensajeExp));
        }
    }
    
    private String recortarMsjError(String mensajeError){
    if(mensajeError.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION,')){
      Integer length = 'FIELD_CUSTOM_VALIDATION_EXCEPTION,'.length(); 
      Integer index = mensajeError.indexOf('FIELD_CUSTOM_VALIDATION_EXCEPTION,');
      Integer index2 = mensajeError.indexOf(': []');
      mensajeError = mensajeError.substring(index+length, index2);
    }
    return mensajeError; 
  }
    
    
    public void getSolicitud(){
        if(!agrupacionSelected.equals('Nuevo')){
          solicitudPago = [SELECT id,Name,Empresa__c,FolioFactura__c ,Tipo__c,Plaza__c, Rechazado__c, Processed__c, Cancelado__c, Process__c, Account__c, Account__r.EstatusInfoCuenta__c, Account__r.Name, EnviarCxP__c, Importe__c   FROM SolicitudPago__c WHERE Id =: agrupacionSelected];
        }else{
            String name = gastoMuestraSelected.Account__r.Name + getFolioSolicitud(gastoMuestraSelected.Account__c);
            solicitudPago = new SolicitudPago__c();
            solicitudPago.Name = name;
            solicitudPago.FolioFactura__c = name;
            solicitudPago.Account__c = gastoMuestraSelected.Account__c;
            solicitudPago.Empresa__c = gastoMuestraSelected.Oferta__r.Inversor__c;
            solicitudPago.Tipo__c = mapConceptoCatalogo.get(gastoMuestraSelected.Concepto__c).Categoria__c;
            solicitudPago.Plaza__c = gastoMuestraSelected.Oferta__r.Plaza__c;
        }
    }
    
    private Boolean validaSolicitudes(List<WrapSolicitud> listaSolicidtudesWrapper){
    	Boolean validado = true;
    	Set<String> setIds = new Set<String>();
    	for(WrapSolicitud ws :  listaSolicidtudesWrapper){
    		setIds.add(ws.solicitud.Account__c);
    	}
    	Map<ID, Account> mapAccounts = new Map<ID, Account>([Select Id, EstatusInfoCuenta__c, Name From Account Where Id IN: setIds]); 
    	for(WrapSolicitud ws :  listaSolicidtudesWrapper){
            for(WrapGasto wg:ws.gastos){
                if(ws.solicitud.EnviarCxP__c && wg.gasto.AprobacionDuplicado__c == 'Rechazado'){
                	String error = wg.gasto.Name +' - Está duplicado y requiere autorización especial antes de enviar a CxP. Puedes entrar al gasto y dar click en "Solicitar aprobación de duplicado"\n'; 
                	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , error));
                	validado = false;
                }
            }
            if(ws.solicitud.EnviarCxP__c && mapAccounts.get(ws.solicitud.Account__c).EstatusInfoCuenta__c != 'Completo' ){
            	String error = mapAccounts.get(ws.solicitud.Account__c).Name +' - Falta información: <br/> <div style=\'padding-left:10px\'><b>' + mapAccounts.get(ws.solicitud.Account__c).EstatusInfoCuenta__c + '</b></div>'; 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , error));
                validado = false;
            }
        }
        return validado;
    }
    
    public void saveSolicitudes(){
        list<SolicitudPago__c> solicitudUpdate = new list<SolicitudPago__c>();
        list<Gasto__c> gastoUpdate = new list<Gasto__c>();
        if(validaSolicitudes(solicitudesPago)){
        	for(WrapSolicitud ws :  solicitudesPago){
	            solicitudUpdate.add(ws.solicitud);
	            for(WrapGasto wg:ws.gastos){
	                gastoUpdate.add(wg.gasto);
	            }
	        }
	        try{
		    	update solicitudUpdate;
		        update gastoUpdate;
		        cargarSolicitudesExistentes();
		        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM , 'Datos guardados correctamente'));
		   	}catch(Exception e){
		        String mensajeExp = recortarMsjError('' + e.getMessage()); 
		        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , mensajeExp));
		    }
        }
    }
    
    private Integer getFolioSolicitud(String sBeneficiarioId){
        Integer consecutivo = 0;
        try{
            AggregateResult groupedResult = [SELECT COUNT(Id) consecutivo FROM SolicitudPago__c WHERE Account__c =: sBeneficiarioId GROUP BY Account__c];
          consecutivo = (Integer)groupedResult.get('consecutivo');
        }catch(Exception e){
            
        }
        consecutivo++;
        return consecutivo;
    }
    
    
}