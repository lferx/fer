public with sharing class prueba2 {

	String s= 'RapSolo';
	Account a = new Account(Name='perros',Industry='Tecnologia');
	List<Account> cuenta = [select Name, Type, Phone From Account Limit 20];

	List<Account> cuenta1 = [select Name, Type, Phone From Account where Type='Lead Cliente' Limit 20];
	List<Account> cuenta2 = [select Name, Type, Phone From Account where Type='Matriz' Limit 20];
	public prueba2() { 
		//controlador
		
	}
	public String gets(){
		return s;
	}
	public Account geta(){
		return a;
	}

	public List<Account> getcuenta(){
		return cuenta;
	}

	public PageReference section(){
		return Page.pruebas_Controller;
	}
	public List<Account> getcuenta1(){
		return cuenta1;
	}
	public List<Account> getcuenta2(){
		return cuenta2;
	}
}