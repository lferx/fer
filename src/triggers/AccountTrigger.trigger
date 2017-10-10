trigger AccountTrigger on Account (after update, after insert) {
    
    if( Trigger.isAfter && Trigger.isUpdate ){
        Account[] Nuevas = Trigger.new;
        List<Account> lstLeads = new List<Account>();   
        system.debug('Funciona1');
        for (Account preca :Nuevas){
            if (preca.Transforma_en_cliente__c == true ) {                            
                Account Cuenta = new Account();
                system.debug('Funciona2');
                Cuenta.Actualizado__c=preca.Actualizado__c;
                Cuenta.Alias__c=preca.Alias__c;
                Cuenta.Aprobado__c=preca.Aprobado__c;
                Cuenta.Banco__c=preca.Banco__c;
                Cuenta.Beneficiario__c=preca.Beneficiario__c;
                Cuenta.Cita__c=preca.Cita__c;
                Cuenta.CLABE__c=preca.CLABE__c;
                Cuenta.CodigoBanco__c=preca.CodigoBanco__c;
                Cuenta.Contactado__c=preca.Contactado__c;
                Cuenta.Contacto__c=preca.Contacto__c;
                Cuenta.CorreosAdicionales__c=preca.CorreosAdicionales__c;
                Cuenta.Description=preca.Description;
                Cuenta.Doc_ActaConstitutiva__c=preca.Doc_ActaConstitutiva__c;
                Cuenta.Doc_CedulaRFC__c=preca.Doc_CedulaRFC__c;
                Cuenta.Doc_ComprobanteDomicilio__c=preca.Doc_ComprobanteDomicilio__c;
                Cuenta.Doc_ComprobanteFiscal__c=preca.Doc_ComprobanteFiscal__c;
                Cuenta.Doc_IFE__c=preca.Doc_IFE__c;
                Cuenta.Type = 'Cliente';
                Cuenta.Email__c=preca.Email__c;
                Cuenta.Estado__c=preca.Estado__c;
                Cuenta.Estatus__c=preca.Estatus__c;
                Cuenta.LeadOrigen__c=preca.id;
                Cuenta.Fax=preca.Fax;
                Cuenta.Fecha_de_Cita__c=preca.Fecha_de_Cita__c;
                Cuenta.Gerente_Notificado__c=preca.Gerente_Notificado__c;
                Cuenta.LeadOrigen__c=preca.id;
                Cuenta.Industry=preca.Industry;
                Cuenta.Name=preca.Name;
                Cuenta.Nivel_de_Inter_s__c=preca.Nivel_de_Inter_s__c;
                Cuenta.NotarioTitular__c=preca.NotarioTitular__c;
                Cuenta.Notas_del_Promotor__c=preca.Notas_del_Promotor__c;
                Cuenta.Notificado_al_promotor__c=preca.Notificado_al_promotor__c;
                Cuenta.NumberOfEmployees=preca.NumberOfEmployees;
                Cuenta.NumeroNotaria__c=preca.NumeroNotaria__c;
                Cuenta.Numero_de_Seguro_Social__c=preca.Numero_de_Seguro_Social__c;
                Cuenta.Oferta__c=preca.Oferta__c;
                Cuenta.Origen__c=preca.Origen__c;
                Cuenta.OwnerId=preca.OwnerId;
                Cuenta.ParentId=preca.ParentId;
                Cuenta.Partcipa_en_sorteo__c=preca.Partcipa_en_sorteo__c;
                Cuenta.Password__c=preca.Password__c;
                Cuenta.Phone=preca.Phone;
                Cuenta.Plaza__c=Cuenta.Plaza__c;
                Cuenta.Precalificacion__c=preca.Precalificacion__c;
                Cuenta.Promotor__c=preca.Promotor__c;
                Cuenta.Referencia__c=preca.Referencia__c;
                Cuenta.Registrado__c=preca.Registrado__c;
                Cuenta.SWIFT__c=preca.SWIFT__c;
                Cuenta.TelefonosAdicionales__c=preca.TelefonosAdicionales__c;
                Cuenta.TipoGastos__c=preca.TipoGastos__c;
                Cuenta.TipoPersona__c=preca.TipoPersona__c;
                Cuenta.Tipo_promotor__c=preca.Tipo_promotor__c;
                Cuenta.UsuarioInversor__c=preca.UsuarioInversor__c;
                Cuenta.Usuario__c=preca.Usuario__c;
                Cuenta.Vincular_ofertas__c=preca.Vincular_ofertas__c;
                Cuenta.Website=preca.Website;
                system.debug('Funciona1'+preca.Type);
                system.debug('Funciona3'+preca.LeadOrigen__c);
                //if(preca.Type=='Lead')
                ////insert cuenta;  
                       
                      
                     
                
        }
        
        
    }
        }
    
}