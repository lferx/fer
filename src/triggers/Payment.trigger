trigger Payment on c2g__codaPayment__c (after insert, after update, before insert, before update) {
	if(trigger.isUpdate && trigger.isBefore){
		for(c2g__codaPayment__c payment : trigger.new){
			if(payment.c2g__Status__c != trigger.oldMap.get(payment.Id).c2g__Status__c){
				if(payment.c2g__Status__c == 'Background Posting'){
					payment.EstatusActualizacionGastos__c = 'En proceso';
				}
			}
		}
	}
	
	if(trigger.isUpdate && trigger.isAfter){
		List<c2g__codaPayment__c> listPaymentsMatched = new List<c2g__codaPayment__c>();
		List<c2g__codaPayment__c> listPaymentsCancel = new List<c2g__codaPayment__c>();
		for(c2g__codaPayment__c payment : trigger.new){
			if(payment.c2g__Status__c != trigger.oldMap.get(payment.Id).c2g__Status__c){
				if(payment.c2g__Status__c == 'Matched'){
					listPaymentsMatched.add(payment);
				}
				if(payment.c2g__Status__c == 'Canceled' && payment.c2g__Status__c != trigger.oldMap.get(payment.Id).c2g__Status__c){
					listPaymentsCancel.add(payment);
				}
			}
		}
		
		if(listPaymentsMatched.size() > 0){
			Set<String> setTransactions = new Set<String>();
			for(c2g__codaCashEntry__c item : [Select Id, c2g__Transaction__c From c2g__codaCashEntry__c Where c2g__PaymentNumber__c IN: listPaymentsMatched]){
				setTransactions.add(item.c2g__Transaction__c);
			}
			if(setTransactions.size() > 0){
				Map<String, c2g__codaTransactionLineItem__c> mapTransactions = new Map<String, c2g__codaTransactionLineItem__c>([Select Id From c2g__codaTransactionLineItem__c Where c2g__LineType__c = 'Analysis' AND c2g__Account__c != null AND c2g__BankAccount__c != null AND c2g__Transaction__c IN: setTransactions]);
				
				
				//Schedule the next batch to execute 1 minute after the current one ends.
				//Create the cron expression
				String scheduleString='0';//0 seconds
				Datetime currTime = System.now();
				currTime = currTime.addMinutes(1);
				scheduleString+=' '+currTime.minute();
				scheduleString+=' '+currTime.hour();
				scheduleString+=' '+currTime.day();
				scheduleString+=' '+currTime.month();
				scheduleString+=' ?';
				scheduleString+=' '+currTime.year();
				
				//Create a job name that is easy to monitor
				String jobName = 'ActualizaPagos - '+System.now().format('MM-dd-yyyy-hh-mm-ss:');
				
				//Schedule the job to run
				try{
					ScheduledActualizaTransacciones stsUpdate = new ScheduledActualizaTransacciones(mapTransactions.keySet(), trigger.new[0].Name);
					System.schedule(jobName,scheduleString,stsUpdate);
				}catch(Exception e){
					Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
				   	String[] toAddresses = new String[] {'demos@ctconsulting.com.mx'};
				   	mail.setToAddresses(toAddresses);
				   	mail.setSubject('Error payments 01: Proceso de pago fallido: Payment ' + trigger.new[0].Name);
				   	mail.setPlainTextBody
				   	('El proceo de pago fallo: ' + e);
				   	Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
				}
				
			}
		}
		if(listPaymentsCancel.size() > 0){
			List<Gasto__c> listaGastos = [Select Id From Gasto__c Where Payment__c IN: listPaymentsCancel AND PagadoFF__c = true];
			for(Gasto__c item : listaGastos){
				item.PagadoFF__c = false;
			}
			try{
				update listaGastos;
			}catch(Exception e){
				
			}
		}
	}
	if(trigger.isBefore && trigger.isInsert){
		User usuarioPredeterminado;
		for(User item : [Select Id From User Where UsuarioPredeterminadoPagos__c = true limit 1]){
			usuarioPredeterminado = item;
		}
		if(usuarioPredeterminado != null){
			for(c2g__codaPayment__c payment : trigger.new){
				payment.UsuarioEnvio__c = usuarioPredeterminado.Id;
			}
		}
	}
}