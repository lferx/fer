public with sharing class EnvioCorreo_temp {
	public EnvioCorreo_temp() {
		
	}

	public static void pruebaEnvio(){
		List<Envio_de_retrasos__c> retrasosConfig = Envio_de_retrasos__c.getAll().values();
		List<String> destinatarios = new List<String>();
		String usuarioId;
		for(Envio_de_retrasos__c config : retrasosConfig){
			destinatarios.add(config.destinatario__c);
			usuarioId = config.Id_de_Usuario__c;
		}

		EmailTemplate template = [select Id From EmailTemplate Where Name = 'Envío de Retrasos' limit 1];
		Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
		email.setToAddresses(destinatarios);
		email.setTargetObjectId(usuarioId);
		email.setTemplateId(template.Id);
        email.setSaveAsActivity(false);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
	}
}