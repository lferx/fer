public class SorteoLoginController 
{
    public String user{get;set;}
    public String pass{get;set;}

    public PageReference login()
    {

        if (user != '' && pass != '') {
            try {
                Account promotor = [SELECT Id,Email__c,Numero_de_Seguro_Social__c, Password__c , Tipo_promotor__c FROM Account WHERE Email__c = :user AND Password__c = :pass];
                System.debug('Account');
                Cookie logged = new Cookie('logged',String.valueOf(promotor.Email__c),null,-1,false);
                ApexPages.currentPage().setCookies(new Cookie[]{logged});
                PageReference pageRef;
                if(!promotor.Tipo_promotor__c.equals('Recomendador')){
                 pageRef = new PageReference('/VFListaBoletos?nss='+logged.getValue());
                }else{
                 pageRef = new PageReference('/Alta_Recomendado_Logeado?email='+logged.getValue());
                }
                
                pageRef.setRedirect(true);
                return pageRef;
            } catch(Exception a){
                try {
                    Lead lead = [SELECT Id, Email,NSS__c, Password__c FROM Lead WHERE Email = :user AND Password__c = :pass];
                    System.debug('Lead');
                    Cookie logged = new Cookie('logged',String.valueOf(lead.Email),null,-1,false);
                    ApexPages.currentPage().setCookies(new Cookie[]{logged});
                    PageReference pageRef = new PageReference('/VFListaBoletos?nss='+logged.getValue());
                    pageRef.setRedirect(true);
                    return pageRef;
                } catch (Exception l) {
                    try {
                        Preca_Web__c preca = [SELECT Id,NSS__c, Email__c, Password__c FROM Preca_Web__c WHERE Email__c = :user AND Password__c = :pass];
                        System.debug('Preca');
                        Cookie logged = new Cookie('logged',String.valueOf(preca.Email__c),null,-1,false);
                        ApexPages.currentPage().setCookies(new Cookie[]{logged});
                        PageReference pageRef = new PageReference('/VFListaBoletos?email='+logged.getValue());
                        pageRef.setRedirect(true);
                        return pageRef;
                    } catch (Exception p) {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Usuario y/o Contraseña incorrectos.'));
                    }
                }
            }
        }
        return null;
    }

    public PageReference logout()
    {
        Cookie logged = new Cookie('logged','',null,0,false);
        ApexPages.currentPage().setCookies(new Cookie[]{logged});
        PageReference pageRef = new PageReference('/SorteoLogin');
        pageRef.setRedirect(true);
        return pageRef;
    }

    
}