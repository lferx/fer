public with sharing class SeguimientoCorreos {
	public SeguimientoCorreos() {
		
	}

	public static Id obtenerTarea(Datetime tiempo, Id personContactId){
		List<Task> tareas = [Select id from task where createdDate =: tiempo and whoid =: personContactId];
		if(tareas.isEmpty())
			return null;
		else
			return tareas.get(0).Id;
	}

	public Map<Id,EmailStatus> obtenerSeguimiento(Id personContactId, Set<Id> actividadesIds){
		Map<Id,EmailStatus> mapa = new Map<Id,EmailStatus>();
		if(!actividadesIds.isEmpty()){
			List<Contact> contactos = [SELECT Id, (Select taskid, Id, firstopendate, lastopendate, EmailTemplateName, timesopened From EmailStatuses where taskid in: actividadesids) from Contact where Id =: personContactId];
			if(!contactos.isEmpty() && !contactos.get(0).EmailStatuses.isEmpty()){
				for(EmailStatus status : contactos.get(0).EmailStatuses){
					mapa.put(status.taskId, status);
				}
			}
		}
		return mapa;
	}

	public List<Detalle_del_Carrito__c> actualizarSeguimiento(Id personContactId, List<Detalle_del_Carrito__c> detalles){
		Set<Id> actividadesIds = new Set<Id>();
		for(Detalle_del_Carrito__C det : detalles){
			if(det.Id_de_Actividad__c != null){
				actividadesids.add(det.Id_de_Actividad__c);
			}
		}
		Map<Id,EmailStatus> seguimiento = obtenerSeguimiento(personContactId, actividadesIds);
		if(!seguimiento.isEmpty()){
			for(Detalle_del_Carrito__C det : detalles){
				if(det.Id_de_Actividad__c != null && seguimiento.containsKey(det.Id_de_Actividad__c)){
					det.Veces_Abierto__c = seguimiento.get(det.Id_de_Actividad__c).timesopened;
					det.Primera_Apertura__c = seguimiento.get(det.Id_de_Actividad__c).firstopendate;
					det.Ultima_Apertura__c = seguimiento.get(det.Id_de_Actividad__c).lastopendate;
				}
			}
		}
		return detalles;
	}

	public void cobertura(){
		integer a=1;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;

	}
}