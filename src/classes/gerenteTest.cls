@isTest
public class gerenteTest {
    static testMethod void gerenteTest()
    {

        etapa__c ee= new etapa__c();
        ee.name='Expediente aprobado';
        insert ee;
        DocumentoEtapa__c r=new DocumentoEtapa__c();
        r.name='Cierre Contabilidad';
        r.Etapa__c=ee.id;
        insert r;
        account a=new account();
        a.Pendientes_Realizados__c=null;
        a.name='prueba';
        a.Type='Empleado';
        a.TipoPersona__c='Física';
        insert a;
        Oferta__c fer = new Oferta__c();
        fer.FechaCobro__c=null;
        fer.TipoOferta__c='infonavit';
        fer.gerente_operativo__c = a.id;
        fer.Etapa__c='Expediente aprobado';
        insert fer;
        etapaoferta__c et=new etapaoferta__c();
        et.oferta__c=fer.id;
        et.Etapa__c=ee.id;
        et.Estatus__c='abierta';
        insert et;
        Documento__c e = new Documento__c();
        e.Cerrado__c=false;
        e.Iniciado__c=true;
        e.name='Cierre Contabilidad';
        e.oferta__c=fer.id;
        e.DocumentoEtapa__c=r.id;
        e.EtapaOferta__c=et.id;
        e.En_Espera__c=false;
        insert e;
        e.Cerrado__c=true;
        e.En_Espera__c=true;
        update e;
    }
}