public class MailerController {

    public void sendSeguimientoEmail()
    {
        List<Messaging.SingleEmailmessage> listaCorreos = new List<Messaging.SingleEmailmessage>();
        List<Lead> updateLead = new List<Lead>();
        List<Lead> leads = [SELECT Id, Credito__c, Plaza__c,Email,FirstName,Estatus_Llamada__c FROM Lead WHERE Estatus_Llamada__c = 'Seguimiento' AND Email != null AND Correo_Seguimiento__c = false LIMIT 90];
        EmailTemplate emailTemplate = [select Id, Subject, HtmlValue, Body from EmailTemplate where DeveloperName = 'Lead_First_Contact'];
        for (Lead lead :leads){ 
            try {
                if (lead.Email != null && lead.Email != '') {
                    List<Propiedad__c> propiedades = [SELECT Id,Name,Plaza__c,Oferta_Valor_Referencia__c,Calle__c,Colonia__c,Municipio__c FROM Propiedad__c WHERE Plaza__c = :lead.Plaza__c AND Oferta_Valor_Referencia__c > 0 AND Oferta_Valor_Referencia__c <= :lead.Credito__c AND EstatusWeb__c = 'Publicada' LIMIT 20];

                    String propiedadesLink = '<tr>';
                    for (Propiedad__c propiedad :propiedades){
                        propiedadesLink += '<tr><td style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #ffffff;"><a href="http://www.revimex.mx/apex/PropiedadDetalle?propiedad='+propiedad.Id+'&estado=Todos&ciudad=Todos&tipo=Todos">'+propiedad.Name+'</a></td><td style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #ffffff;">'+propiedad.Calle__c + ' ' + propiedad.Colonia__c + ' ' + propiedad.Municipio__c+'</td><td style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #ffffff;">'+lead.Credito__c +'</td><td style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #ffffff;">'+propiedad.Oferta_Valor_Referencia__c+'</td>';
                        String devolucion;
                        if ((((lead.Credito__c - propiedad.Oferta_Valor_Referencia__c) *100)/ lead.Credito__c) <= 5) {
                            devolucion = '3000';
                        } else {
                            devolucion = String.valueOf(lead.Credito__c - propiedad.Oferta_Valor_Referencia__c);
                        }
                        propiedadesLink += '<td style="border-width: 1px;padding: 8px;border-style: solid;border-color: #666666;background-color: #ffffff;">'+devolucion+'</td></tr>';
                    }

                    String htmlBody = emailTemplate.HtmlValue;
                    htmlBody = htmlBody.replace('{--NAME--}', String.valueOf(lead.FirstName));
                    htmlBody = htmlBody.replace('{--PROPIEDADESLINK--}', propiedadesLink);
                    htmlBody = htmlBody.replace('{--LEADID--}', lead.Id);
                    String plainBody = emailTemplate.Body;
                    plainBody = plainBody.replace('{--NAME--}', String.valueOf(lead.FirstName));
                    plainBody = plainBody.replace('{--PROPIEDADESLINK--}', propiedadesLink);

                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
                    String userEmail = lead.Email; 
                    String[] toAddresses = new String[] {userEmail}; 
                    email.setToAddresses(toAddresses); 
                    email.setHtmlBody(htmlBody);
                    email.setPlainTextBody(plainBody);
                    email.setSubject('Revimex cumple tus sueños');
                    listaCorreos.add(email);
                    lead.Correo_seguimiento__c = true;
                    updateLead.add(lead);

                }
            } catch(Exception e) {
                System.debug(e);
            }
        }
        try {
            Messaging.sendEmail(listaCorreos);
            update updateLead;
        } catch (Exception e) {
            System.debug('## Error sending mail: '+e);
        }
    }
}