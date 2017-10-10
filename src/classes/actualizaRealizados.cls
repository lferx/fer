global class actualizaRealizados implements Schedulable {

    global void execute(SchedulableContext sc) {
        Account docsRealizados;

        docsRealizados = [SELECT Pendientes_Realizados__c FROM Account WHERE Name = 'Shell Gomez Gomez'];
        
        docsRealizados.Pendientes_Realizados__c = 0;
        UPDATE docsRealizados;
    }
    
}