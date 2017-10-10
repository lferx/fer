global class BatchConvertLeadToAccount implements Database.Batchable<sObject> {
    
    global final String Query;
     
    global BatchConvertLeadToAccount(String q){
        Query=q;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        
        //Previo
        //Convertimos el scope a una lista  de candidatos interesados.
        List<Candidato_Interesado__c> lstCandidatos = (List<Candidato_Interesado__c>) scope;
        
        /////////////////////////////////////////////////////////////////////////////////////
        
        //Parte I: Insercion de la cuenta:
        
        //Obtenermos el tipo de registro de cliente
        Id devRecordTypeIdCliente = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
        
        //Consultamos el perfil de Gerente de Ventas para que al consultar los usuarios solo se busquen los que coinsidan con este perfil
        Profile perfilGerenteVentas = [SELECT Id FROM Profile WHERE Name = 'Gerente de Ventas' LIMIT 1];
        
        //La siguiente lista tendra las cuentas que se insertaran a partir de los candidatos interesados
        List<Account> lstClientes = new List<Account>();
        
        //La siguiente variable contendra las plazas que tienen los candidatos
        String plazas = '';
        
        //EL siguiente set nos servira para identificar que plazas son las que usaremos 
        
        Set<String> setPlazas = new Set<String>();
        
        //Recorremos nuestra lista para crear una cuenta por cada candidato.
        for(Candidato_Interesado__c candidato:lstCandidatos){
            Account cliente = new Account();
            cliente.RecordTypeId = devRecordTypeIdCliente;
            cliente.Name = candidato.Lead__r.Name;
            cliente.BillingState = candidato.Lead__r.Street;
            cliente.BillingCity = candidato.Lead__r.City;
            cliente.Email__c = candidato.Lead__r.Email;
            cliente.Plaza__c = candidato.Lead__r.Plaza__c;
            cliente.Estatus__c ='Activo' ;
            cliente.Numero_de_Seguro_Social__c = candidato.Lead__r.NSS__c ;
            cliente.Actualizado__c = true;
            cliente.Precalificacion__c = candidato.Lead__r.Credito__c;
            cliente.Phone = candidato.Lead__r.Phone;
            cliente.Password__c = candidato.Lead__r.Password__c;
            cliente.AccountSource = candidato.Lead__r.LeadSource;
            cliente.Origen__c= candidato.Lead__r.LeadSource;
            lstClientes.add(cliente);
            
            setPlazas.add(candidato.Lead__r.Plaza__c);
            
            if(String.isEmpty(plazas)){
                plazas = candidato.Lead__r.Plaza__c+'\'';
            }else{
                if(!( plazas.indexOf(candidato.Lead__r.Plaza__c) >= 0 )){
                    plazas += ',\''+candidato.Lead__r.Plaza__c + '\'';
                }
            }
            
        }
        
        plazas = plazas.removeEnd('\'');
        
        system.debug('##### Las plazas son :'+ plazas);
        
        System.debug('##### Query gerente:  SELECT Id,Plaza__c FROM User WHERE ProfileId = \''+perfilGerenteVentas.Id+'\' AND Plaza__c INCLUDES(\''+plazas+'\') AND User.IsActive = true ');
        
        //consultamos los usuarios gerentes que pertenescan a las plazas que seteamos.
        
        List<User> lstUserGerente = (List<User>)Database.query('SELECT Id,Plaza__c FROM User WHERE ProfileId = \''+perfilGerenteVentas.Id+'\' AND Plaza__c INCLUDES(\''+plazas+'\') AND User.IsActive = true');
        
        System.debug('##### lstUserGerente: '+ lstUserGerente);
        
        //Recorremos las cuentas que ya habiamos creado para asignar los gerentes
        for( Account cliente:lstClientes  ){
            for(User userGerente:lstUserGerente){
                String plazaGerente = userGerente.Plaza__c;
                if( plazaGerente.indexOf( cliente.Plaza__c ) >= 0 ){
                    cliente.OwnerId = userGerente.Id;
                }
            }
        }
        
        
        ////Parte I.I: Ligar promotores.
        
        ////Obtenemos el tipo de registro de promotor.
        
        Id devRecordTypeIdPromotor = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Promotor').getRecordTypeId();
        
        
        ////Seleccionamos los promotores de las plazas
        Map<Id,Account> mapPromotor = new Map<Id,Account>([SELECT Id,Plaza__c,Name FROM Account WHERE Plaza__c IN:setPlazas AND RecordTypeId =: devRecordTypeIdPromotor AND Estatus__c ='Activo' ]);
         
        ////Mapa balanceador de asignaciones  
        Map<Id,Integer> mapBalanceador= new Map<Id,Integer>();
        
        ////mapa de promotores por plaza
        Map<String,List<Account>> mapPromotorPlaza= new Map<String,List<Account>>();
        
        
        ////Rellenamos nuestro mapa
        for( Account promotor:mapPromotor.values() ){
            
            mapBalanceador.put( promotor.Id, 0 );
            
            if( !mapPromotorPlaza.containsKey( promotor.Plaza__c ) ){
                List<Account> lstPromotorAux = new List<Account>();
                lstPromotorAux.add( promotor );
                mapPromotorPlaza.put( promotor.Plaza__c,lstPromotorAux );
            }else{
                List<Account> lstPromotorAux = mapPromotorPlaza.get( promotor.Plaza__c );
                lstPromotorAux.add( promotor );
                mapPromotorPlaza.put( promotor.Plaza__c,lstPromotorAux );
            }
            
        }
        
        ////Buscamos las asignaciones de los promoteres para balancear la carga
        List<Account> lstAccAux = [SELECT Id, Plaza__c,Name,Promotor__c FROM Account WHERE Promotor__c IN: mapPromotor.keySet() ];
        
        ////Asignaciones 
        for( Account clienteAux:lstAccAux ){
            if( mapBalanceador.containsKey( clienteAux.Promotor__c ) ){
                Integer contador = mapBalanceador.get( clienteAux.Promotor__c );
                contador++;
                mapBalanceador.put( clienteAux.Promotor__c,contador );
            }
        }
        
        for( Account cliente: lstClientes ){
            
            if(mapPromotorPlaza.containsKey(cliente.Plaza__c)){
                List< Account > lstPromotor = mapPromotorPlaza.get( cliente.Plaza__c );
                
                system.debug('##### Mapa balanceado de promotores: '+ mapBalanceador);
                
                Integer valorMinimo = calcularMenor( mapBalanceador.values());
                
                system.debug('##### El valor minimo es: '+ valorMinimo);
                
                for( Account promotor:lstPromotor ){
                    
                    system.debug('##### El promotor a evaluar es: '+ promotor.Name +' y tiene: '+mapBalanceador.get( promotor.Id ));
                    
                    if( mapBalanceador.containsKey( promotor.Id ) ){
                        if( mapBalanceador.get( promotor.Id ) <= valorMinimo ){
                            system.debug('##### El promotor tiene el valor minimo aqui se realiza el brake '); 
                            mapBalanceador.put( promotor.Id,valorMinimo+1);
                            cliente.Promotor__c = promotor.Id;
                            break;                      
                        }
                    }
                }
            }
            
            
        }
         
        //Insertamos los clientes
        insert lstClientes;
        
        // Este mapa servira para saber a que cuenta pertenece que contacto
        Map<String,Account> mapClientes = new Map<String,Account>();
                
        for(Account cliente:lstClientes){
            mapClientes.put( cliente.Numero_de_Seguro_Social__c,cliente );
        }
        
        
        
        
        ///////////////////////////////////////////////////////////////////////////////////////
        
        
        
        //Parte II: Creacion de los contactos:
        
        //Esta sera la lista de contactos que se inserten
        List<Contact> lstContactos = new  List<Contact>();
        
        
        // Recorremos los leads para saber los contactos que vamos a insertar
        for(Candidato_Interesado__c candidato:lstCandidatos){           
            Contact contacto = new Contact();
            contacto.FirstName = candidato.lead__r.FirstName ;
            contacto.LastName = candidato.lead__r.LastName ;
            contacto.Email = candidato.lead__r.Email ;
            contacto.Tipo__c = 'Publico';
            contacto.Plaza__c = candidato.lead__r.Plaza__c;
            contacto.AccountId = mapClientes.get( candidato.lead__r.NSS__c ).Id;
            contacto.Phone = candidato.lead__r.Phone;
            contacto.MailingStreet = candidato.lead__r.Street;
            contacto.MailingCity = candidato.lead__r.City;
            contacto.NSS__c = candidato.lead__r.NSS__c;
            lstContactos.add(contacto);
        }
        
        insert lstContactos;
        
        //El siguiente mapa sirve para saber que contacto le corresponde a que NSS
        Map<String,Contact> mapContactos = new Map<String,Contact>();
        
        //Lenamos el mapa
        for( Contact contacto:lstContactos ){
            mapContactos.put( contacto.NSS__c, contacto );
        }
        
        system.debug('###### mapContactos: '+mapContactos);
        
        ///////////////////////////////////////////////////////////////////////////////////////
        
        //Parte III: Creacion de las actividades:
        
        List<Task> lstLLamadas = new List<Task>();
        
        for( Account cliente: lstClientes ){
            Task llamada = new Task();
            llamada.Priority = 'Alta';
            llamada.OwnerId = cliente.OwnerId;
            llamada.Subject = 'Llamada';
            llamada.WhatId = cliente.Id;
            lstLLamadas.add(llamada);
        }
        
        insert lstLLamadas;
        
        ////////////////////////////////////////////////////////////////////////////////////////
        
        //Parte IV: Creacion de los Clientes por oferta
        
        //La siguiente es la lista de clientes por ofertas que se insertara
        List<ClienteOferta__c> lstClienteOferta = new List<ClienteOferta__c> ();
        
        //Por cada propiedad que tenga el ligada el lead el objeto intermedio ofertas x lead se realizara una insercion de cliente oferta
        //El siguiente conjunto tendra los Ids de los leads que vamos a revisar
        Set<Id> setLeadsIds = new Set<Id>();
        
        // Recorremos el arreglo del scope para obtener los Ids de los candidatos que vamos a insertar.
        for( Candidato_Interesado__c candidato:lstCandidatos ){
            setLeadsIds.add(  candidato.Lead__c  ); 
        }
        
        //Ya con este conjunto de ids tenemos que consultar el objeto de leads por oferta para tener entendido cuantas ofertas vamos a insertar
        List<Ofertas_por_lead__c> lstOfertasLeads = [SELECT Id, Propiedad__c,Propiedad__r.Oferta__c,Lead__c,Lead__r.NSS__c FROM Ofertas_por_lead__c WHERE Lead__c IN :setLeadsIds];
        
        //Con esta lista tenemos que construir un mapa el cual nos pueda dar las propiedades del lead mediante su numero de seguro social (NSS)
        
        //instanciamos el mapa que vamos a necesitar, este mapa es un mapa de listas por aquello de que un lead puede tener vrias propiedades
        Map<String,List<Ofertas_por_lead__c>> mapNssPropiedad = new Map<String,List<Ofertas_por_lead__c>>();
                
        //Recorremos lista de ofertas por lead para llenar el mapa de listas
        for( Ofertas_por_lead__c ofertaLead: lstOfertasLeads ){
            
            //Encaso de que ya se tenga una llave con el NSS lo que se hace es agregar un item mas a la lista
            if(mapNssPropiedad.containsKey(ofertaLead.Lead__r.NSS__c)){
                
                List<Ofertas_por_lead__c> lstOPLAux = mapNssPropiedad.get(ofertaLead.Lead__r.NSS__c);
                lstOPLAux.add( ofertaLead );
                mapNssPropiedad.put(ofertaLead.Lead__r.NSS__c,lstOPLAux );
                
            }else{
                
                //En caso de que no se tenga la llave lo que se hace es que se crea la lista y se inserta en el mapa bajo esa llave.
                List<Ofertas_por_lead__c> lstOPLAux = new List<Ofertas_por_lead__c>();
                lstOPLAux.add( ofertaLead );
                mapNssPropiedad.put(ofertaLead.Lead__r.NSS__c,lstOPLAux );
                
            }
            
        }
        
        // Ya con nuestro mapa lleno lo que resta es recorrer su contenido para crear los registros de cliente oferta
        for( List<Ofertas_por_lead__c> lstOfertaLead: mapNssPropiedad.values() ){
            for(Ofertas_por_lead__c ofertaLead:lstOfertaLead){
                
                ClienteOferta__c clienteOferta = new ClienteOferta__c();
                clienteOferta.Cuenta__c = mapClientes.get( ofertaLead.Lead__r.NSS__c ).Id;
                clienteOferta.Oferta__c = ofertaLead.Propiedad__r.Oferta__c;
                clienteOferta.Estatus__c = 'Participante';
                clienteOferta.Contacto__c = mapContactos.get( ofertaLead.Lead__r.NSS__c ).Id;
                lstClienteOferta.add( clienteOferta );
            }
        }
        
        //Insertamos los registros de cliente oferta.
        insert lstClienteOferta;
        
        
        ///////////////////////////////////////////////////////////////////////////////////////
        
        //Parte V: Eliminacion de leads:        
        List<Lead> lstLeads = [SELECT Id FROM Lead WHERE Id IN:setLeadsIds];
        
        delete lstCandidatos;
        delete lstLeads;
        
        
        
    }
    
    global void finish(Database.BatchableContext BC){}
    
    public Integer calcularMenor( List<Integer> arreglo ){
        Integer resultado = (arreglo != null && arreglo.size() != null && arreglo.size() > 0 )?arreglo[0]:0;
        for(Integer i=0; i<arreglo.size(); i++){
            if(arreglo[i] < resultado){
                resultado = arreglo[i];
            }
        }
        return resultado;
    } 

}