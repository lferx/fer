@isTest
global class Mock_JSONAuth implements HttpCalloutMock{
	String access_token;
		String token_type;
		Integer expires_in;
	global HTTPResponse respond(HTTPRequest req) {
		HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String message = '{"access_token" : "123456", "token_type" : "test", "expires_in" : 3600 }';
        res.setBody(message);
        res.setStatusCode(200);
        return res;
	}
}