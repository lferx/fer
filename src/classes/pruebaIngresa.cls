public with sharing class pruebaIngresa {

	public Account a {get;set;}
	public List<Account> registro;
	public Id cuentaMatriz {get;set;}


	public pruebaIngresa() {
		a = new Account();
	}

	public Account geta(){
		return a;
	}

	public PageReference save(){
		insert a;
		  cuentaMatriz= Utilities.buscaMatriz(a.Id);
			Utilities.ligarMatriz(a.Id,cuentaMatriz);
		return null;
	}

	public PageReference SaveAndNew() {
      
   PageReference pr = Page.pruebaIngresa;
   pr.setRedirect(true);
   return pr;
	}

	public List<Account> getregistro(){
		return registro;

	}

	public PageReference trae(){
		registro =[select Firstname, Lastname,Type,Industry from Account];
		return null;


	}
}