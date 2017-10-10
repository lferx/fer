trigger Desalojo on Desalojo__c (after insert,after delete) {
    
    if(trigger.isInsert){
        Oferta__c oferta;
        for(Desalojo__c desalojo:trigger.new){
            oferta = [select name, id, Desalojo__c from Oferta__c where id =: desalojo.Oferta__c];
            if(oferta.Desalojo__c == null){
                oferta.Desalojo__c = desalojo.Id;
                oferta.Invadida__c = true;
                update oferta;
            }
        }
    }
    
     if(trigger.isDelete){
        Oferta__c oferta;
        for(Desalojo__c desalojo:trigger.old){
            oferta = [select name, id, Desalojo__c from Oferta__c where id =: desalojo.Oferta__c];
                oferta.Invadida__c = false;
                oferta.Desalojo__c = null;
                update oferta;
        }
    }
}