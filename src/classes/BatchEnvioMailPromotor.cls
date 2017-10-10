global class BatchEnvioMailPromotor implements Database.Batchable<sObject> {
    
    global final String Query;

    global BatchEnvioMailPromotor(String q){
        Query=q;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        
        ///////////////////////////////////////////////////////////////////////////////
        // Fase uno preparacion de los datos que se enviaran en el correo electronico
        ///////////////////////////////////////////////////////////////////////////////
        
        //Transformamos el scope para que sea un tipo de lista de cuentas y de esta manera su procesamiento sea mas sencillo
        List<Account> lstClientes = (List<Account>)scope;
        
        //Necesitaremos a veriguar que promotores son los que estan asiganados a cada cliente ya que a ellos se les enviara el correo elentronico
        Set<Id> setPromotoresIds = new Set<Id>();
        
        //Este conjunto de ids nos servira para consultar los clienteoferta que esta ligados a cada cliente
        Set<Id> setClientesIds = new Set<Id>();
        
        //La siguiente lista en la que guardaremos los items que representaran los correos electronicos que se enviaran a los promotores.
        List<WrapperCliente> lstWrapperCliente = new List<WrapperCliente>();
        
        //A continuacion se rrecorre el scope con la intencion de alimentar los conjuntos antes mecionados y marcar a los clientes para que ya no se les vuelva enviar el correo a los promotores.
        for( Account cliente:lstClientes ){
            
            //Con este conjunto lleno buscaremos las ofertas que pertenescan a los clientes que vienen en el scope
            setClientesIds.add( cliente.Id );
            
            //Con esto obtendremos los datos que necesitamos de los promotores
            setPromotoresIds.add( cliente.Promotor__c );
            
            //Marcado para que el correo no se reenvie
            cliente.Notificado_al_promotor__c = true;
            
        }       
        
        //Ya con el conjunto lleno consultamos los datos de los promotores a los que les llegara el correo mediante el conjunto previamente llenado
        Map<Id,Account> mapPromotores = new Map<Id,Account>([SELECT Id,Name,Email__c FROM Account WHERE Id IN:setPromotoresIds AND Estatus__c ='Activo' AND Type = 'Promotor']);
                
        //Con el conjunto de ids de los clientes lo que hacemos es que traemos las ofertas que pertenecen a ellos
        List<ClienteOferta__c> lstClienteOferta = [SELECT Id, Name,Oferta__r.Propiedad__r.Calle__c,Cuenta__r.BillingStreet,Cuenta__r.Precalificacion__c,Oferta__r.PrecioVenta__c, Oferta__r.Propiedad__r.Name FROM ClienteOferta__c WHERE Cuenta__c IN:setClientesIds];
                
        
        //Lo que sige es recorrer el escope de clientes para generar los registros del WrapperCliente y almacenarlos en una lista
        for(Account cliente :lstClientes){
            
            //Debemos identificar si el cliente que se esta por evaluar tiene un promotor asignado
            if(cliente.Promotor__c != null){
                //Primero instanciamos un item del Wrapper de clientes.
                WrapperCliente wrCliente = new WrapperCliente();
                
                //A continuacion se asigna el cliente al item.
                wrCliente.cliente = cliente ;
                
                //La siguinete lista almacenara los items que representan las ofertas que los clientes tiene a su dispocision.
                List<ClienteOferta__c> lstClienteOfertaAux = new List<ClienteOferta__c>();
                
                //Para llenar esa lista lo que se debe de hacer es recorrer la lista de tipo ClienteOferta__c que previamente hemos consultado
                for( ClienteOferta__c clienteOferta :lstClienteOferta ){ 
                    
                    //Si la cuenta ligada al registro de ClienteOferta__c conicide con el Id del cliente se almacena en una lista auxiliar
                    if( clienteOferta.Cuenta__c == cliente.Id ){
                        lstClienteOfertaAux.add( clienteOferta );
                    }
                }
                
                // Una vez que tenemos la lista llena lo almacenamos en el wrapper
                wrCliente.lstClienteOferta =lstClienteOfertaAux ;
                
                //Acontinuacion asignamos al promotor al wrapper
                if(mapPromotores.containsKey( cliente.Promotor__c )){
                    wrCliente.promotor = mapPromotores.get( cliente.Promotor__c );
                }
                
                //Por ultimo metemos este item a la lista de WrapperCliente
                lstWrapperCliente.add( wrCliente ); 
            }
        }
        
        ///////////////////////////////////////////////////////////////////////////////
        // Fase dos composicion del correo electronico
        /////////////////////////////////////////////////////////////////////////////// 
        
        // La siguiente lista contendra los mensajes de correo electronico que se estaran enviando a los diferentes promotores
        List<Messaging.SingleEmailMessage> lstEmailMsj = new List<Messaging.SingleEmailMessage>();      
        
        
        //Acontinuacion recorremos la lista del WrapperCliente para formar el cuerpo del correo electronico
        for(WrapperCliente wcliente:lstWrapperCliente){
            
            //Esta variable de tipo string contiene la lista de ofertas que le correscompden al cliente
            String hmtlOfertaCliente='';
            
            //LLenamos el string con las ofertas del cliente
            for(ClienteOferta__c oferta:wcliente.lstClienteOferta){
                hmtlOfertaCliente+=
                
                    '<tr>'
                        +'<td style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #ffffff;" >'+oferta.Oferta__r.Propiedad__r.Name+'</td>'
                        +'<td style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #ffffff;">'+oferta.Oferta__r.Propiedad__r.Calle__c+'</td>'
                        +'<td style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #ffffff;">'+oferta.Cuenta__r.Precalificacion__c+'</td>'
                        +'<td style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #ffffff;">'+oferta.Oferta__r.PrecioVenta__c+'</td>' 
                        +'<td style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #ffffff;"></td>'
                    +'</tr>';
            }
            
            //Esta variable de tipo string contendar el cuerpo del correo
            String htmlBodyMail = 
            
                '<html>'
                    +'<body>'
                        +'<div>'
                            +'<img src="https://c.na25.content.force.com/servlet/servlet.ImageServer?id=01531000007LGu5&oid=00Di0000000Xp9m"/></br>'
                            +'<p style="font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;">Estimado(a): '+wcliente.promotor.Name+'.<br/> Se le ha asignado un nuevo prospecto.</p>'
                            
                            +'<p style="font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;">'
                                +'<b>Nombre:</b> '+ wcliente.cliente.Name +'.<br/>'
                                +'<b>Precalificacion:</b> '+ wcliente.cliente.Precalificacion__c +'.<br/>'
                                +'<b>Telefono:</b> '+ wcliente.cliente.Phone +'.<br/>'
                                +'<b>Correo electronico:</b> '+ wcliente.cliente.Email__c +'.'
                            +'</p>'
                            +'<p style="font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;"> Al interesado se le envio la siguiente información y mostró mucho interes, <br /> Por favor procede a contactar al prospecto urgentemente.</p>'
                            +'<table style="font-family: verdana,arial,sans-serif;font-size:11px;color:#333333;border-width: 1px;border-color: #666666;border-collapse: collapse;margin-top: 1em;margin-bottom: 1em;width: 100%;">'
                                +'<tr>'
                                    +'<th style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #dedede;">Folio</th>'
                                    +'<th style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #dedede;">Direccion</th>'
                                    +'<th style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #dedede;">Precalificacion</th>'
                                    +'<th style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #dedede;">Precio</th>'
                                +'</tr>'
                                +hmtlOfertaCliente
                            +'</table>'
                            
                        +'</div>'
                    +'</body>'
                +'<html>';
            
            try{
                //Instanciamos el la clase SingleEmailMessage para enviar el mensaje
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                
                //No se usara firma 
                mail.setUseSignature(false);
                
                //Asignar el email del destinario
                mail.setToAddresses(new String[] { wcliente.promotor.Email__c });
                
                //Este es el asunto del correo
                mail.setSubject('Asignacion de cliente nuevo');
                
                //El cuerpo del correo
                mail.setHtmlBody( htmlBodyMail );
                
                //Añadimos el mail a la lista que se enviara
                lstEmailMsj.add( mail );
            }catch(Exception e){
                system.debug('##### Se genero la siguiente Excepcion al formar el cuerpo del correo: '+e.getMessage());
            }
        }   
        
        if( !lstEmailMsj.isEmpty()){
        	if(!Test.isRunningTest()){
        		Messaging.sendEmail( lstEmailMsj );
        	}
            update lstClientes;
        }   
    }
    
    global void finish(Database.BatchableContext BC){}
    
    
    
    class WrapperCliente{
        public Account promotor{get;set;}
        public Account cliente{get;set;}
        public List<ClienteOferta__c> lstClienteOferta{get;set;}
    }

}