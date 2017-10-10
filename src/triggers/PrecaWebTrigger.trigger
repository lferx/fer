trigger PrecaWebTrigger on Preca_Web__c (after update, after insert) { 
    
    
    
    /*if( Trigger.isAfter && Trigger.isInsert ){
        
        Sorteo__c sorteo = [SELECT Id, Name FROM Sorteo__c WHERE Fecha_de_inicio__c <=: System.today() AND Fecha_de_fin__c >=: System.today() limit 1];
        List<Boleto__c> lstBoletos = new List<Boleto__c>();
        
        for(Preca_Web__c newPreca:Trigger.new){
            
            Boleto__c boleto = new Boleto__c();
            boleto.Sorteo__c = sorteo.Id;
            boleto.Preca_Web__c = newPreca.Id;
            boleto.Estado__c = 'Activo';
            lstBoletos.add( boleto );
        }
        
        insert lstBoletos;
    }*/
    
    if( Trigger.isAfter && Trigger.isUpdate ){
        Preca_Web__c[] precas = Trigger.new;
        List<Lead> lstLeads = new List<Lead>();   
        
        for (Preca_Web__c preca :precas){
            if (preca.Califica__c == true) {                            
                Lead lead = new Lead();
                lead.FirstName = preca.Nombre__c;
                lead.LastName = preca.Apellido__c;
                lead.Plaza__c = preca.Plaza__c;
                lead.NSS__c = preca.NSS__c;
                lead.Fecha_Nacimiento__c = preca.Fecha_Nacimiento__c;
                lead.Credito__c = preca.Credito__c;
                lead.Email = preca.Email__c;
                lead.Phone = preca.Phone__c;
                lead.Password__c = preca.Password__c;
                lead.Company = 'Revimex Web';
                lead.PrecaWeb_Origen__c = preca.Name;
                lead.LeadSource = preca.Origen__c; 
                
                lead.Street = preca.Calle__c != null  ? preca.Calle__c : null;
                lead.Street += lead.Street != null    ?  ( preca.No_Exterior__c != null ? ' '+ preca.No_Exterior__c : '' ) : (preca.No_Exterior__c != null ? preca.No_Exterior__c : null );
                lead.Street += lead.Street != null    ?  ( preca.No_Interior__c != null ? ' '+ preca.No_Interior__c : '' ) : (preca.No_Interior__c != null ? preca.No_Interior__c : null );
                lead.Street += lead.Street != null    ?  ( preca.Colonia__c != null ? ' '+ preca.Colonia__c : '' ) : (preca.Colonia__c != null ? preca.Colonia__c : null );
                
                lead.State = preca.Estado__c;
                lead.PostalCode = preca.Codigo_Postal__c;
                lstLeads.add(lead);
            }
        }
        
        try {
            Schema.SObjectField sOField = Lead.Fields.NSS__c;
            Database.Upsertresult[] results = Database.upsert(lstLeads, sOField, false);
        }catch(Exception e){} 
    }
}