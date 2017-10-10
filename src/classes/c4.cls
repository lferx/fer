public with sharing class c4 {
	List<Account> cuentas;
	public c4() {
		
	}
	public List<Account> getcuentas(){
		return cuentas;

	}

	public PageReference lead(){
		cuentas=[select Name, Type, Phone from Account where Type='Lead cliente' limit 30];
		return null;
	}
	public PageReference matriz(){
		cuentas=[select Name, Type, Phone from Account where Type='Matriz' limit 30];
		return null;
	}
}