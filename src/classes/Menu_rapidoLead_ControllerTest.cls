@isTest

    public with sharing class Menu_rapidoLead_ControllerTest {

        static testMethod void testMethod1()

        {

        	RecordType tipoReg2 = [SELECT Id FROM RecordType where name = 'Cliente' limit 1];
            RecordType tipoReg = [SELECT Id FROM RecordType where name = 'Lead Cliente' limit 1];
        	List<Account> cuentas = new List<Account>();
        	
            Account nuevoLead = new Account();
            nuevoLead.Name ='Name';
            nuevoLead.phone ='1234567893';
            nuevoLead.Email__c ='MOLH880133@revimex.mx';
            nuevoLead.Cuenta_Matriz__c = NULL;
            nuevoLead.RecordTypeId = tipoReg2.id;
            cuentas.add(nuevoLead);

            Account cuentaHijo2 = new Account();
            cuentaHijo2.Name ='NameE';
            cuentaHijo2.phone ='1234567894';
            cuentaHijo2.Email__c ='MOLH880133@revimexX.mx';
            cuentaHijo2.Cuenta_Matriz__c = NULL;
            cuentaHijo2.RecordTypeId = tipoReg2.id;
            cuentas.add(cuentaHijo2);

            INSERT cuentas;

            Task nuevaTarea = new Task();
            nuevaTarea.Comentarios__c = 'Volver a llamar';

            INSERT nuevaTarea;

            Task viejaTarea = new Task();
            viejaTarea.Comentarios__c = 'Volver a llamar';

            INSERT viejaTarea;

			String idCuenta = nuevoLead.id;
			Id idRegistro = nuevoLead.id; 

            PageReference pag = new PageReference('/apex/creacioncuentatipolead');
            pag.getParameters().put('id',idRegistro);
            pag.getParameters().put('idTask',viejaTarea.id);
            Test.setCurrentPage(pag);


            Test.startTest();
                Menu_rapidoLead_Controller objeto = new Menu_rapidoLead_Controller();
                objeto.actual = 'CreacionCuentaTipoLead';
                objeto.listDescrip = new List<String>();
                objeto.listDescrip.add(objeto.actual);
                objeto.idRegistro = cuentaHijo2.id;
                objeto.nuevaTarea.Comentarios__c = 'Volver a llamar';
                objeto.creaReferido.firstname = 'name';
                objeto.creaReferido.lastname = 'last';
                objeto.creaReferido.phone = '1234543213';

                objeto.datoslead();
                objeto.getMinutos();
                objeto.getHoras();
				objeto.precalificacion();
				objeto.stock();
				objeto.envioficha();
				objeto.citalead();
				objeto.autorizacion();
				objeto.guardarTarea();
                objeto.nuevaTarea = new Task();
                objeto.nuevaTarea.Comentarios__c = 'No Interesado';
                UPSERT nuevaTarea;
                objeto.guardarTarea();
                objeto.nuevaTarea = new Task();
                objeto.nuevaTarea.Comentarios__c = 'Volver a llamar';
                objeto.hrs = '05';
                objeto.min = '5';
                objeto.nuevaTarea.ActivityDate = Date.today();
                objeto.viejaTarea = new Task();
                objeto.viejaTarea.Comentarios__c = 'Volver a llamar';
                INSERT objeto.viejaTarea;
                UPSERT nuevaTarea;
                objeto.guardarTarea();
                objeto.guardaClienteReferido();
                Account crearReferido2 = new Account(RecordTypeId = tipoReg.id, firstname = 'name', lastname = 'last',phone = '1234567890');
                INSERT crearReferido2;
                objeto.guardaClienteReferido();
                objeto.guardarTodo();
            Test.stopTest();
        }
    }