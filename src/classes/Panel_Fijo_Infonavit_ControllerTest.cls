@isTest

    public with sharing class Panel_Fijo_Infonavit_ControllerTest {

        static testMethod void testMethod1(){

        	List<Oferta__c> listaOfertas = new List<Oferta__c>();

        	Account gerente1 = new Account(name='Ricardo Hernandez Bárcena');
        	INSERT gerente1;
        	Account gerente2 = new Account(name='Amira Haide Trejo Aranda');
        	INSERT gerente2;
        	Account gerente3 = new Account(name='Nadia Veronica Rosas Torres');
        	INSERT gerente3;

        	Etapa__c et1 = new Etapa__c(name='x1',NumEtapa__c = 10.0);
        	INSERT et1;
			Etapa__c et2 = new Etapa__c(name='x2',NumEtapa__c = 11.0);
        	INSERT et2;
			Etapa__c et3 = new Etapa__c(name='x3',NumEtapa__c = 12.0);
        	INSERT et3;


        	Oferta__c oferta1 = new Oferta__c(name='ofer1',Gerente_Operativo__c=gerente1.id,Estatus_de_invasion__c = 'Asegurada',Estatus__c='Pagada',TipoOferta__c='Infonavit',FechaPago__c = Date.today(),Etapa__c = 'x1');
        	listaOfertas.add(oferta1);

        	Oferta__c oferta2 = new Oferta__c(name='ofer2',Gerente_Operativo__c=gerente1.id,Estatus_de_invasion__c = 'Asegurada',Estatus__c='Pagada',TipoOferta__c='Infonavit',FechaPago__c = Date.today(),Etapa__c = 'x2');
        	listaOfertas.add(oferta2);

        	Oferta__c oferta3 = new Oferta__c(name='ofer3',Gerente_Operativo__c=gerente1.id,Estatus_de_invasion__c = 'Asegurada',Estatus__c='Pagada',TipoOferta__c='Infonavit',FechaPago__c = Date.today(),Etapa__c = 'x3');
        	listaOfertas.add(oferta3);

        	Oferta__c oferta4 = new Oferta__c(name='ofer4',Gerente_Operativo__c=gerente2.id,Estatus_de_invasion__c = 'Asegurada',Estatus__c='Pagada',TipoOferta__c='Infonavit',FechaPago__c = Date.today(),Etapa__c = 'x1');
        	listaOfertas.add(oferta4);

        	Oferta__c oferta5 = new Oferta__c(name='ofer5',Gerente_Operativo__c=gerente2.id,Estatus_de_invasion__c = 'Asegurada',Estatus__c='Pagada',TipoOferta__c='Infonavit',FechaPago__c = Date.today(),Etapa__c = 'x2');
        	listaOfertas.add(oferta5);

        	Oferta__c oferta6 = new Oferta__c(name='ofer6',Gerente_Operativo__c=gerente2.id,Estatus_de_invasion__c = 'Asegurada',Estatus__c='Pagada',TipoOferta__c='Infonavit',FechaPago__c = Date.today(),Etapa__c = 'x3');
        	listaOfertas.add(oferta6);

        	Oferta__c oferta7 = new Oferta__c(name='ofer7',Gerente_Operativo__c=gerente3.id,Estatus_de_invasion__c = 'Asegurada',Estatus__c='Pagada',TipoOferta__c='Infonavit',FechaPago__c = Date.today(),Etapa__c = 'x1');
        	listaOfertas.add(oferta7);

        	Oferta__c oferta8 = new Oferta__c(name='ofer8',Gerente_Operativo__c=gerente3.id,Estatus_de_invasion__c = 'Asegurada',Estatus__c='Pagada',TipoOferta__c='Infonavit',FechaPago__c = Date.today(),Etapa__c = 'x2');
        	listaOfertas.add(oferta8);

        	Oferta__c oferta9 = new Oferta__c(name='ofer9',Gerente_Operativo__c=gerente3.id,Estatus_de_invasion__c = 'Asegurada',Estatus__c='Pagada',TipoOferta__c='Infonavit',FechaPago__c = Date.today(),Etapa__c = 'x3');
        	listaOfertas.add(oferta9);

        	INSERT listaOfertas;

        	EtapaOferta__c etapaOf1 = new EtapaOferta__c(Oferta__c=oferta1.id,Etapa__c = et1.id);
        	INSERT etapaOf1;
			EtapaOferta__c etapaOf2 = new EtapaOferta__c(Oferta__c=oferta2.id,Etapa__c = et2.id);
        	INSERT etapaOf2;
			EtapaOferta__c etapaOf3 = new EtapaOferta__c(Oferta__c=oferta3.id,Etapa__c = et3.id);
        	INSERT etapaOf3;
			EtapaOferta__c etapaOf4 = new EtapaOferta__c(Oferta__c=oferta4.id,Etapa__c = et1.id);
        	INSERT etapaOf4;
			EtapaOferta__c etapaOf5 = new EtapaOferta__c(Oferta__c=oferta5.id,Etapa__c = et2.id);
        	INSERT etapaOf5;
			EtapaOferta__c etapaOf6 = new EtapaOferta__c(Oferta__c=oferta6.id,Etapa__c = et3.id);
        	INSERT etapaOf6;
			EtapaOferta__c etapaOf7 = new EtapaOferta__c(Oferta__c=oferta7.id,Etapa__c = et1.id);
        	INSERT etapaOf7;
			EtapaOferta__c etapaOf8 = new EtapaOferta__c(Oferta__c=oferta8.id,Etapa__c = et2.id);
        	INSERT etapaOf8;
			EtapaOferta__c etapaOf9 = new EtapaOferta__c(Oferta__c=oferta9.id,Etapa__c = et3.id);
        	INSERT etapaOf9;

            Test.startTest();
                Panel_Fijo_Infonavit_Controller objeto = new Panel_Fijo_Infonavit_Controller();
                objeto.proceso();
                

            Test.stopTest();
        }
    }