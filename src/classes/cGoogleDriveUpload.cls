public with sharing class cGoogleDriveUpload {
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

	public cGoogleDriveUpload() {
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

    public PageReference DriveAuth(){
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

        System.debug('req: ' + req);
        System.debug('req-body: ' + req.getBody());

        
        Http h = new Http();
        HttpResponse res = h.send(req);
        System.debug('res: ' + res);
        System.debug('res-body: ' + res.getBody());
        //Salesforce defined JSON Parser


		System.debug( res.getHeaderKeys());
		System.debug( res.getHeader('Transfer-Encoding')); 
		System.debug( res.getHeader('Accept-Ranges'));
		System.debug( res.getHeader('Date'));
		System.debug( req.getEndpoint());
		System.debug( req.getBodyDocument());


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




		String fileName = 'Hola Mundo';
		String fileContent = '{\nname:"text.txt",\nparents:[\n"0B6_j-v4Z6v26ZmdlM0ZDM1hYRFU"\n]\n}';
		//String targetURL = 'https://your.target.com/api';
		String separationString = 'foo_bar_baz';
		// assemble the body payload
		String header = '--' + separationString + '\nContent-Disposition: form-data;\nname:"up";\nfilename:"file";title:"test";\r\nContent-Type: application/json; charset=UTF-8\n\n';//\nContent-Disposition: form-data; name:"up";filename:"file";\nContent-Type: application/json; charset=UTF-8  'application/x-www-form-urlencoded'
		String body = '--' + separationString +'\nContent-Disposition: form-data;title:"test";\nContent-Type: text/plain\n\n';//\nContent-Disposition: form-data; name:"file"; filename:"test.txt";
		String contents=fileContent;
		String footer = '--' + separationString + '--';
		String bodyPayload = header + fileContent+'\n'+body+'\n'+filename+'\n' +footer;



			HttpRequest rqs = new HttpRequest();
        	rqs.setMethod('POST');
        //End point for authentication
        	rqs.setEndpoint('https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart');//https://www.googleapis.com/upload/drive/v2?uploadType=media
        	//rqs.setHeader('Host','www.googleapis.com');

        	rqs.setHeader('Content-Type', 'multipart/related; boundary=foo_bar_baz');//'multipart/related; boundary=foo_bar_baz'
        	rqs.setHeader('Authorization' , 'Bearer'+' '+ access_token);
        	rqs.setHeader('Content-length', String.valueOf(bodyPayload.length()));//String.valueOf(messageBody.length()))
        	rqs.setBody(bodyPayload);

        	//resq.setBody();
        //Message body for Authentication
        	//String messagesBody = 'title='+fTittle+'&mimeType='+fmimeType;//'code='+codemeniaIdentificationToken+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code'+'&
        	//messageBody += ;
        	//resq.setBody(messagesBody);
        	rqs.setTimeout(60*1000);
        	

        	System.debug('rqs: ' + rqs);
        	System.debug('rqs-body: ' + rqs.getBody());        
			System.debug('rqs-header: '+rqs.getHeader('Authorization'));        

        	Http ht = new Http();
        	HttpResponse resp = ht.send(rqs);

        	System.debug('resp: ' + resp);        	
        	System.debug('resp: ' + resp.getBody());
    	}
	}
}