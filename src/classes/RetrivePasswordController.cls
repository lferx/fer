public class RetrivePasswordController 
{
    public String emailAddress {get;set;}
    public String usuario {get;set;}

    public PageReference SendRetrivePasswordMail()
    {
        if (emailAddress != '') {
            List<Messaging.SingleEmailmessage> listaCorreos = new List<Messaging.SingleEmailmessage>();
            String htmlBody = '';
            String plainBody = '';
            EmailTemplate emailTemplate = [select Id, Subject, HtmlValue, Body from EmailTemplate where DeveloperName = 'RecoverPassword'];
            htmlBody = emailTemplate.HtmlValue;
            plainBody = emailTemplate.Body;
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
            String userEmail = emailAddress;
            String[] toAddresses = new String[] {userEmail}; 
            email.setToAddresses(toAddresses); 
            
            try {
                Account client = [SELECT Id,Email__c,Numero_de_Seguro_Social__c, Password__c,Name FROM Account WHERE Email__c = :emailAddress AND Type = 'Cliente'];
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Un correo con tu contraseña ha sido enviado a '+ emailAddress +'.'));
                htmlBody = htmlBody.replace('{--PASSWORD--}', client.Password__c);
                plainBody = plainBody.replace('{--PASSWORD--}', client.Password__c);
                htmlBody = htmlBody.replace('{--NAME--}', client.Name);
                plainBody = plainBody.replace('{--NAME--}', client.Name);
                email.setHtmlBody(htmlBody);
                email.setPlainTextBody(plainBody);
                email.setSubject('Revimex | Envío de contraseña');
                listaCorreos.add(email);
                Messaging.sendEmail(listaCorreos);
                //PageReference pageRef = new PageReference('/RecoverPassword');
                //pageRef.setRedirect(true);
                //return pageRef;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Un correo con tu contraseña ha sido enviado a '+ emailAddress +'.'));
                emailAddress = '';
                return null;
            } catch(Exception a){
                try {
                    Lead lead = [SELECT Id, Email,NSS__c, Password__c, FirstName, LastName FROM Lead WHERE Email = :emailAddress];
                    htmlBody = htmlBody.replace('{--PASSWORD--}', lead.Password__c);
                    plainBody = plainBody.replace('{--PASSWORD--}', lead.Password__c);
                    htmlBody = htmlBody.replace('{--NAME--}', lead.FirstName +' '+ lead.LastName);
                    plainBody = plainBody.replace('{--NAME--}', lead.FirstName +' '+ lead.LastName);
                    email.setHtmlBody(htmlBody);
                    email.setPlainTextBody(plainBody);
                    email.setSubject('Revimex | Envío de contraseña');
                    listaCorreos.add(email);
                    Messaging.sendEmail(listaCorreos);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Un correo con tu contraseña ha sido enviado a '+ emailAddress +'.'));
                    emailAddress = '';
                    return null;
                } catch (Exception l) {
                    try {
                        Preca_Web__c preca = [SELECT Id,NSS__c, Email__c, Password__c, Nombre__c, Apellido__c FROM Preca_Web__c WHERE Email__c = :emailAddress];
                        htmlBody = htmlBody.replace('{--PASSWORD--}', preca.Password__c);
                        plainBody = plainBody.replace('{--PASSWORD--}', preca.Password__c);
                        htmlBody = htmlBody.replace('{--NAME--}', preca.Nombre__c);
                        plainBody = plainBody.replace('{--NAME--}', preca.Apellido__c);
                        email.setHtmlBody(htmlBody);
                        email.setPlainTextBody(plainBody);
                        email.setSubject('Revimex | Envío de contraseña');
                        listaCorreos.add(email);
                        Messaging.sendEmail(listaCorreos);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Un correo con tu contraseña ha sido enviado a '+ emailAddress +'.'));
                        emailAddress = '';
                        return null;
                    } catch (Exception p) {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Un correo con tu contraseña ha sido enviado a '+ emailAddress +'.'));
                        emailAddress = '';
                        return null;
                    }
                }
            }
        }
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'* Por favor ingresa un correo.'));
        return null;
    }

    public PageReference SendRetrivePasswordMailPromotor()
    {
        if (usuario != '') {
            List<Messaging.SingleEmailmessage> listaCorreos = new List<Messaging.SingleEmailmessage>();
            String htmlBody = '';
            String plainBody = '';
            EmailTemplate emailTemplate = [select Id, Subject, HtmlValue, Body from EmailTemplate where DeveloperName = 'RecoverPassword'];
            htmlBody = emailTemplate.HtmlValue;
            plainBody = emailTemplate.Body;
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            System.debug('## User: '+usuario);
            
            try {
                Account client = [SELECT Id,Email__c, Password__c,Name,Usuario__c FROM Account WHERE Usuario__c = :usuario];
                htmlBody = htmlBody.replace('{--PASSWORD--}', client.Password__c);
                plainBody = plainBody.replace('{--PASSWORD--}', client.Password__c);
                htmlBody = htmlBody.replace('{--NAME--}', client.Name);
                plainBody = plainBody.replace('{--NAME--}', client.Name);
                String userEmail = client.Email__c;
                String[] toAddresses = new String[] {userEmail}; 
                email.setToAddresses(toAddresses); 
                email.setHtmlBody(htmlBody);
                email.setPlainTextBody(plainBody);
                email.setSubject('Revimex | Envío de contraseña');
                listaCorreos.add(email);
                Messaging.sendEmail(listaCorreos);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Un correo con tu contraseña ha sido enviado a tu cuenta de correo.'));
                usuario = '';
                return null;
            } catch(Exception a){
                System.debug(a);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Un correo con tu contraseña ha sido enviado a tu cuenta de correo.'));
                usuario = '';
                return null;
            }
        }
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'* Por favor ingrese un usuario.'));
        return null;
    }
}