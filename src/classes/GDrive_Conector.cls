public with sharing class GDrive_Conector {
	public static String getPropertyUrl(String propertyCode) {
		String apiKey = GoogleApi__c.getOrgDefaults().Google_API_Key__c;
		String endpoint = 'https://www.googleapis.com/drive/v3/files?key=' + apiKey;
		String querySinEncode = 'name = \'' + propertyCode + '\' and mimeType = \'application/vnd.google-apps.folder\'';
		String query = 'q=' + EncodingUtil.urlEncode(querySinEncode,'UTF-8');
		endpoint += query;
		HttpRequest req = new HttpRequest();
     	req.setEndpoint(endpoint);
     	req.setMethod('GET');
     	Http ht = new Http();
     	HttpResponse res = ht.send(req);
     	System.debug(res);
     	/*
     	JSONParser parser = JSON.createParser(res.getBody());
		Decimal latitude = 0;
		Decimal longitude = 0;
		String status;
		while (parser.nextToken() != null) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
				String fieldName = parser.getText();
				parser.nextToken(); 
				if(fieldName == 'location'){
					if(parser.getCurrentToken() == JSONToken.START_OBJECT){
						while(parser.nextToken() != JSONToken.END_OBJECT){
							if(parser.getCurrentToken() == JSONToken.FIELD_NAME){
								fieldName = parser.getText();
								parser.nextToken();
								if(fieldname == 'lat')
									latitude = parser.getDecimalValue();
								else if(fieldname == 'lng')
									longitude = parser.getDecimalValue();
							}
						}
					}
				}else if(fieldName == 'status'){
					status = parser.getText();
				}
			}
		}
		*/
		return '';
	}
}