public class RTAFController 
{
    public String emailAddress {get;set;}
    
    public RTAFController() 
    {
        
    }

    public PageReference SendReferAFriendEmail()
    {
        List<Messaging.SingleEmailmessage> listaCorreos = new List<Messaging.SingleEmailmessage>();
        Cookie logged = ApexPages.currentPage().getCookies().get('logged');
        String htmlBody = '';
        String plainBody = '';
        if (logged != null) {
            EmailTemplate emailTemplate = [select Id, Subject, HtmlValue, Body from EmailTemplate where DeveloperName = 'RTAFL'];
            htmlBody = emailTemplate.HtmlValue;
            plainBody = emailTemplate.Body;
            Preca_Web__c preca = [SELECT Id,NSS__c, Email__c, Nombre__c, Apellido__c, Password__c FROM Preca_Web__c WHERE Email__c = :logged.getValue()];
            String name =  preca.Nombre__c + ' ' + preca.Apellido__c;
            htmlBody = htmlBody.replace('{--NAME--}', name);
            plainBody = plainBody.replace('{--NAME--}', name);
        } else {
            EmailTemplate emailTemplate = [select Id, Subject, HtmlValue, Body from EmailTemplate where DeveloperName = 'RTAF'];
            htmlBody = emailTemplate.HtmlValue;
            plainBody = emailTemplate.Body;
        }

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
        String userEmail = emailAddress;
        String[] toAddresses = new String[] {userEmail}; 
        email.setToAddresses(toAddresses); 
        email.setHtmlBody(htmlBody);
        email.setPlainTextBody(plainBody);
        email.setSubject('Revimex cumple tus sueños');
        listaCorreos.add(email);
        Messaging.sendEmail(listaCorreos);
        if (logged != null) {
            PageReference pageRef = new PageReference('/VFListaBoletos?email='+logged.getValue());
            pageRef.setRedirect(true);
            return pageRef;
        }
        PageReference re = new PageReference('/');
        re.setRedirect(true);
        return re;
    }

}