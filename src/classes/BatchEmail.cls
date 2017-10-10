global class BatchEmail implements Database.Batchable<sObject>{


	global List<Oferta__c> start(Database.BatchableContext BC){
		return [Select Id, EnviosNotaria__c, EstatusCorreoNotaria__c, Notaria__r.Email__c From Oferta__c Where EstatusCorreoNotaria__c = 'Pendiente'];
	}
 
	global void execute(Database.BatchableContext BC, List<Oferta__c> scope){
		for(Oferta__c oferta : scope){
			oferta.CorreoNotaria__c = oferta.Notaria__r.Email__c; 
			oferta.EnviosNotaria__c = (oferta.EnviosNotaria__c != null)? oferta.EnviosNotaria__c + 1: 1;
		}
		update scope;
	}

	global void finish(Database.BatchableContext BC){
   
	}
	
	public static testMethod void testBatch() {
	   Propiedad__c p = new Propiedad__c();
	   p.Name = 'TEST01';
	   p.GeneraOferta__c = true;
	   insert p;
	   
	   Oferta__c oferta = [Select Id, Name, Propiedad__c From Oferta__c Where Propiedad__c =: p.Id];
	   oferta.EstatusCorreoNotaria__c = 'Pendiente';
	   update oferta;
	   
	   Test.StartTest();
	   BatchEmail batch = new BatchEmail();
	   ID batchprocessid = Database.executeBatch(batch,1);
	   Test.StopTest();
	
	   System.AssertEquals(
	           database.countquery('SELECT COUNT()'
	              +' FROM Oferta__c WHERE EnviosNotaria__c > 0'),
	           1);  
	   
	}
}