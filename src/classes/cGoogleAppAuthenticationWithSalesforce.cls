public class cGoogleAppAuthenticationWithSalesforce 
{
    //Client ID to identify the app being used to connect to google drive.
    //for example any app being used to connect google drive for any purpose having these cilent ID and secret
    private string key = '585295997278-a334i3vbifuqi9b54fmlf5bsqes7sdfd.apps.googleusercontent.com' ;
    private string secret = 'NI0VAGCje2emcjTaQ5sySyo8';
    //After receiving Authecation token for the app , will be redirectedd to this URL and one parameter in the URL will have to receive
    private string redirect_uri = 'https://'+ System.URL.getSalesforceBaseUrl().getHost()+'/apex/GoogleDriveIntegration';
    //App Authentication token is stored in this variable
    private String codemeniaIdentificationToken ; 
    //After App authentication by app user will have to provide its own google user name and password 
    //which is different from App created for client id and client secret
    //for Example you have one google ID as admin@gmail.com and using this you created one app
    //now you wants to fetch files for user@gmail.com from google drive
    //so Client secret is created by admin@gmail.com and access token is received for user@gmail.com
	private String access_token; 
    private List<String> FileLst;
    public Map<String,String> FileIdAndNameMapFortheAccount{get;set;}
    //Constructor
    public cGoogleAppAuthenticationWithSalesforce()
    {
        //Once Authentication is done again constructor is called and will have to receive the vale for code parameter
        codemeniaIdentificationToken = ApexPages.currentPage().getParameters().get('code') ;
        System.debug(codemeniaIdentificationToken);
        FileLst=new List<String>();
        FileIdAndNameMapFortheAccount=new Map<String,String>();
        if(codemeniaIdentificationToken != '' && codemeniaIdentificationToken != null)
        {
            AccessToken();
        } 
    }
    
    public PageReference DriveAuth()
    {
    	PageReference pg = new PageReference(new cAuthURIForApiREq(key , redirect_uri).AuthenticationURI) ;
        return pg;
    }
    
    public void AccessToken()
    {
        //Getting access token from google
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        //End point for authentication
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        //Message body for Authentication
        String messageBody = 'code='+codemeniaIdentificationToken+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        
        Http h = new Http();
        HttpResponse res = h.send(req);
        System.debug('res: ' + res);
        //Salesforce defined JSON Parser
        JSONParser parser = JSON.createParser(res.getBody());
        while (parser.nextToken() != null) 
        {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'access_token'))
            {
                parser.nextToken();
                access_token=parser.getText();
                break;
            }
        }
        if (access_token!='' && access_token != null)
        {
            ListFiles();
        }
    }
    
    public PageReference ListFiles()
    {  
        String FolderId= '0B6_j-v4Z6v26TlBQaEtmNG5KLUU';
        HttpRequest req1 = new HttpRequest();
        req1.setMethod('GET');
        //End point for List of Files in Folder
        req1.setEndpoint('https://www.googleapis.com/drive/v2/files/'+FolderId+'/children');
        req1.setHeader('content-type', 'application/x-www-form-urlencoded');
        req1.setHeader('Content-length', '0');
        //Specific Authorization Syntax
        req1.setHeader('Authorization' , 'Bearer'+' '+ access_token);
        req1.setTimeout(60*1000);
        Http h2 = new Http();
        HttpResponse resl = h2.send(req1);
        System.debug('response: ' + resl);
        System.debug('^^^^^'+resl.getBody());
        JSONParser parserD = JSON.createParser(resl.getBody());
        while (parserD.nextToken() != null) 
        {
            if ((parserD.getCurrentToken() == JSONToken.FIELD_NAME) && (parserD.getText() == 'id'))
            {
                parserD.nextToken();
                FileLst.add(parserD.getText());
            }
        }
       Map<String,String> FileIdAndNameMap=FileProperties();
        for(String s:FileLst)
        {
            FileIdAndNameMapFortheAccount.put(s, FileIdAndNameMap.get(s));
        }
        return null;
    }
    public  Map<String,String> FileProperties()
    {
        Map<String,String> FilePropertiesDetails=new Map<String,String>();
        HttpRequest req2 = new HttpRequest();
        req2.setMethod('GET');
        //End point URL for All the files in the drive and its ID,Name value in JSON Response
        req2.setEndpoint('https://www.googleapis.com/drive/v3/files');
        req2.setHeader('content-type', 'application/x-www-form-urlencoded');
        req2.setHeader('Content-length', '0');
        req2.setHeader('Authorization' , 'Bearer'+' '+ access_token);
        req2.setTimeout(60*1000);
        Http h3 = new Http();
        HttpResponse resls = h3.send(req2);
        System.debug('^^^^^'+resls.getBody());
        JSONParser parserDr = JSON.createParser(resls.getBody());
        while (parserDr.nextToken() != null) 
        {   
            String FileName='';
            String FileId='';
            if ((parserDr.getCurrentToken() == JSONToken.FIELD_NAME))
            {
                //First TOKEN is Id
                if((parserDr.getText() == 'id'))
                {
                    parserDr.nextToken();               
                    Fileid=parserDr.getText();
                }
                //Moving to Next Parser
                parserDr.nextToken();
                //Next Token is Name
                if((parserDr.getText() == 'name'))
                {
                    parserDr.nextToken();
                    Filename=parserDr.getText();
                }
                FilePropertiesDetails.put(Fileid, Filename);
            }
        }
        return FilePropertiesDetails;
    }
}