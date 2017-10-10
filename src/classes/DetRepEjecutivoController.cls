public with sharing class DetRepEjecutivoController {
    public list<Oferta__c> lofertas {get; set;}
    public string sEtapa {get; set;}
    public integer itotal {get; set;}
    public DetRepEjecutivoController()
    {
    	
    	string sQuery;
    	sQuery = ApexPages.currentPage().getParameters().get('squery');
    	sEtapa = ApexPages.currentPage().getParameters().get('setapa');
    	string sAbierta = 'Abierta';
    	string sDescartada = 'Descartada';
    	string sFinalizada = 'Finalizada';
    	set<string> sofertas = new set<string>();
    	integer ietapa; 
    	Decimal detapa;
    	integer iorden;
    	Date dnull = null;
    	boolean btrue = true;
	    boolean bfalse = false;
	    string scontado = 'Contado';
    	if (setapa == 'Etapa 9')
    	{
    		ietapa = 9;
    		iorden = 7;
    		
	    	list<EtapaOferta__c> ldoc = new list<EtapaOferta__c>();
	    	ldoc = Database.query(sQuery);
	    	
	    	for(EtapaOferta__c doc :ldoc)
	    	{
	    		sofertas.add(doc.Oferta__c);
	    	}
    	}
    	
    	if (setapa == 'Etapa 9a')
    	{
    		ietapa = 9;
    		iorden = 7;
    		
	    	list<Documento__c> ldoc = new list<Documento__c>();
	    	ldoc = Database.query(sQuery);
	    	
	    	for(Documento__c doc :ldoc)
	    	{
	    		sofertas.add(doc.Oferta__c);
	    	}
    	}
    	
    	if (setapa == 'Etapa 10.1')
    	{
    		detapa = 10.1;
    		iorden = 12;
    		
	    	list<Documento__c> ldoc = new list<Documento__c>();
	    	ldoc = Database.query(sQuery);
	    	
	    	for(Documento__c doc :ldoc)
	    	{
	    		sofertas.add(doc.Oferta__c);
	    	}
    	}
    	lofertas = [Select id, name, Owner.name, Propiedad__r.Plaza__c, Dictamen__c From Oferta__c Where id IN :sofertas Order by Owner.name, Propiedad__r.Plaza__c, name];
    	itotal = lofertas.size();
    }
}