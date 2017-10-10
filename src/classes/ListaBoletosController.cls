public with sharing class ListaBoletosController {
	
	public List<List<Boleto__c>> lstBoletos{get;set;}
	public String strNSS {get;set;}
	public String strEmail {get;set;}
	public String nombre{get;set;}
	public String plaza{get;set;}
	public String correo{get;set;}
	
	public Lead candidato{get;set;}
	public Account cliente{get;set;}
	public Preca_Web__c preca{get;set;}
	
	public ListaBoletosController(){
		this.CheckIfLogged();
		strEmail = Apexpages.currentPage().getParameters().get('email');
		
		List<Account> lstAccount = [SELECT Id,Name,Email__c,Numero_de_Seguro_Social__c,Plaza__c FROM Account WHERE  Email__c =:strEmail ];
		List<Lead> lstLead = [SELECT Id,Name,Email,NSS__c,Plaza__c FROM Lead WHERE  Email =:strEmail ];
		List<Preca_Web__c> lstPreca = [SELECT Id,Name,Nombre__c, Apellido__c ,Email__c,NSS__c,Plaza__c FROM Preca_Web__c WHERE  Email__c =:strEmail ];
		
		if( lstAccount != null && lstAccount.size() > 0){
			nombre = lstAccount[0].Name;
			plaza = lstAccount[0].Plaza__c;
			correo = lstAccount[0].Email__c;
			
		}else if(lstLead != null && lstLead.size() > 0) {
			nombre = lstLead[0].Name;
			plaza = lstLead[0].Plaza__c;
			correo = lstLead[0].Email;
			
		}else if(lstPreca != null && lstPreca.size() > 0){
			nombre = lstPreca[0].Nombre__c+' '+ lstPreca[0].Apellido__c ;
			plaza = lstPreca[0].Plaza__c;
			correo = lstPreca[0].Email__c;
			
		}
		
		lstBoletos = new List<List<Boleto__c>>();
		
		List<Boleto__c> lstBoletosAux = [SELECT Id,Name FROM Boleto__c WHERE Preca_Web__r.Email__c =: strEmail OR Candidato__r.Email =: strEmail  OR Cliente__r.Email__c =:strEmail ORDER BY Name];
		
		
		List<Boleto__c> listTemp = new List<Boleto__c>();
		Integer indice = 0;
		for( Boleto__c boleto: lstBoletosAux ){
			indice = indice+1;
			listTemp.add( boleto );
			if(listTemp.size() == 5 || lstBoletosAux.size() == indice){
				lstBoletos.add( listTemp );
				listTemp = new List<Boleto__c>();
			}
		}
		
	}

	public PageReference CheckIfLogged()
    {
        Cookie logged = ApexPages.currentPage().getCookies().get('logged');
        if (logged == null) {
            PageReference pageRef = new PageReference('/SorteoLogin');
            pageRef.setRedirect(true);
            return pageRef;
        }
        return null;
    }

}