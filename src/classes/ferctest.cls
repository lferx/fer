@isTest(SeeAllData=true)
public class ferctest {
    static testMethod void test_method_one()
    {


        RecordType tipoReg2 = [SELECT Id FROM RecordType where name = 'Lead Cliente' limit 1];
        RecordType tipoReg3 = [SELECT Id FROM RecordType where name = 'Notaría' limit 1];


		Estados__c e = new Estados__c();
		e.Name = 'edo';
		insert e;

		Ciudad__c c = new Ciudad__c();
		e.Name = 'edo';
		insert c;

    	account x=new account();
        x.recordtypeid=tipoReg2.id;
    	x.FirstNAme='xd';
        x.lastName='asd';
        x.phone='1234543212';
    	insert x;

        account n=new account();
        n.recordtypeid=tipoReg3.id;
        n.name='xasd';

        n.phone='1234542212';
        insert n;

    	paquete__c paq=new paquete__c();
    	paq.name = 'pp';
    	paq.empresas_grupo__c=x.id;
    	insert paq;


        oferta__c oferta=new oferta__c ();
        oferta.name='prueba';
        oferta.CosteDesalojo2__c=1000;
        oferta.ValorReferencia__c=199999;
        oferta.Notaria_Ventas__c=n.id;
        oferta.montocredito__c=10000;
        oferta.paquete__c=paq.id;
        oferta.estado__c=e.id;
        oferta.ciudad_tabla__c=c.id;
        oferta.clientefinal__c=x.id;
        oferta.apoderado__c=x.id;
        insert oferta;

        //ClienteOferta__c cof  =new ClienteOferta__c();
        //cof.Cuenta__c = x.Id;
        //cof.Oferta__c = oferta.Id;
        //insert cof;
        
        Desalojo__c desa = new Desalojo__c();
        desa.Oferta__c = oferta.Id;
        desa.Estatus__c= 'Completado';
        insert desa;

        carrito__c car = new carrito__c(
            Cuenta__c =x.id
            );
        insert car;

        Detalle_del_Carrito__c dcar = new Detalle_del_Carrito__c(
            Carrito__c = car.id,
            Oferta__c = oferta.id

            );
        insert dcar;

        carrito__c car2 = new carrito__c(
            Cuenta__c =x.id,
            Fecha_de_envio_pdf__c = System.now()
            );
        insert car2;
Account cuenta =new Account();
cuenta.Firstname='mm';
cuenta.LastName='asdd';
cuenta.forma_de_pago__c='contado';
cuenta.Email__c='testsinputasas@x.com';
cuenta.recordtypeid=tipoReg2.id;
cuenta.Type='Lead Cliente';
insert cuenta;
//Account cuenta2 =new Account();
//cuenta2.name='mm';
//cuenta2.mail='testsinputasas@mailx.com';
//insert cuenta2;



    	autorizacion__c auto=new autorizacion__c();
    	auto.idoferta__c=oferta.id;
        auto.ClienteOferta__c=cuenta.id;
    	auto.broker__c=0.02;
    	auto.tipo__c='ofertas';
        auto.comisioncomercial__c=10000;

    	insert auto;

    	conceptocatalogo__c cc=new conceptocatalogo__c();
    	cc.name='x';
        cc.categoria__c='Desalojo';
    	insert cc;

		gasto__c g=new gasto__c();
		g.oferta__c=oferta.id;
		g.Account__c=x.id;
		g.fecha__c=system.today();
		g.importe__c=1000;
		g.concepto__c=cc.id;
        g.Estatus2__c='Reconciliado';
		insert g;

        Autorizacion__c rehabTest= new Autorizacion__c();
        rehabTest.tipo__c='Rehabilitación';
        insert rehabTest;




        
    	Test.startTest();

    	PageReference pageRef = Page.Autorizacion;
        pageRef.getParameters().put('id', oferta.id);
        Test.setCurrentPage(pageRef);

        //PageReference pageRef2 = Page.Autorizacion;
        //pageRef2.getParameters().put('idaccount', x.id);
        //Test.setCurrentPage(pageRef2);

        ferc fertest = new ferc();
        fertest.acct.TipoOferta__c='Contado';
        fertest.acct.MontoContado__c=1;
        fertest.res=auto.id;
        fertest.Autorizacion.tipo__c='ofertas';
         fertest.idcarrito =null;
        fertest.idcarrito=cuenta.id;

        fertest.pv=1000;
        fertest.tp='Contado';
        fertest.guardar();
        fertest.abrir();
       
       fertest.getOpciones();
       fertest.getUser();
       fertest.idcarrito =cuenta.id;
       fertest.ofertalead=oferta.id;
       fertest.render();
       g.importe__c=30000;
       update g;
       fertest.render();
        update g; 
       g.importe__c=20000;
       fertest.render();
       fertest.idcarrito=null;
       //fertest.acct.Paquete__c=null;
        fertest.guardar();
        fertest.idcarrito =cuenta.id;
        fertest.tp='Credito';
        fertest.guardar();
        fertest.nuevolead=cuenta;
        fertest.tipoo = 'Gastos';
        fertest.acct.costeAdeudos__c=23524;
        fertest.ef.costeadeudos__c=100000;
        fertest.validar();
        fertest.acct.costeAdeudos__c=0;
        fertest.ef.costeadeudos__c=0;
        fertest.acct.costeAdeudosventa__c=1;
        fertest.ef.costeadeudosventa__c=2;
        fertest.validar();
        fertest.acct.costeAdeudosventa__c=0;
        fertest.ef.costeadeudosventa__c=0;
        fertest.acct.CosteHonorariosNotaria__c=1;
        fertest.ef.CosteHonorariosNotaria__c=2;
        fertest.validar();
        fertest.acct.CosteHonorariosNotaria__c=0;
        fertest.ef.CosteHonorariosNotaria__c=0;
        fertest.acct.CosteImpuestosNotaria__c=1;
        fertest.ef.CosteImpuestosNotaria__c=2;
        fertest.validar();  
        fertest.acct.CosteImpuestosNotaria__c=0;
        fertest.ef.CosteImpuestosNotaria__c=0;      
        fertest.acct.CosteDesalojo2__c=1;
        fertest.costo=2;
        fertest.validar();
        fertest.acct.CosteDesalojo2__c=0;
        fertest.ef.CosteDesalojo2__c=0;  
        fertest.acct.CosteRehabilitacion__c=1;
        fertest.ef.CosteRehabilitacion__c=2;
        fertest.validar();
        fertest.guardar();
        fertest.acct.CosteDesalojo2__c=null;
        fertest.acct.Costerehabilitacion__c=null;
        fertest.tipoo = 'Carta de Instrucción';
        fertest.guardar();
        fertest.guardartipo();
        fertest.acct.Costerehabilitacion__c=1000;
        fertest.calcular();
        fertest.acct.CosteAdeudos__c=null;
        fertest.acct.CosteAdeudosVenta__c=null;
        fertest.acct.CosteHonorariosNotaria__c=null;
        fertest.acct.CosteImpuestosNotaria__c=null;
        fertest.acct.CosteRehabilitacion__c=null;
        fertest.pv=1000000;
        fertest.broker=1000;
        fertest.gastos.preciov__c=1999;
        fertest.plus=23784;
        fertest.ine=1000;
        fertest.calcular();
        fertest.idcarrito =cuenta.id;
        fertest.estatus();
        fertest.idcarrito=x.id;
        fertest.tipoo = 'gastos';
        fertest.estatus();
        fertest.tipoo='Ofertas';
        fertest.Autorizacion.ClienteOferta__c=cuenta.id;
        fertest.estatus();
        fertest.citalead();
        fertest.cancelarLead();
        fertest.idfiles=auto.id;
        fertest.contentFile = Blob.valueOf('Name,Tipo_c,Precio_Unitario_Revimexc,Precio_Unitario_Mercadoc,promedio_unidadesc,Conceptoc,Metros_cuadrados_c\nMetro de Cable No. 12,Comparativa,6.04,7.5,122.33,Luz,58.46\nMetro de Cable No. 14,Comparativa,3.75,5.5,39.67,Luz,58.46\nMetro de Cable No. 8,Comparativa,2.63,15.5,31.07,Luz,58.46');
        fertest.readFile();
        fertest.deleteMe();
        fertest.getLimit();
        fertest.sMore();
        fertest.saveRh();
        fertest.updRh();

        String teststr = ferc.blobToString(Blob.valueOf('asdasdasdasdasd5a7s6dayugsdh2dy2'),'utf8');
        Attachment testAtt = new Attachment();
        testAtt.body = Blob.valueOf('asdasdasdasdasd5a7s6dayugsdh2dy2');
        testAtt.name = 'testfile';
        fertest.newAttachments=new List<Attachment>();
        fertest.newAttachments.add(testAtt);
        //fertest.saveAtt();
        //fertest.getRhdata();


        //fertest.cobertura();
        Test.stopTest();

    }



}