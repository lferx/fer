public with sharing class AprobacionGastoController {
	Gasto__c gasto;
	String accion;
	
    public AprobacionGastoController(ApexPages.StandardController controller) {
    	accion = ApexPages.currentPage().getParameters().get('accion');
		gasto = [Select Id From Gasto__c Where Id =: controller.getId()];
    }
	
	public void revisaAprobacion(){
		update gasto;
		Gasto__c gasto2 = [Select Id, ErrorDuplicado__c, AprobacionDuplicado__c From Gasto__c Where Id =: gasto.Id];
		if(accion == 'Aprobar'){
			if(gasto2.ErrorDuplicado__c == null){
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Este flujo de aprobación es sólo para gastos duplicados.'));
			}else{
		        // Create an approval request for the account
		        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
		        req1.setComments('Se requiere la aprobación de este gasto.');
		        req1.setObjectId(gasto.id);
		        // Submit the approval request for the account
		        try{
		        	Approval.ProcessResult result = Approval.process(req1);
		        	if(result.isSuccess()){
		        		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'El registro se ha enviado correctamente.'));
		        	}
		        }catch(Exception e){
		        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '' + e.getMessage()));
		        }
			}
		}
		if(accion == 'cancelar'){
			Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
		    req.setComments('Se cancela la solicitud.');
		    req.setAction('Removed');
	    	Id workItemId;
		    for(ProcessInstanceWorkitem workItem  : [Select p.Id from ProcessInstanceWorkitem p
														where p.ProcessInstance.TargetObjectId =: gasto.Id]){
	    		workItemId = workItem.Id;
		    }
		    if(workItemId != null){
	    	    req.setWorkitemId(workItemId);
	        	
	        	try{
	        		Approval.ProcessResult result = Approval.process(req);
		        	if(result.isSuccess()){
		        		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'La aprobación se a cancelado correctamente.'));
		        	}
		        }catch(Exception e){
		        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, '' + e.getMessage()));
		        }
		    }
		}
		
	}
}