public with sharing class Consola_Tareas_Controller {

	public String usuario {get;set;}
	public List<Task> listaTareas {get;set;}
	public Datetime now {get;set;}


	public Consola_Tareas_Controller() {
		usuario = UserInfo.getUserId();
		listaTareas = [SELECT ActivityDate,Comentarios__c,Description,Sigue_interesado__c,What.name,Status, Owner.name FROM Task WHERE WhatId in (SELECT id FROM Account WHERE OwnerId = :usuario)];
		now = System.now();
	}


}