@isTest
public class VistoTest {
	static testMethod void visto()
	{
        RecordType tipoReg2 = [SELECT Id FROM RecordType where name = 'Cliente' limit 1];

       Account acc = new Account();
        acc.Name = 'test';
        acc.Usuario__c = 'test';
        acc.Password__c = '12345';
        acc.Plaza__c = 'Dif-Mex';
        acc.Phone = '5123354555';
        acc.Email__c = 'aaa@www.com';
        acc.Precalificacion__c = 5000000;
        acc.RecordTypeId = tipoReg2.id;



        insert acc;

Task t = new Task();
        t.OwnerId = UserInfo.getUserId();
        t.Subject='Donni';
        t.Status='Not Started';
        t.Priority='Normal';
        t.Whatid=acc.id;

        insert t;  

}

	
}