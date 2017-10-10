@isTest
global class Mock_DriveGet implements HttpCalloutMock{
	global HTTPResponse respond(HTTPRequest req) {
		HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String message = '{"webContentLink" : "testurl"}';
        res.setBody(message);
        res.setStatusCode(200);
        return res;
	}
}