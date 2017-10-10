public with sharing class AdminToolsController {
	public String userEmail {get;set;}
	public String plaza {get;set;}
	public List<Oferta__c> listaOfertas {get;set;}
	public List<Propiedad__c> listaPropiedades {get;set;}

	public AdminToolsController(){

	}

	public Pagereference asignaPropietario(){
		List<User> usuarios = [Select Id From User Where IsActive = true AND (Email =: userEmail OR UserName =: userEmail)];
		User usuario;
		if(usuarios.size() == 1){
			usuario = usuarios[0];
		}else{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'No se encontro un usuario con ese correo electrónico.'));
			return null;
		}

		listaPropiedades = [Select Id, Name, OwnerId, Plaza__c From Propiedad__c Where Plaza__c =: plaza AND OwnerId !=: usuario.Id limit 200];
		listaOfertas = [Select Id, Name, OwnerId, Plaza__c From Oferta__c Where Propiedad__c IN: listaPropiedades AND OwnerId !=: usuario.Id];

		List<EtapaOferta__c> listaEtapaOferta = [Select Id, OwnerId From EtapaOferta__c Where Oferta__c IN: listaOfertas];
		for(Oferta__c item : listaOfertas){
			item.OwnerId = usuario.Id;
		}
		for(Propiedad__c item : listaPropiedades){
			item.OwnerId = usuario.Id;
		}
		for(EtapaOferta__c item : listaEtapaOferta){
			item.OwnerId = usuario.Id;
		}
		update listaOfertas;
		update listaPropiedades;
		update listaEtapaOferta;
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Se actualizaron: ' + listaOfertas.size() + ' Ofertas con la plaza' + plaza + '.'));
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Se actualizaron: ' + listaPropiedades.size() + ' propiedades con la plaza' + plaza + '.'));
		return null;
	}

	private void summaryOfertas(){
		AggregateResult[] results = [
        	SELECT Propiedad__r.Plaza__c, Owner.Email, Count(Id) FROM Oferta__c GROUP BY Propiedad__r.Plaza__c, Owner.Email
        ];
        Summary[] Summaries = new List<Summary>();
        for (AggregateResult ar : results) {
            Summaries.add(new Summary(ar));
        }
	}

	public class Summary {
        public Integer quantity { get; private set; }
        public String correo { get; private set; }
        public String plaza { get; private set; }

        public Summary(AggregateResult ar) {
            quantity = (Integer) ar.get('Count(Id)');
            correo = (String) ar.get('Owner.Email');
            plaza = (String) ar.get('Propiedad__r.Plaza__c');
        }
    }
}