public with sharing class Menu_rapidoLead_Controller {

    public Task nuevaTarea {get;set;}
    public Task viejaTarea {get;set;}
    public String idCuenta {get;set;}
    public Account nuevoLead {get;set;}
    public Id idRegistro {get;set;}
    //public Estado_Menu_Rapido__c estadoMenuRapido {get;set;}
    public Account creaReferido {get;set;}
    public String mensaje {get;set;}
    public String actual {get;set;}
    public Id idTarea {get;set;}
    public List<String> listDescrip {get;set;}
    public Boolean bandera {get;set;}
    public String hrs {get;set;}
    public String min {get;set;}
    public account presupuesto{get;set;}  
    public double presupuestoLead {get;set;}  

    public Account identificador {get;set;}
    public Boolean esCuentaPersonal {get;set;}

    public Menu_rapidoLead_Controller(){
        viejaTarea = new Task();
    	nuevaTarea = new Task();
    	nuevaTarea.Description = '';
        idTarea = ApexPages.currentPage().getParameters().get('idTask');

        if(idTarea != NULL){
        	for(Task tempTask: [SELECT Subject,Comentarios__c,ActivityDate,Sigue_interesado__c,Description,WhatID FROM Task WHERE ID = :idTarea LIMIT 1]){
        		viejaTarea = tempTask;

        		//listDescrip = nuevaTarea.Description.split('\\Q|\\E');
        		//nuevaTarea.Description = listDescrip.get(0);
        	}
        }

        System.debug('idTarea: '+idTarea);
        mensaje = '';
        creaReferido = new Account();
        nuevoLead = new Account();
        
        if(idCuenta != NULL && idCuenta != ''){
            nuevoLead = [SELECT ID FROM Account WHERE ID = :idCuenta.trim()];
            Id idRegistro = nuevoLead.id;
        }
        else{
            idRegistro = ApexPages.currentPage().getParameters().get('id');
            if(idRegistro == NULL){
                idRegistro = ApexPages.currentPage().getParameters().get('idaccount');
            }
        }

        if(idRegistro != NULL){
            identificador = [SELECT IsPersonAccount FROM Account WHERE id = :idRegistro];
            esCuentaPersonal = identificador.IsPersonAccount;
        }
        else{
            esCuentaPersonal = true;
        }

        bandera = false;
        //inicializarEstadoMenuRapido();
        if (idRegistro!=null){
            presupuesto=[select Precalificacion__c, Forma_de_Pago__c, Total_credito_contado__c from account where id=:idRegistro];
            if (presupuesto.forma_de_pago__c=='Credito_Contado'&&presupuesto.Total_credito_contado__c!=null){
                presupuestoLead=presupuesto.Total_credito_contado__c;
            }
            else{
                presupuestoLead=presupuesto.precalificacion__c;
            }
        }
    }

       

    /*public PageReference inicializarEstadoMenuRapido() {

        Id idCuenta = ApexPages.currentPage().getParameters().get('id');
        if (idCuenta != null) {
                estadoMenuRapido = UtilidadMenuRapido.obtenerEstado(idCuenta);
        } else {
                estadoMenuRapido = UtilidadMenuRapido.crearEstado();
        }




        return null;
    }*/

    public List<SelectOption> getHoras(){

        List<SelectOption> horas = new List<SelectOption>();

        horas.add(new SelectOption('--','--'));
        for(Integer i=0;i<24;i++){
            horas.add(new SelectOption(String.valueOf(i),String.valueOf(i)));
        }
        return horas;
    }  

    public List<SelectOption> getMinutos(){

        List<SelectOption> minutos = new List<SelectOption>();

        minutos.add(new SelectOption('--','--'));
        minutos.add(new SelectOption('00','00'));
        minutos.add(new SelectOption('05','05'));
        for(Integer i=10;i<60;i+=5){
            minutos.add(new SelectOption(String.valueOf(i),String.valueOf(i)));
        }
        return minutos;
    }  


    public PageReference datoslead() {
        PageReference datoslead = new PageReference('/apex/CreacionCuentaTipoLead');
        datoslead.setRedirect(false);
        if (idRegistro != null) {
            datoslead.getParameters().put('id', idRegistro);            

        }
        return datoslead;
    }



    public PageReference precalificacion() {
        PageReference precalificacion = new PageReference('/apex/Precalificacion_FormaPago');
        precalificacion.setRedirect(false);
        if (idRegistro != null) {
            precalificacion.getParameters().put('id', idRegistro);            

        }
        return precalificacion;
    }



    public PageReference stock() {
        PageReference stock = Page.ConsolaComercial;
        stock.setRedirect(false);
        if (idRegistro != null) {
            stock.getParameters().put('id', idRegistro);            
        }
        return stock;
    }



    public PageReference envioficha() {
        PageReference envioficha = new PageReference('/apex/Envio_de_la_ficha');
        envioficha.setRedirect(false);
        if (idRegistro != null) {
            envioficha.getParameters().put('id', idRegistro);            
        }
        return envioficha;
    }



    public PageReference citalead() {
        PageReference citalead = Page.Cita_Leads;
        citalead.setRedirect(false);
        if (idRegistro != null) {
                citalead.getParameters().put('id', idRegistro);                
        }
        return citalead;
    }



    public PageReference autorizacion() {
        PageReference autorizacion = Page.AutorizacionLead;
        if (idRegistro != null) {
            autorizacion.getParameters().put('idaccount', idRegistro);            
        }
        return autorizacion;
    }

    public PageReference guardarTarea() {
        System.debug(idRegistro);
        Account cuenta = new Account();
        if(idRegistro != NULL && nuevaTarea.Comentarios__c != NULL){

            //Asigna al dueño de la tarea
            nuevaTarea.WhatID = idRegistro;                                             

            if(nuevaTarea.Comentarios__c != 'Volver a Llamar'){
                //Si el dicatmen es diferente de volver a llamar se asignan hora de vencimiento, descripcion y se guarda la tarea
                nuevaTarea.Hora_de_vencimiento__c = hrs+':'+min;
                nuevaTarea.Description += '|'+actual+'|'+idRegistro;
                UPSERT nuevaTarea;
                System.debug('viejatarea: '+viejaTarea);
                if(viejaTarea.id != NULL){
                    //Cierra la tarea anterior en caso de haber una (cuando se abre el lead desde la consola de tareas)
                    viejaTarea.Status = 'Completada';
                    UPDATE viejaTarea;
                    viejaTarea = new Task();
                }

                //Empieza marca como visto la cuenta del lead
                cuenta = [SELECT visto__c FROM Account WHERE id = :idRegistro];
                cuenta.visto__c = true;
                UPDATE cuenta;
                //Termina marca como visto la cuenta del lead
                //Empieza regreso a la pagina inicial y limpiar los datos
                PageReference datosIniciales = Page.CreacionCuentaTipoLead;
                datosIniciales.setRedirect(true);
                nuevaTarea = new Task();
                bandera =true;
                return datosIniciales;
                //Empieza regreso a la pagina inicial y limpiar los datos
            }
            else if(nuevaTarea.Comentarios__c == 'Volver a Llamar' && hrs != '--' && min != '--' && nuevaTarea.ActivityDate != NULL){
                //Si el dicatmen es igual a volver a llamar y se selecciono fecha y hora, se asignan hora de vencimiento, descripcion y se guarda la tarea
                nuevaTarea.Hora_de_vencimiento__c = hrs+':'+min;
                nuevaTarea.Description += '|'+actual+'|'+idRegistro;
                UPSERT nuevaTarea;
                System.debug('viejatarea: '+viejaTarea);
                if(viejaTarea.id != NULL){
                    //Cierra la tarea anterior en caso de haber una (cuando se abre el lead desde la consola de tareas)
                    viejaTarea.Status = 'Completada';
                    UPDATE viejaTarea;
                    viejaTarea = new Task();
                }

                //Empieza marca como visto la cuenta del lead
                cuenta = [SELECT visto__c FROM Account WHERE id = :idRegistro];
                cuenta.visto__c = true;
                UPDATE cuenta;
                //Termina marca como visto la cuenta del lead
                //Empieza regreso a la pagina inicial y limpiar los datos
                PageReference datosIniciales = Page.CreacionCuentaTipoLead;
                datosIniciales.setRedirect(true);
                nuevaTarea = new Task();
                bandera =true;
                return datosIniciales;
                //Empieza regreso a la pagina inicial y limpiar los datos
            }
            else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, mensaje +='No se ha generado la actividad <br> -Debe seleccionar Fecha y Hora de Vencimiento.<br>'));
                mensaje = '';
                return null;
            }
        }
        else 
        {
            //Error si no se selecciono un dictamen
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, mensaje +='No se ha podido crear la Actividad <br> -No se ha seleccionado un dicatmen para la actividad.<br>'));
            mensaje = '';
            return null;
        }
    }

    public void guardaClienteReferido(){
     
        RecordType tipoReg = [SELECT Id FROM RecordType where name = 'Lead Cliente' limit 1];
        
        if(creaReferido.firstname != NULL && creaReferido.lastname !=NULL && creaReferido.phone !=NULL){
            if([SELECT count() FROM Account WHERE phone = :creaReferido.phone AND type = 'Lead Cliente'] >= 1){
                Account match = [SELECT firstname, lastname, phone FROM Account WHERE phone = :creaReferido.phone AND type = 'Lead Cliente' limit 1];
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, mensaje +='No se ha podido generar un referido <br> -Ya existe un lead con el telefono ingresado.<br>'+match.firstname+' '+match.lastname+'<br>'+match.phone+'<br>'));
                mensaje = '';
            }
            else{
                creaReferido.RecordTypeId = tipoReg.id;
                creaReferido.SubOrigen__c = 'Recomendado';
                Account recomendador = [SELECT firstname, lastname, Origen__c FROM Account WHERE id  = :idRegistro LIMIT 1];
                creaReferido.Origen__c = recomendador.Origen__c;
                creaReferido.Recomendado_por__c = recomendador.firstname+' '+recomendador.lastname;
                INSERT creaReferido ;
                Task tareaReferido = new Task();
                tareaReferido.WhatId = creaReferido.id;
                tareaReferido.Subject = 'Llamada';
                tareaReferido.Description = 'Lead recomendado por '+recomendador.firstname+' '+recomendador.lastname+', llamar para dar seguimiento.|CreacionCuentaTipoLead|'+creaReferido.id;
                tareaReferido.Comentarios__c = 'Volver a Llamar';
                tareaReferido.Sigue_interesado__c = 'Si';
                tareaReferido.ActivityDate = Date.today();
                tareaReferido.Hora_de_vencimiento__c = hrs+':'+min;
                INSERT tareaReferido;
                creaReferido.Visto__c = false;
                UPDATE creaReferido;
                Utilities.ligarMatriz(creaReferido.id,NULL);
                creaReferido = new Account();
            }
        }
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, mensaje +='No se ha podido generar un referido <br> -Debe proporcionar nombre, apellido y telefono.<br>'));
            mensaje = '';
        }
    }

    public PageReference guardarTodo(){
        guardaClienteReferido();
        guardarTarea();
        if(bandera){
        	PageReference datosIniciales = Page.CreacionCuentaTipoLead;
	        datosIniciales.setRedirect(true);
	        bandera =false;
	        return datosIniciales;
        }
        else{
        	return NULL;
        }
        
    }

}