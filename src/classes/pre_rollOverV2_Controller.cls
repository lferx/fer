public with sharing class pre_rollOverV2_Controller {
	
	public Account leadCliente {get;set;}
	public RecordType registroId;
	public Id cuentaMatriz {get;set;}
	//public string fecha2 {get;set;}

	//public String email01 {get;set;}
	//public String email02 {get;set;}
	//public String email03 {get;set;}
	public String[] arrayCorreos;

	public boolean error {get;set;}
	public boolean msg {get;set;}
	public boolean estrella {get;set;}
	//public boolean alerta {get;set;}
	public String tabname {get; set;}

	//EMPIEZA Declaracion de variables asignacion de Propietario
	public Map<Integer,String> mapaCandidatos {get;set;}
	public Integer seleccionado {get;set;}
	//variables para las listas
	//public List<SelectOption> lOpts {get;set;}
	//public List<SelectOption> lOptss {get;set;}
	public String org {get;set;}
	public String plz {get;set;}
	public String nombre {get;set;}

	public Account duplicados {get;set;}
	public String mensajeDuplicados {get;set;}

	public pre_rollOverV2_Controller() {
		mensajeDuplicados = '';
		mapaCandidatos = new Map<Integer,String>();
		seleccionado = 100000000;
		//TERMINA Instacia de variables asignacion de Propietario
		estrella= false;
		tabname= 'uno';
		msg = false;
		leadCliente= new Account();
		registroId=new RecordType();

		registroId=[SELECT Id FROM RecordType where Name = 'Lead Cliente'];

		leadCliente.RecordTypeId= registroId.Id;
		leadCliente.Type='Lead Cliente';
		//EMPIEZA Codigo asignacion de Propietario

		try{

			for(User us: [SELECT id FROM User WHERE Usuario_de_Roll_Over__c = true Limit 99]){
				mapaCandidatos.put([SELECT count() FROM Account WHERE OwnerId = :us.id AND type = 'Lead Cliente' AND Visto__c = false],us.id);
			}


			for(Integer leads: mapaCandidatos.keyset()){
				if(seleccionado > leads){
					seleccionado = leads;
				}
			}

			leadCliente.OwnerId = mapaCandidatos.get(seleccionado);
			
		}
		catch(exception e){
			leadCliente.OwnerId=UserInfo.getUserId();
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha habido un error al asignar automaticamente al <b>Propietario<b><br>-Favor de informar a sistemas y asignar manualmente'));
		}
		//TERMINA Codigo asignacion de Propietario
		leadCliente.Fecha_de_Asignacion_de_Lead__c=date.today(); // asigna la fecha de hoy automaticamnte
		
	}//cierra el constructor
	public void guardarDatos(){
		System.debug('Entro 1');
		

		if(String.isNotBlank(leadCliente.firstName) && (leadCliente.Phone != null || leadCliente.PersonEmail != null)){
			//alerta= true;
			//if(leadCliente.Fecha_de_nacimiento__c == null){
			//	System.debug('entra fecha vacia');
			//	alerta= false;
			//}
			error = false;
			System.debug('Entro 2');
			if(leadCliente.Tipo_de_Credito__c=='Sin_Relación_Laboral'){
				leadCliente.Fecha_de_Consulta__c=date.today();
			}
			if(String.isBlank(leadCliente.lastName)){
				leadCliente.lastName = '+';
			}
			if (leadCliente.Fecha_de_nacimiento__c == null)
			{

					tabname='3';
			}
			leadCliente.Origen__c = org;
			leadCliente.Ciudad_Plaza__c = plz;
			//leadCliente.Precalificacion__c	= credit;

			registroId=[SELECT Id FROM RecordType where Name = :leadCliente.type];
			leadCliente.RecordTypeId= registroId.Id;

			if(leadCliente.Type == 'Lead Promotor' || leadCliente.Type == 'Lead Inversionista'){
				User sandra = [SELECT id FROM User WHERE Seguimiento_Inv_Prom__c = true LIMIT 1];
				leadCliente.OwnerId = sandra.id;
				if(leadCliente.Type == 'Lead Inversionista'){
					leadCliente.Target__c = '3';
				}
			}

			nombre = Utilities.accentsRemover(leadCliente.firstname).trim();

            if([SELECT count() FROM Account WHERE ((phone != NULL AND phone = :leadCliente.phone) OR (Email__c != NULL AND Email__c = :leadCliente.PersonEmail) OR (PersonEmail != NULL AND PersonEmail = :leadCliente.PersonEmail)) AND RecordType.name = :leadCliente.type AND firstname = :nombre AND lastname = :leadCliente.lastName AND id != :leadCliente.id]>0){
                duplicados = [SELECT id,name,phone,Email__c,PersonEmail,Owner.name,CreatedDate FROM Account WHERE ((phone != NULL AND phone = :leadCliente.phone) OR (Email__c != NULL AND Email__c = :leadCliente.PersonEmail) OR (PersonEmail != NULL AND PersonEmail = :leadCliente.PersonEmail)) AND RecordType.name = :leadCliente.type AND firstname = :nombre AND lastname = :leadCliente.lastName];
                System.debug('Encontro cuenta duplicada');
                mensajeDuplicados = 'Se ha encontrado un registro existente con los mismo datos. Selecciones un tipo de Lead diferente o cree un Lead NUEVO.';
                error = true;
            }
            else{
                System.debug('No encontro cuenta Duplicada');
                UPSERT leadCliente;
				cuentaMatriz= Utilities.buscaMatriz(leadCliente.Id);
				Utilities.ligarMatriz(leadCliente.Id,cuentaMatriz);
				msg=false;
				mensajeDuplicados = '';
            }
	        
		}
		else{
			error = true;
			System.debug('Entro 3');
			if(String.isBlank(leadCliente.firstName)){
				leadCliente.firstName.addError('nombre obligatorios');
			}

			//leadCliente.lastName.addError('apellido Obligatorio');

			if(String.isBlank(leadCliente.Phone) && String.isBlank(leadCliente.PersonEmail)){
				leadCliente.Phone.addError('Telefono Obligatorio');
				leadCliente.PersonEmail.addError('Correo Obligatorio');
			}
			if(String.isBlank(leadCliente.firstname)){
				msg=true;
			}
			else{
				msg=false;
			}
			
			//ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No se han completado campos obligatorios, se requiere <br>NOMBRE<br>TELEFONO<br>EMAIL'));
			
		}
		return;
	} 
	//public PageReference SaveAndNew() {
      
 //  PageReference pr = Page.Pre_rollOver;
 //  pr.setRedirect(true);
 //  return pr;
	//}
		public PageReference createNewLead(){

			guardarDatos();
			PageReference inicio= new PageReference ('/apex/Pre_rollOverV2');
			inicio.setRedirect(true);
			return inicio;

		}

public void cambioTipoCredito() {
        if (leadCliente.Precalificacion__c==0 || leadCliente.Precalificacion__c==null) {
            leadCliente.Tipo_de_Credito__c=null;
        }
        if (leadCliente.Precalificacion__c > 0 && leadCliente.Precalificacion__c <250000) {
           leadCliente.Tipo_de_Credito__c='Credito Listo para Ejercer';
        }
        if(leadCliente.Precalificacion__c>=250000) {
            leadCliente.Tipo_de_Credito__c='Autorizado';

        }
    }

    //public void leadAsignado(){
    //	if(leadCliente.Phone != null && leadCliente.Id_de_Interes__c != null && leadCliente.Precalificacion__c)



    //}
    //public void checkDate() {
    //    system.debug('Entro a validar fecha');


    //}
    public PageReference menorDate() {
       system.debug('Entro a validar fecha');
       //fecha2=(leadCliente.Fecha_de_nacimiento__c).format();
       if (leadCliente.Fecha_de_nacimiento__c > Date.today().addYears(-18)) {
           leadCliente.Fecha_de_nacimiento__c.addError('No cumple con la mayoria de edad (+18)');
           system.debug('fue menor de edad');
            
       }
       return null;

}

	public void checkEmail() {
		system.debug('Entro a validar correos');
		boolean error = false;
		string mensaje = 'Uno o mas correo no son validos verificalos de nuevo: <br>';
		integer numerar = 0;
		integer numcorreos = 0;

		String email01 = leadCliente.PersonEmail;
		

		if (string.isNotBlank(email01)){

			email01=email01.trim();
			email01=email01.toLowerCase();

			if(email01.containsNone('@') || email01.containsNone('.')){
				leadCliente.PersonEmail.addError('correo invalido');
				error=true;
			}
		}
		

			//leadCliente.Fecha_de_nacimiento__c.addError('');
			//system.debug('fue menor de edad');
		
		if(error){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, mensaje));
			
		}
	}
	public void validaEstrellaPhone(){
		if(leadCliente.Phone != null){
			estrella = true;
		}

	}
	//Metodo con get crea lista en base a obj y campo
    public List<SelectOption> getListaOrigenes(){

        List<SelectOption> lOpts = new List<SelectOption>();
        lOpts.add(new SelectOption('', '--SubOrigen--'));
        /*lOpts.add(new SelectOption('%', '--Todos--'));*/
        lOpts.addAll(getPicklistValues(leadCliente, 'Origen__c'));

        return lOpts;
    }
    public List<SelectOption> getListaPlazas(){

        List<SelectOption> lOptss = new List<SelectOption>();
        lOptss.add(new SelectOption('', '--Ciudad--'));
        /*lOpts.add(new SelectOption('%', '--Todos--'));*/
        lOptss.addAll(getPicklistValues(leadCliente, 'Ciudad_Plaza__c'));

        return lOptss;
    }
    //public List<SelectOption> getListaTipoCredito(){

    //    List<SelectOption> lOptsss = new List<SelectOption>();
    //    lOptsss.add(new SelectOption('', '--Tipo de Credito Infonavit--'));
    //    /*lOpts.add(new SelectOption('%', '--Todos--'));*/
    //    lOptsss.addAll(getPicklistValues(leadCliente, 'Precalificacion__c'));

    //    return lOptsss;
    //}


    // metodo que devuelve lista de opciones
    public list<SelectOption> getPicklistValues(SObject obj, String fld){
        list<SelectOption> options = new list<SelectOption>();
        // Get the object type of the SObject.
        Schema.sObjectType objType = obj.getSObjectType(); 
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();    
        // Get a map of fields for the SObject
        map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap(); 
        // Get the list of picklist values for this field.
        list<Schema.PicklistEntry> values = fieldMap.get(fld).getDescribe().getPickListValues();
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a : values){ 
            options.add(new SelectOption(a.getLabel(), a.getValue())); 
        }
        return options;
}


}//cierra la clase principal