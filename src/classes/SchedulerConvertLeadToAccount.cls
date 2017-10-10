global class SchedulerConvertLeadToAccount implements Schedulable    {
    
    global void execute(SchedulableContext sc) {
        
        String query =  'SELECT' 
                       +' Lead__r.Name,'
                       +' Lead__r.FirstName,'
                       +' Lead__r.LastName,'
                       +' Lead__r.Street,'
                       +' Lead__r.City,'
                       +' Lead__r.Email,'
                       +' Lead__r.Phone,'
                       +' Lead__r.Plaza__c,'
                       +' Lead__r.NSS__c,'
                       +' Lead__r.Credito__c,'
                       +' Lead__r.Password__c,'
                       +' Lead__r.LeadSource,'
                       +' Id,'
                       +' Lead__c'
                       +' FROM Candidato_Interesado__c WHERE Interesado__c = true';
                       
        Id batchInstanceId = Database.executeBatch(new BatchConvertLeadToAccount(query),5);
    }

}