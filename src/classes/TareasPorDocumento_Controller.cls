public  class TareasPorDocumento_Controller {
	public Id docId{get;set;}

	public List<Task> tareas{
		get{
				if(tareas == null){
					tareas = [SELECT Id, Subject, Asunto2__c, Comentarios__c, Priority, Description, WhatId, Status, ActivityDate from Task where WhatId =: docId];
				}
				return tareas;
			}
		set;
	}

	public TareasPorDocumento_Controller() {		
	}

	public void guardar(){
		update tareas;
	}
}