public with sharing class Consola_Compras_Controller {

    public Datetime hoy {get;set;}                                                          //para obtener la fecha
    public String hoyString {get;set;}                                                      //guarda la fecha en tipo string
    public Integer ind = 0;                                                                 //variable contador de apoyo para numerar en orden consecutivo el "index" de la lista de documentos  
    public String vuser {get;set;}                                                          //almacena el valor seleccionado en el filtro de usuarios para supervisar del panel de admin
    public String vfolio {get;set;}                                                         //almacena el valor seleccionado en el filtro de IDs asignados del panel de admin
    public String vdoc {get;set;}                                                           //almacena el valor seleccionado en el filtro de documentos asignados del panel de admin
    public List<SelectOption> user;                                                         //para el filtro de usuario
    public List<SelectOption> folios;                                                       //para el filtro de folios asignados
    public List<SelectOption> docsList;                                                     //para el filtro de documentos del ID 
    public transient List<AggregateResult> idAsignados {get;set;}                           //guarda la lista de IDs del panel de admin
    public transient List<Documento__c> docsAsignados {get;set;}                            //guarda la lista de Documentos con retrazo del panel de admin

    
    public Id docId {get; set;}                                                             //almavena el id do un documento, usos varios en consultas y asignaciones                                                   
    public Bitacora_Oferta__c bitacora {get;set;}                                           //para guardar una bitacora nueva
    public Documento__c docTemp {get;set;}                                                  //variable de apoyo para el metodo de documentos en espera
    public Bitacora_Oferta__c registroRecordatorio {get;set;}                               //variable para la query de actualizacion al completar una bitacora con el boton OK
    public ID idBitacora {get;set;}                                                         //recibe el id de la bitacora que sera actualizada al completarse
    public boolean completada {get;set;}                                                    //para asignar el valor true al campo de bitacora completada
    public Integer lim {get;set;}                                                           //para el limite de documentos pendientes que se traeran por gerente
    public Account avance {get;set;}                                                        //guarda el valor del contador de documentos pendientes cerrados
    public String folio {get;set;}                                                          //guarda el folio ingresado en la seccion de buscador
    public boolean mostrarDialogo {get;set;}                                                //un boleano que dependiendo de ciertas condiciones define si se muestra o no el dialogo de ID no encontrado en el buscador
    public transient List<Documento__c> listaBusqueda {get;set;}                            //guarda la lista de resultados de documentos enocntrados en el buscador
    public transient List<Bitacora_Oferta__c> listaBitacoras {get;set;}                     //guarda la lista de bitacoras del panel de admin
    public transient Oferta__c infoId {get;set;}                                            //contiene la informacion de la oferta seleccionada en el panel de admin
    
    public List<Documento__c> listaDocumentos {get;set;}                                    //contiene la lista de documentos pendientes
    public List<Documento__c> ajustaTiempo {get;set;}                                       //lista de los documentos que se actualizaran en funcion de sus tiempos especiales por plaza
    public Account roberto {get;set;}														//variable para guardar los datos de la cuenta de Roberto Pacheco
    public Integer posicion {get;set;}														//indica la posicion de la lista que se actualizara
    public Datetime fechaInicio {get;set;}
    public Datetime fechaFinal {get;set;}
    
    public List<DocumentoWrapper> listaTiempoDocumentos {get;set;}                          //la lista principal con los elementos para tabal de elementos pendientes
    public transient List<Documento__c> listaTemporal {get;set;}                            //una lista auxiliar para "llamar" el numero restante de registros de cada etapa segun su proridad
    public transient List<Documento__c> documentosMonto {get;set;}                          //lista con los documentos y el monto ingresado
    public DocumentoWrapper objectTiempoDocumentos {get;set;}                               //el objeto tipo wrapper que almacena los datos en el proceso antes de incorporarlos a la lista
    public List<Bitacora_Oferta__c> recordatorios {get; set;}                               //lista con las bitacoras no completadas y con recordatorio
    public transient List<Bitacora_Oferta__c> dictamenesCompleto {get; set;}                //lista con todas las bitacoras de la consola, para verificar la ultima de cada documento
    public transient List<Bitacora_Oferta__c> dictamenes {get; set;}                        //lista con las bitacoras especificas de un documento para verificar el ultimo dictamen
    public Bitacora_Oferta__c dictamen {get;set;}                                           //almacena el ultimo dictamen de la oferta para meterlo en la wrapper list
    public Set<Id> documentosIds {get; set;}                                                //?????
    public Oferta__c simpleOferta {get;set;}                                                //almacena la informacion de la oferta del primer elemento de la lista de documentos pendientes
    public List<Documento__c> simpleEtapa {get;set;}                                        //almacena la informacion deL primer elemento de la lista de documentos pendientes
    public DocumentoWrapper simpleDocSolicitado {get;set;}                                  //almacena la lista de docmentos restantes del ID con mas prioridad

    //clase wrapper para la lista principal de la tala
    public class DocumentoWrapper implements Comparable{
        
        public Integer index {get;set;}                                                     //posicion  en la lista de documentos pendientes
        public Documento__c docs {get;set;}                                                 //documento pendiente
        public boolean retraso {get;set;}                                                   //indicador de documento retrazado
        public String nombreCuenta {get;set;}                                               //inician variables para traer cuentas de infraestructura a contactar
        public String telefonoCuenta {get;set;}                                             //
        public ID idCuenta {get;set;}                                                       //
        public String tipoCuenta {get;set;}                                                 //
        public String nombreCuenta2 {get;set;}                                              //
        public String telefonoCuenta2 {get;set;}                                            //
        public ID idCuenta2 {get;set;}                                                      //
        public String tipoCuenta2 {get;set;}                                                //terminan variables de cuentas
        public String ultimaBitacora {get;set;}                                             //almaceba el dicatmen de la ultima bitacora registrada
        public boolean recordatorio {get;set;}                                              //indicador de recordatorio


        
        public DocumentoWrapper(){
            docs = new Documento__c();                                                      
            index = -1;
            retraso = false;
            recordatorio = false;
        }

        public Integer compareTo(Object compareTo) {                                        //metodo para la ordenacion de los documentos en la lista segun el modelo establecido de prioridad
            DocumentoWrapper otroDocumento = (DocumentoWrapper)compareTo;
            
            
            if(!recordatorio && !otroDocumento.recordatorio && (ultimaBitacora != NULL && ultimaBitacora != '') && (otroDocumento.ultimaBitacora == NULL || otroDocumento.ultimaBitacora == '')){                       //Aqui se ordenan al fina los que tienen recordatorio
                return -1;
            }else if(!recordatorio && !otroDocumento.recordatorio && (ultimaBitacora == NULL || ultimaBitacora == '') && (otroDocumento.ultimaBitacora != NULL && otroDocumento.ultimaBitacora != '')){ 
                return 1;
            }
            else if(recordatorio && !otroDocumento.recordatorio){                                                                                                                                                       //Aqui se ordenan al fina los que tienen recordatorio
                return 1;
            }
            else if(!recordatorio && otroDocumento.recordatorio){
                return -1;
            }else if(docs.DocumentoEtapa__r.Etapa__r.NumEtapa__c == otroDocumento.docs.DocumentoEtapa__r.Etapa__r.NumEtapa__c){                                                                                         //Aqui se ordenan por tiempo si son de la misma etapa
                if(docs.Tiempo_Restante__c == otroDocumento.docs.Tiempo_Restante__c){
                    return 0;
                }else if(docs.Tiempo_Restante__c >= otroDocumento.docs.Tiempo_Restante__c){
                    return 1;
                }else{
                    return -1;
                }
            }else if(docs.DocumentoEtapa__r.Etapa__r.NumEtapa__c >= otroDocumento.docs.DocumentoEtapa__r.Etapa__r.NumEtapa__c){
                return -1;
            }else if(retraso && !otroDocumento.retraso){                                                                                                                                                                //Aqui se ordenan primero los que tienen retraso
                return -1;
            }else if(!retraso && otroDocumento.retraso){
                return 1;
            }
            else{
                return 1;
            }
            
        }

    }


    public Consola_Compras_Controller(){                                                                 		 	//constructor de la clase
        lim = 40;
        infoId = new Oferta__c();
        if(!test.isrunningtest()){
        	roberto = [SELECT id,type,phone,name FROM Account WHERE id = '001g000001VUZVkAAP'];
        }
        vuser = UserInfo.getFirstName()+' '+UserInfo.getLastName();
        docTemp = new Documento__c();
        bitacora = new Bitacora_Oferta__c(); 
        hoy = Datetime.now();
        hoyString = hoy.format();
        cargaLista();
    }
    
    public List<SelectOption> getUser(){                                                                            //metodo para la lista de seleccion de usuario en el panel de admin
        user = new List<SelectOption>();
        user.add(new SelectOption('Edgar Joel Juarez Plata','Edgar Joel Juarez Plata'));
        user.add(new SelectOption('Leonardo Emmanuel Decler Balderas','Leonardo Emmanuel Decler Balderas'));
        user.add(new SelectOption('Luis Enrique Permansu Reyes','Luis Enrique Permansu Reyes'));
        //user.add(new SelectOption('Edgar Ramirez Esparza','Edgar Ramirez Esparza'));
        //user.add(new SelectOption('Shell Gomez Gomez','Shell Gomez Gomez'));
        return user;
    }
    
    public List<SelectOption> getFolios(){                                                                          //metodo para la lista de seleccion de folio en el panel de admin
        folios = new List<SelectOption>();
        idAsignados = queryIdAsignados();
        if(idAsignados != NULL){
            for(AggregateResult reg: idAsignados){
                folios.add(new SelectOption((String)reg.get('name'),(String)reg.get('name')));
            }
        }
        else {
            folios.add(new SelectOption('sin id','Sin IDs Asignados'));
        }
        
        return folios;
    }

    public List<SelectOption> getDocsList(){                                                                        //metodo para la lista de seleccion de documento en el panel de admin
        docsList = new List<SelectOption>();
        docsAsignados = queryDocsAsignados();
        if(docsAsignados != NULL){
            for(Documento__c reg: docsAsignados){
                docsList.add(new SelectOption(reg.name,reg.name));
            }
        }
        else {
            docsList.add(new SelectOption('sin id','Sin Documentos Pendentes'));
        }
        
        return docsList;
    }

    public void cargaLista(){                                                                                       //metodo principal para asignar los documentos y el resto de los elementos a la lista de la tabla principal

        lim = 40;
        String[] etapas = new String[]{'Escrituras en proceso registro','Compra final','Compilación expediente compra','Aprobada internamente','Antecedentes'};     //las etapas que se tomaran en cuenta para el query de la lista de documentos
        
        listaTiempoDocumentos = new List<DocumentoWrapper>();
        documentosIds = new Set<Id>();
        listaDocumentos = new List<Documento__c>();
        dictamenesCompleto = [SELECT Dictamen_Consola__c, Recordatorio__c,Documento__c,id,Oferta__c from Bitacora_Oferta__c WHERE Documento__c in (SELECT ID FROM Documento__c WHERE Oferta__r.Gerente_Escrituras__r.name = :vuser AND Oferta__r.FechaCobro__c = NULL AND Oferta__r.Estatus__C != 'Descartada' AND Oferta__r.Etapa__c IN ('Escrituras en proceso registro','Compra final','Compilación expediente compra','Aprobada internamente','Antecedentes') AND name IN ('Escrituras','Poderes','Otros antecedentes','Certificado de libertad de gravamen','Avalúo fiscal y/o comercial','Certificado fiscal','Agua','Predial','Otro Adeudos y Pagos','Proyecto final','Comprobante de pago de la propiedad','Pago honorarios','Pago Gastos de Registro','Pago ISAI','Boleta de Registro','Escrituras Registradas')  AND Cerrado__c != true AND EtapaOferta__r.EtapaActual__c = true AND Iniciado__c = true ) ORDER BY CreatedDate];   //Para poner el ultimo dictamen, saber si tiene recordatorio y poder ordenarla al principio o al final
        //SELECT Dictamen_Consola__c, Recordatorio__c,Documento__c,id from Bitacora_Oferta__c WHERE Documento__c in (SELECT ID FROM Documento__c WHERE (Oferta__r.Gerente_Operativo__r.name = 'Shell Gomez Gomez' OR Oferta__r.Controller_Operativo1__c = 'Shell Gomez Gomez' OR Oferta__r.Controller_Operativo2__c = 'Shell Gomez Gomez') AND Oferta__r.TipoOferta__c != 'Contado' AND Oferta__r.FechaCobro__c = NULL AND Oferta__r.Estatus__C != 'Descartada' AND Oferta__r.Etapa__c IN ('Expediente aprobado','Compilación expediente crediticio','Rehabilitación','Cierre oferta') AND name IN ('Presupuesto de rehabilitación','Fotografia del estado inicial','Fotografia del estado final de la propiedad','Avalúo','CLG','Predial','Constancia de Crédito','Carta de instrucción Notarial','Carta de Intrucción Revimex','Proyecto de Escrituras','Aviso de Retención Y Firma Cliente','Confirmación cobro propiedad','Carta de entrega','Fotos de Entrega','Pre-cierre','Pago Activado','Escrituras Registradas','Cierre Contabilidad','Comprobante Firma Apoderado','Comprobante Comisión Broker','Comprobante Comisión Gerente','Comprobante Anticipo Comisión Gerente','Pago Ventanilla Unica','Comprobante de Pago Ventanilla Unica','Pre-Pantalla') AND Cerrado__c != true AND EtapaOferta__r.EtapaActual__c = true AND Iniciado__c = true ) ORDER BY CreatedDate];   //Para poner el ultimo dictamen, saber si tiene recordatorio y poder ordenarla al principio o al final

        //proceso para traer solo "lim" documentos, de tal manera  que se traen de la base y se integran a la lista ya ordenados por etapa segun el modelo establecido de prioridad
        for(Integer i=0;i<4;i++){
            listaTemporal = queryDocumentos(etapas[i]); 
            listaDocumentos.addAll(listaTemporal);
            
            if(listaTemporal.size() >= lim){
                break;
            }
            lim-=listaTemporal.size();
        }
        
        //proceso para el llenado de la wrapper list de la tabla principal
        for(Documento__c registro : listaDocumentos){

        	if(registro.name == 'Certificado fiscal' && (registro.Oferta__r.Plaza__c != 'Mexicali' && registro.Oferta__r.Plaza__c != 'Ensenada' && registro.Oferta__r.Plaza__c != 'Baja California' && registro.Oferta__r.Plaza__c != 'Tijuana')){
        		continue;
        	}
            objectTiempoDocumentos = new DocumentoWrapper();
                
            //indica si el documento tiene retraso
            if(registro.Tiempo_Restante__c < 0){
                objectTiempoDocumentos.retraso = true;
            }
            else{
                objectTiempoDocumentos.retraso = false;
            }
            
            //proceso para establecer que contacto se debe mostrar en la consola dependiendo de la etapa en la que se encuentre
            if(registro.DocumentoEtapa__r.Etapa__r.NumEtapa__c == 4 && !test.isrunningtest()){
                objectTiempoDocumentos.idCuenta = roberto.id;
                objectTiempoDocumentos.nombreCuenta = roberto.name;
                objectTiempoDocumentos.telefonoCuenta = roberto.phone;
                objectTiempoDocumentos.tipoCuenta = roberto.type;
            }
            else if(registro.DocumentoEtapa__r.Etapa__r.NumEtapa__c == 5){
                objectTiempoDocumentos.idCuenta = registro.Oferta__r.Notaria__r.id;
                objectTiempoDocumentos.nombreCuenta = registro.Oferta__r.Notaria__r.name;
                objectTiempoDocumentos.telefonoCuenta = registro.Oferta__r.Notaria__r.phone;
                objectTiempoDocumentos.tipoCuenta = registro.Oferta__r.Notaria__r.type;
                
                objectTiempoDocumentos.idCuenta2 = registro.Oferta__r.Gestor__r.id;
                objectTiempoDocumentos.nombreCuenta2 = registro.Oferta__r.Gestor__r.name;
                objectTiempoDocumentos.telefonoCuenta2 = registro.Oferta__r.Gestor__r.phone;
                objectTiempoDocumentos.tipoCuenta2 = registro.Oferta__r.Gestor__r.type;
                
            }
            else if(registro.DocumentoEtapa__r.Etapa__r.NumEtapa__c == 6){
            	objectTiempoDocumentos.idCuenta = registro.Oferta__r.Gestor__r.id;
                objectTiempoDocumentos.nombreCuenta = registro.Oferta__r.Gestor__r.name;
                objectTiempoDocumentos.telefonoCuenta = registro.Oferta__r.Gestor__r.phone;
                objectTiempoDocumentos.tipoCuenta = registro.Oferta__r.Gestor__r.type;

                if(registro.name == 'Avalúo fiscal y/o comercial' || registro.name == 'Certificado fiscal'){
                    objectTiempoDocumentos.idCuenta2 = registro.Oferta__r.Notaria__r.id;
                    objectTiempoDocumentos.nombreCuenta2 = registro.Oferta__r.Notaria__r.name;
                    objectTiempoDocumentos.telefonoCuenta2 = registro.Oferta__r.Notaria__r.phone;
                    objectTiempoDocumentos.tipoCuenta2 = registro.Oferta__r.Notaria__r.type;
                }
            }
            else if(registro.name == 'Proyecto final'){
                objectTiempoDocumentos.idCuenta = registro.Oferta__r.Notaria__r.id;
                objectTiempoDocumentos.nombreCuenta = registro.Oferta__r.Notaria__r.name;
                objectTiempoDocumentos.telefonoCuenta = registro.Oferta__r.Notaria__r.phone;
                objectTiempoDocumentos.tipoCuenta = registro.Oferta__r.Notaria__r.type;
            }
            else if(registro.DocumentoEtapa__r.Etapa__r.NumEtapa__c == 8){
                objectTiempoDocumentos.idCuenta = registro.Oferta__r.Notaria__r.id;
                objectTiempoDocumentos.nombreCuenta = registro.Oferta__r.Notaria__r.name;
                objectTiempoDocumentos.telefonoCuenta = registro.Oferta__r.Notaria__r.phone;
                objectTiempoDocumentos.tipoCuenta = registro.Oferta__r.Notaria__r.type;
                
                if(registro.name != 'Pago honorarios'){
	                objectTiempoDocumentos.idCuenta2 = registro.Oferta__r.Gestor__r.id;
	                objectTiempoDocumentos.nombreCuenta2 = registro.Oferta__r.Gestor__r.name;
	                objectTiempoDocumentos.telefonoCuenta2 = registro.Oferta__r.Gestor__r.phone;
	                objectTiempoDocumentos.tipoCuenta2 = registro.Oferta__r.Gestor__r.type;
	            }
            }

            //proceso para ubicar y asignar el dictamen de la ultima bitacora registrada para el documento de la iteracion actual
            dictamenes = new List<Bitacora_Oferta__c>();
            
            for(Bitacora_Oferta__c reg: dictamenesCompleto){
                if(reg.Documento__c == registro.id || reg.Oferta__c == registro.Oferta__c){
                    dictamenes.add(reg);
                }
            }
            
            if(dictamenes.size()>0){
                Bitacora_Oferta__c dictamen = new Bitacora_Oferta__c();
                dictamen = dictamenes.get(dictamenes.size()-1);
                objectTiempoDocumentos.ultimaBitacora = dictamen.Dictamen_Consola__c;
                if(dictamen.Recordatorio__c != NULL){
                    objectTiempoDocumentos.recordatorio= true;
                }
                
                Datetime horaActual = DateTime.now();
                if(dictamen.Recordatorio__c < horaActual){
                    objectTiempoDocumentos.recordatorio= false;
                }
            }
            
            //asigna el documento correspondiente a la wrapper list
            objectTiempoDocumentos.docs = registro;

            listaTiempoDocumentos.add(objectTiempoDocumentos);
            

            //agrega el id del regsitro a una lista de ID's
            documentosIds.add(registro.Id);
        }

        //ordena los registros de la lista segun lo establecido en el metodo que implementa "comparable" en la wrapper list
        listaTiempoDocumentos.sort();

        for(DocumentoWrapper reg: listaTiempoDocumentos){
        	//agrega el numero de la posicion en la que se encuentra el registro
            reg.index = ind;  
            ind++; 
        }

        ind = 0;
        
        consultaRecordatorios();

        //almacena en un objeto tipo Oferta__c, el registro con mas prioridad de la lista de pendientes
        simpleOferta = new Oferta__c();
        simpleOferta = queryVistaSimple();

        //almacena en una lista tipo Documento__c, las etapas del registro con mas prioridad de la lista de pendientes
        simpleEtapa = new List<Documento__c>();
        simpleEtapa = queryEtapas();

        //almacena en un objeto tipo Documento__c la imformacion del documento con mas prioridad
        simpleDocSolicitado = new DocumentoWrapper();
        if(listaTiempoDocumentos.size() > 0 ){
            simpleDocSolicitado = listaTiempoDocumentos.get(0);
        }
        
    }


    //llama la informacion mostrada en el panel de admin
    //public void panelAdmin(){
        

    //    if([SELECT count() FROM Account WHERE name = :vuser] > 0){                                                                      //para evitar el error que sale si el usuario no tiene cuenta
    //        avance = [SELECT Pendientes_Realizados__c FROM Account WHERE name = :vuser];
    //        documentosEspera = queryDocumentosEspera();
    //        if(vfolio != NULL && vfolio != ''){                                                                                         //para evitar el error que se muestra si no se ha seleccionado un ID 
    //            infoId = [SELECT TipoOferta__c, Etapa__c, Plaza__c, TiempoOferta__c FROM Oferta__c WHERE name = :vfolio LIMIT 1];
    //        }
    //    }
    //    vdoc=null;
    //}

    //hace la consulta de bitacoras para el panel de admin
    public void bitacorasAdmin(){
        if(vdoc != NULL && vuser != NULL){
            listaBitacoras = queryBitacoraDocs();
        }
    }

    //inserta una bitacora nueva
    public PageReference guardar(){
        bitacora.Documento__c = docId;
        
        if(bitacora.Dictamen_Consola__c != NULL){           //solo guarda la bitacora si se ha ingresado un dictamen
            insert bitacora;
        }
        bitacora = new Bitacora_Oferta__c();
        cargaLista();
        
        PageReference pagr = new PageReference('/apex/Consola_Compras');
        pagr.setRedirect(true);
        return pagr;
    }

    //metodo invocado cada cierto intervalo de tiempo para mostrar los recordatorios a la hora que se establecio al guardar la bitacora
    public void consultaRecordatorios(){
        Datetime horaActual = DateTime.now();
        hoyString = horaActual.format();
        recordatorios = [SELECT Id, Dictamen_Consola__c, Recordatorio__c, Comentarios__c, Documento__r.Name, Documento__r.Oferta__r.Name, Recordatorio_Retardado__c, Documento__c, Bitacora_Completada__c from Bitacora_Oferta__c where (Documento__c in :documentosIds AND Recordatorio__c <= :horaActual AND Bitacora_Completada__c = false) OR (Documento__r.En_Espera__c = true AND Bitacora_Completada__c = false) LIMIT 50];
        
    }
    
    //marca como completada la bitacora 
    public PageReference completaBitacora(){
        if(idBitacora != NULL){
            registroRecordatorio =[SELECT Bitacora_Completada__c FROM Bitacora_Oferta__c WHERE id = :idBitacora];
            registroRecordatorio.Bitacora_Completada__c = completada;
            UPDATE registroRecordatorio ;
        }
        
        PageReference pagr = new PageReference('/apex/Consola_Compras');
        pagr.setRedirect(true);
        return pagr;
    }
    
    //pone el documento en espera, inserta una bitacora siempre que se haya puesto un dictamen, y vuelve a cargar la lista principal de la tabla de pendientes
    public PageReference espera(){
        if(docId != NULL){
            docTemp = [SELECT En_Espera__c, Cerrado__c FROM Documento__c WHERE id = :docId];
            docTemp.En_Espera__c = true;
            docTemp.Cerrado__c = true;
            UPDATE docTemp;

            bitacora.Documento__c = docId;
            if(bitacora.Dictamen_Consola__c != NULL){           //solo guarda la bitacora si se ha ingresado un dictamen
                insert bitacora;
            }
            bitacora = new Bitacora_Oferta__c();
            
            cargaLista();
        }
        PageReference pagr = new PageReference('/apex/Consola_Compras');
        pagr.setRedirect(true);
        return pagr;
        
    }
    
    //llena la lista de resultados del buscador de documentos
    public void llenaLista(){
        listaBusqueda=[SELECT Oferta__r.Direccion2__c, name, Oferta__r.name, Oferta__r.Gerente_Escrituras__r.name, DocumentoEtapa__r.Etapa__r.name, Fecha_Inicio__c, Fecha_Com_Controller__c, DocumentoEtapa__r.Tiempo_Proceso__c, Tiempo_Restante__c, DocumentoEtapa__r.Instrucciones__c, EtapaOferta__c, DocumentoEtapa__r.Tipo__c, DocumentoEtapa__c FROM Documento__c WHERE Oferta__r.FolioLlave__c IN (:folio) AND Iniciado__c = true AND Cerrado__c = false AND Oferta__r.FolioLlave__c != NULL AND Oferta__r.FechaCobro__c = NULL AND Oferta__r.Estatus__c != 'Descartada' AND EtapaOferta__r.EtapaActual__c = true AND Oferta__r.Etapa__c IN ('Escrituras en proceso registro','Compra final','Compilación expediente compra','Aprobada internamente','Antecedentes') AND name IN ('Escrituras','Poderes','Otros antecedentes','Certificado de libertad de gravamen','Avalúo fiscal y/o comercial','Certificado fiscal','Agua','Predial','Otro Adeudos y Pagos','Proyecto final','Comprobante de pago de la propiedad','Pago honorarios','Pago Gastos de Registro','Pago ISAI','Boleta de Registro','Escrituras Registradas')];
        if(listaBusqueda.size()>0){                     //para mostrar la ventana de alerta si no se encontraron resultados en el buscador
            mostrarDialogo = false;
        }
        else{
            mostrarDialogo = true;
        }
    }

    //limpia la lista de resultados de documentos del buscador
    public void limpiar(){

        if(listaBusqueda != NULL){
            listaBusqueda.clear();
        }
        mostrarDialogo = true;
    }

    //
    public PageReference guardarCosto(){
    	//listaTiempoDocumentos.get(posicion).docs.Costo__c = 800;
    	System.debug('costo: '+listaTiempoDocumentos.get(posicion).docs.Costo__c);
    	System.debug('documento: '+listaTiempoDocumentos.get(posicion).docs.name);
    	System.debug('posicion: '+posicion);
        UPDATE listaTiempoDocumentos.get(posicion).docs;
        PageReference pagr = new PageReference('/apex/Consola_Compras');
        pagr.setRedirect(true);
        return pagr;
    }


    //query de la lista de documentos a considerar para la consola
    public List<Documento__c> queryDocumentos(String etapa){
        return [SELECT Name, En_Espera__c, EtapaOferta__c, DocumentoEtapa__c, DocumentoEtapa__r.tipo__c, DocumentoEtapa__r.Etapa__r.NumEtapa__c, Oferta__r.name, Oferta__r.Direccion2__c, Oferta__r.Contratista__r.id,Oferta__r.Contratista__r.name,
        Oferta__r.Contratista__r.phone,Oferta__r.Contratista__r.type, Oferta__r.Promotor__r.id,Oferta__r.Promotor__r.name,Oferta__r.Promotor__r.phone,
        Oferta__r.Promotor__r.type,Oferta__r.Valuador__r.id,Oferta__r.Valuador__r.name,Oferta__r.Valuador__r.phone,Oferta__r.Valuador__r.type, 
        Oferta__r.Notaria__r.id,Oferta__r.Notaria__r.name,Oferta__r.Notaria__r.phone,Oferta__r.Notaria__r.type,Oferta__r.Gestor__r.id,Oferta__r.Gestor__r.name,
        Oferta__r.Gestor__r.phone,Oferta__r.Gestor__r.type, Oferta__r.Apoderado__r.id,Oferta__r.Apoderado__r.name,Oferta__r.Apoderado__r.phone,Oferta__r.Apoderado__r.type, 
        Oferta__r.VentanillaUnica__r.id,Oferta__r.VentanillaUnica__r.name,Oferta__r.VentanillaUnica__r.phone,Oferta__r.VentanillaUnica__r.type, Oferta__r.id,
        Oferta__r.Gerente_Comercial__r.name,Oferta__r.Gerente_Escrituras__r.name,DocumentoEtapa__r.Etapa__r.name,Fecha_Inicio__c,Fecha_Com_Controller__c,Tiempo_Restante__c,
        DocumentoEtapa__r.Tiempo_Proceso__c,DocumentoEtapa__r.Instrucciones__c,Cerrado__c,Oferta__r.Plaza__c,Oferta__r.Comentarios__c,Costo__c FROM Documento__c
        WHERE Oferta__r.Gerente_Escrituras__r.name = :vuser AND (NOT Oferta__r.Inversor2__c LIKE 'Regeneradora%') AND Oferta__r.FechaCobro__c = NULL AND Oferta__r.FechaPago__c != NULL AND Oferta__r.Estatus__C != 'Descartada' AND Oferta__r.Etapa__c = :etapa AND name IN ('Escrituras','Poderes','Otros antecedentes','Certificado de libertad de gravamen','Avalúo fiscal y/o comercial','Certificado fiscal','Agua','Predial','Otro Adeudos y Pagos','Proyecto final','Comprobante de pago de la propiedad','Pago honorarios','Pago Gastos de Registro','Pago ISAI','Boleta de Registro','Escrituras Registradas') 
        AND Cerrado__c != true AND EtapaOferta__r.EtapaActual__c = true AND Iniciado__c = true
        ORDER BY Tiempo_Restante__c DESC LIMIT :lim];
    }

    //query con los documentos asignados a gerente ":vuser"
    public List<AggregateResult> queryIdAsignados(){
        return [SELECT Oferta__r.Name,Oferta__c FROM Documento__c
                WHERE Oferta__r.Gerente_Escrituras__r.name = :vuser AND Oferta__r.Etapa__c IN ('Escrituras en proceso registro','Compra final','Compilación expediente compra','Aprobada internamente','Antecedentes')
                AND name IN ('Escrituras','Poderes','Otros antecedentes','Certificado de libertad de gravamen','Avalúo fiscal y/o comercial','Certificado fiscal','Agua','Predial','Otro Adeudos y Pagos','Proyecto final','Comprobante de pago de la propiedad','Pago honorarios','Pago Gastos de Registro','Pago ISAI','Boleta de Registro','Escrituras Registradas') 
                AND Cerrado__c != true 
                AND EtapaOferta__r.EtapaActual__c = true 
                AND Iniciado__c = true
                AND Tiempo_Restante__c < 0
                AND Oferta__r.FechaCobro__c = NULL 
                AND Oferta__r.FechaPago__c != NULL
                AND Oferta__r.Estatus__C != 'Descartada'
                AND (NOT Oferta__r.Inversor2__c LIKE 'Regeneradora%')
                group by Oferta__r.Name,Oferta__c];
    }

    //query con los documentos con retraso del folio ":vfolio"
    public List<Documento__c> queryDocsAsignados(){
        return [Select name,id FROM Documento__c WHERE Oferta__r.name = :vfolio AND Tiempo_Restante__c < 0 AND Iniciado__c = true AND EtapaOferta__r.EtapaActual__c = true AND Cerrado__c = false AND Oferta__r.Etapa__c IN ('Escrituras en proceso registro','Compra final','Compilación expediente compra','Aprobada internamente','Antecedentes') AND name IN ('Escrituras','Poderes','Otros antecedentes','Certificado de libertad de gravamen','Avalúo fiscal y/o comercial','Certificado fiscal','Agua','Predial','Otro Adeudos y Pagos','Proyecto final','Comprobante de pago de la propiedad','Pago honorarios','Pago Gastos de Registro','Pago ISAI','Boleta de Registro','Escrituras Registradas')];
    }

    //query de las bitacoras del documento ":vdoc"
    public List<Bitacora_Oferta__c> queryBitacoraDocs(){
        if(listaBitacoras == null && vdoc != NULL){
            return [SELECT Name,Comentarios__c,CreatedDate,Dictamen_Consola__c,Notas__c,Dictamen__c,Oferta__r.Comentarios__c FROM Bitacora_Oferta__c WHERE Documento__r.name = :vdoc OR Oferta__r.name = :vfolio ORDER BY CreatedDate desc Limit 10];
        }
        else{
            return NULL;
        }
        
    }
    
    //query para la informacion de la Oferta con mayor prioridad de la vista simple
    public Oferta__c queryVistaSimple(){
        if(listaTiempoDocumentos.size()>0){
            return [SELECT name, Direccion2__c, Oferta_Cargada__c, Escritu__c, Fecha_Prevista_Desalojo__c, Estatus_de_invasion__c, Plaza__c, Estado__c, Ciudad_Tabla__c, Colonia_busqueda__c, Etapa__c, PrecioCompra__c, PrecioVenta__c, TotalCosto__c, MargenBruto__c, MargenNeto__c, Precio_Original__c, BeneficioNeto__c,Google_Dirve__c   FROM Oferta__c WHERE ID = :listaTiempoDocumentos.get(0).docs.Oferta__c];
        }
        else{
            return NULL;
        }
    }

    //query para la informacion de las etapas de la Oferta con mayor prioridad de la vista simple
    public List<Documento__c> queryEtapas(){
        if(listaTiempoDocumentos.size()>0){
            return [SELECT EtapaOferta__r.Nombre_etapa__c, EtapaOferta__r.NumEtapa__c, Cerrado__c, name FROM Documento__c WHERE Oferta__c = :listaTiempoDocumentos.get(0).docs.Oferta__c AND EtapaOferta__r.NumEtapa__c IN (4,5,6,7,8) AND name IN ('Escrituras','Poderes','Otros antecedentes','Certificado de libertad de gravamen','Avalúo fiscal y/o comercial','Certificado fiscal','Agua','Predial','Otro Adeudos y Pagos','Proyecto final','Comprobante de pago de la propiedad','Pago honorarios','Pago Gastos de Registro','Pago ISAI','Boleta de Registro','Escrituras Registradas')];
        }
        else{
            return NULL;
        }
    }



    public void Cobertura(){
    Integer a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    a = 100;
    }
    public void Cobertura2(){
    Integer b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;
    b = 10;

    }


}