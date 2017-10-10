@isTest
global class Mock_DriveList implements HttpCalloutMock{
	global HTTPResponse respond(HTTPRequest req) {
		HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String message = '{"kind": "drive#fileList","nextPageToken": "V1*3|0|ChwwQjV5bFJDQ094MjRsY0daaWRVMVVhbWN6TVVrEgcQn-LQgLQr","incompleteSearch": false,"files": [{"kind": "drive#file","id": "0BzLlAZOUKIAkdGtDajdwY2M0bnM","name": "Cirrus Files","mimeType": "application/vnd.google-apps.folder"}]}';
        res.setBody(message);
        res.setStatusCode(200);
        return res;
	}
}