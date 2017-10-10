public with sharing class authcontroller {
public string idauto {get; set;}
public autorizacion__c datos {get; set;}
public autorizacion__c estatus2 {get; set;}
public List<autorizacion__c> auto1 {get; set;}

public string cool  {get; set;}
public string tipoo {get;set;}
public Date myf {get;set;}
public double pv {get;set;}
public string edo {get;set;}
public estados__c edoc {get;set;}
public account dcuenta {get;set;}
public oferta__c ef {get;set;}
public string c {get;set;}

public boolean editado {get;set;}
public string busqueda {get;set;}
public string busquedat {get;set;}
public boolean empty {get;set;}
public string vista {get;set;}
public string comentarioRehab {get;set;}

public string Photolink{get;set;}

public PageReference abrir()
{
   PageReference pageRef = Page.Vistaauth;
   pageRef.setRedirect(false);        
   return pageRef;           
}

public authcontroller() 
{

        User us = [Select us.SmallPhotoUrl, us.FullPhotoUrl From User us where us.id=:Userinfo.getUserid()];
        Photolink = us.SmallPhotoUrl;

        string recent=ApexPages.currentPage().getParameters().get('recentAuth');
        if(recent!=null&&recent!='')
        {
            auto1=[select name,LastModifiedBy.name,Comentarios_Gasto__c,lastmodifieddate,files__c,ofertas__r.id,ofertas__r.montocredito__c,ofertas__r.MontoContado__c,tipo__c,cliente__c, id ,ntn__c,Tipo_Oferta__c,ClienteOferta__c,montocarta__c,createdbyid,Montoeditado__c , creado__c,estatus__c,acompra__c ,plus__c, fecha__c, ofertas__r.name, costos__c from autorizacion__c where id=:recent.trim()];
        }
    else
    {


        //if (u.name=='Shell Gomez Gomez')
        //{
        //    auto=[select name,tipo__c, id ,acompra__c, estatus__c ,ofertas__c,plus__c, fecha__c, oferta__c from autorizacion__c where estatus__c='pendiente' and fecha__c!= null and ofertas__c!=null ORDER BY Fecha__c ASC];
        //}
        //else {
        //    auto=[select name,tipo__c, id ,acompra__c, estatus__c ,ofertas__c, fecha__c,plus__c, oferta__c from autorizacion__c where estatus__c='autorizada' and fecha__c!= null and ofertas__c!=null ORDER BY Fecha__c ASC];
        //}

        cool=ApexPages.currentPage().getParameters().get('idx');



        if ((cool)!=null)
        {
            datos=[select ClienteOferta__c,name,ofertas__r.montocredito__c,ofertas__r.MontoContado__c,tipo__c,montoeditado__c,plus__c,Comentarios_Gasto__c,acompra__c,montogasto__c,ConceptoGasto__r.Name, beneficio__c,margenreferencia__c,id ,Banco__c,cuenta__c,clabe__c,ofertas__c,Montocarta__c,apoderado__c,cliente__c,
            estado__c, ciudad__c,direccion__c,Tipo_Oferta__c,empresa__c,preciov__c,Notaria__c,nnotaria__c,comisiongerente__c, broker__c,comisioncomercial__c,margenneto__c,estatus__c,
            rehabilitacion__c,cadeudos__c,cdesalojo__c,costos__c,ntn__c, fecha2__c, ofertas__r.name, NotariaVentas__r.Contacto__r.Name, NotariaVentas__r.Representante__c, NotariaVentas__r.Name from autorizacion__c where id=:cool];
            if (datos.plus__c==null)
           {
            datos.plus__c=0;
           } 
           if ((datos.tipo__c=='Carta de Instrucción')&&(datos.Montoeditado__c!=null))
           {
            if(datos.Montocarta__c!=datos.Montoeditado__c)
            {
                editado=true;
            }

           }

            ef=[select PrecioCompra__c,Saneamiento__c,BeneficioNeto__c,Total_pagado__c,MargenRehabilitacion__c,ComisionComercial__c,Devolucion__c,
                            LiquidacionPendiente__c,Devoluci_n_plus_venta__c,
                            Anticipo__c,MontoContado__c,MargenBruto__c,Total_cobrado__c,PrecioVenta__c, CosteAdeudos__c,CosteDesalojo2__c,
                            CosteRehabilitacion__c,TotalCosto__c,PresupuestoRehabilitacion__c,CosteAdeudosVenta__c,CosteImpuestosNotaria__c,
                            CosteHonorariosNotaria__c,margenneto__c, Precio_Original__c,TiempoOferta__c,Plaza__c,Estado__c,Estatus_de_Invasion__c,
                            montocredito__c from oferta__c where id=:datos.ofertas__c];
                       
            if (ef.Estado__c!=null)
            {
                edoc=[select name from estados__c where id=:ef.Estado__c];
                edo=edoc.name;
            }
            tipoo=datos.tipo__c;
            myf=datos.fecha2__c;
                if (datos.acompra__c==null)
            {
                datos.acompra__c=0;
            }
            if (datos.costos__c==null)
            {
                datos.costos__c=0;
            }
            if (datos.rehabilitacion__c==0)
            {
                datos.rehabilitacion__c=0;
            }
            if(datos.cdesalojo__c==0)
            {
                datos.cdesalojo__c=0;
            }
            if (datos.cdesalojo__c==null)
            {
                datos.cdesalojo__c=0;
            }
            if (datos.comisiongerente__c==null)
            {
                datos.comisiongerente__c=0;
            }
            if (datos.comisioncomercial__c==null)
            {
                datos.comisioncomercial__c=0;
            }
            if (datos.cadeudos__c==null)
            {
                datos.cadeudos__c=0;
            }
            if (datos.preciov__c!=null)
            {
            pv=datos.preciov__c;
                }
                if (datos.empresa__c!=null)
                {
                dcuenta=[select Banco__c, name, Cuenta_bancaria__c, CLABE__c from account where id=:datos.empresa__c];
                }

        }

        dat();
    }        
}



public void dat()
{
    string a='Autorizada';
    string p='Pendiente';
    string v='Validada';
    string d='Descartada';
    string n='No Autorizada';
    string vista;
    system.debug(UserInfo.getProfileId());
    if (UserInfo.getUserId()=='005310000082ip0AAA'||UserInfo.getUserId()=='005310000082ip0'||Userinfo.getUserId()=='00531000006vpJw'||Userinfo.getUserId()=='00531000006vpJwAAI') //jv
    {
       system.debug('entro 1');
       vista='\''+v+'\'';
    }
   if (UserInfo.getProfileId()=='00e31000001i8VV'||UserInfo.getProfileId()=='00e31000001i8VVAAY'||UserInfo.getProfileId()=='00e5A000001uEwIQAU') //oscar Controllers/ Ejec/ej ROllOver
    {
        system.debug('entro 2');
        vista='\''+p+'\'';
    }
    if (UserInfo.getProfileId()=='00e31000001RYwHAAW'||UserInfo.getProfileId()=='00ei0000000r3DhAAI'&&UserInfo.getUserId()!='005310000082ip0AAA'&&UserInfo.getUserId()!='005310000082ip0') //sist
    {
        system.debug('entro 3');
        vista='\''+a+'\''+',\''+p+'\''+',\''+v+'\',\''+n+'\'';
    }
    //else
    //{
    //    vista='\''+a+'\''+',\''+p+'\'';
    //    system.debug('entro 4'); 
    //}
    querypro(vista);
    
}
public List<autorizacion__c> querypro(string vista)
{
    auto1=new List<autorizacion__c>();
    Set<autorizacion__c> mySet= new Set<autorizacion__c>();
    List<autorizacion__c> nwList= new List<autorizacion__c>();
    nwList.clear();
        string x=UserInfo.getUserId();
        string q='select name,LastModifiedBy.name,Comentarios_Gasto__c,lastmodifieddate,files__c,ofertas__r.id,ofertas__r.montocredito__c,ofertas__r.MontoContado__c,tipo__c,cliente__c, id ,ntn__c,Tipo_Oferta__c,ClienteOferta__c,montocarta__c,createdbyid,Montoeditado__c , creado__c,estatus__c,acompra__c ,plus__c, fecha__c, ofertas__r.name, costos__c from autorizacion__c where estatus__c';
        string query=' '+q+' IN ('+vista+') and fecha__c!=null and ofertas__c!=null and tipo__c!=null and estatus__c!=null  order by fecha__c  desc limit 30';
        string query2=''+q+' IN ('+vista+') and createdbyid=\''+x+'\'  and fecha__c!=null and ofertas__c!=null and tipo__c!=null and estatus__c!=null order by CreatedDate desc limit 5';

        list<autorizacion__c> templist1= Database.query(query2);
        list<autorizacion__c> templist2= Database.query(query);

        if(templist1!=null)
        {
           auto1.addAll(templist1);    
        }
         if(templist2!=null)
        {
           auto1.addAll(templist2);    
        }
        
        system.debug(vista);
        system.debug(auto1);
        empty=false;
        busqueda=null;
        mySet.addAll(auto1);
        nwList.addAll(mySet);
        return nwList;
}
public void search()
{
busquedat=busqueda.trim();
auto1=[select LastModifiedBy.name,Comentarios_Gasto__c,lastmodifieddate,files__c,name,ofertas__r.id,ofertas__r.montocredito__c,ofertas__r.MontoContado__c,tipo__c,cliente__c, id ,Tipo_Oferta__c,ntn__c,ofertas__c, estatus__c,acompra__c ,montocarta__c,Montoeditado__c ,plus__c, creado__c, fecha__c, ofertas__r.name, costos__c from autorizacion__c where ofertas__r.name like :busquedat  and fecha__c!= null and ofertas__c!=null ORDER BY CreatedDate desc limit 50];
empty=false;
    if (auto1.isEmpty())
    {
        empty=true;
    }
}
public void obt()
{

Set<autorizacion__c> s1 = new Set<autorizacion__c>([select id from autorizacion__c where tipo__c='Gastos'  and fecha__c!= null and ofertas__c!=null  ORDER BY fecha__c desc limit 7]);
Set<autorizacion__c> s5 = new Set<autorizacion__c>([select id from autorizacion__c where tipo__c='Carta de Instrucción'  and fecha__c!= null and ofertas__c!=null  ORDER BY fecha__c desc limit 7]);
Set<autorizacion__c> s2 = new Set<autorizacion__c>([select id from autorizacion__c where tipo__c='Ofertas'  and fecha__c!= null and ofertas__c!=null  ORDER BY fecha__c desc limit 7]);
Set<autorizacion__c> sR = new Set<autorizacion__c>([select id from autorizacion__c where tipo__c='Rehabilitación'  and fecha__c!= null and ofertas__c!=null  ORDER BY fecha__c desc limit 7]);

   auto1=null;
   auto1=[select LastModifiedBy.name,Comentarios_Gasto__c,lastmodifieddate,files__c,name,ofertas__r.id,ofertas__r.montocredito__c,ofertas__r.MontoContado__c,tipo__c,cliente__c, id ,Tipo_Oferta__c,ntn__c,ofertas__c, estatus__c,acompra__c ,montocarta__c,Montoeditado__c , creado__c,plus__c, fecha__c, ofertas__r.name, costos__c from autorizacion__c where id = :s2 or id =:s5 or id =:s1 or id=:sR ORDER by tipo__c asc, CreatedDate desc];

}
public void obs()
{
Set<autorizacion__c> s1 = new Set<autorizacion__c>([select id from autorizacion__c where estatus__c='Pendiente'  and fecha__c!= null and ofertas__c!=null  ORDER BY fecha__c desc limit 7]);
Set<autorizacion__c> s2 = new Set<autorizacion__c>([select id from autorizacion__c where estatus__c='Autorizada'  and fecha__c!= null and ofertas__c!=null  ORDER BY fecha__c desc limit 7]);
Set<autorizacion__c> s3 = new Set<autorizacion__c>([select id from autorizacion__c where estatus__c='Validada'  and fecha__c!= null and ofertas__c!=null  ORDER BY fecha__c desc limit 7]);
Set<autorizacion__c> s4 = new Set<autorizacion__c>([select id from autorizacion__c where estatus__c='No Autorizada'  and fecha__c!= null and ofertas__c!=null  ORDER BY fecha__c desc limit 7]);
Set<autorizacion__c> s5 = new Set<autorizacion__c>([select id from autorizacion__c where estatus__c='Descartada'  and fecha__c!= null and ofertas__c!=null  ORDER BY fecha__c desc limit 7]);

   auto1=null;
   auto1=[select LastModifiedBy.name,Comentarios_Gasto__c,lastmodifieddate,files__c,name,ofertas__r.id,ofertas__r.montocredito__c,ofertas__r.MontoContado__c,tipo__c,cliente__c, id ,Tipo_Oferta__c,ntn__c, estatus__c,acompra__c ,montocarta__c,Montoeditado__c , creado__c,plus__c, fecha__c, ofertas__r.name, costos__c from autorizacion__c where id = :s1 or id =:s2 or id =:s3 or id =:s4 or id =:s5 ORDER by estatus__c asc, CreatedDate desc];
}
public void obd()
{
    auto1=null;
    auto1=[select LastModifiedBy.name,Comentarios_Gasto__c,lastmodifieddate,files__c,name,ofertas__r.id,ofertas__r.montocredito__c,ofertas__r.MontoContado__c,tipo__c,cliente__c, id ,Tipo_oferta__c,ntn__c, estatus__c,acompra__c,montocarta__c,Montoeditado__c , creado__c ,plus__c, fecha__c, ofertas__r.name, costos__c from autorizacion__c where fecha__c!= null and ofertas__c!=null ORDER BY CreatedDate desc limit 50];
}
public void aproved()
{
    auto1=null;
    auto1=[select LastModifiedBy.name,Comentarios_Gasto__c,lastmodifieddate,files__c,name,ofertas__r.id,ofertas__r.montocredito__c,ofertas__r.MontoContado__c,tipo__c,cliente__c, id ,Tipo_oferta__c,ntn__c, estatus__c,acompra__c,montocarta__c,Montoeditado__c , creado__c ,plus__c, fecha__c, ofertas__r.name, costos__c from autorizacion__c where tipo__c='Gastos' and estatus__c='Autorizada' and ofertas__c!=null ORDER BY lastmodifieddate desc limit 50];
}
public void mine()
{
    system.debug('he entrado aqui');   
    auto1=[select LastModifiedBy.name,Comentarios_Gasto__c,lastmodifieddate,files__c,name,ofertas__r.id,ofertas__r.montocredito__c,ofertas__r.MontoContado__c,tipo__c,cliente__c, id ,Tipo_oferta__c,ntn__c, estatus__c,acompra__c,montocarta__c, Montoeditado__c ,creado__c ,plus__c, fecha__c, ofertas__r.name, costos__c from autorizacion__c where createdbyid=:Userinfo.getUserid() and fecha__c!= null and ofertas__c!=null ORDER BY CreatedDate desc  limit 50];
    system.debug(auto1);
        if (auto1.isEmpty())
    {
        empty=true; 
    }
}
public void autorizar()
{
system.debug('id: '+idauto+'and'+UserInfo.getUserId());
estatus2 = [select Lead_Cliente__c,tipo__c,ofertas__c,estatus__c, fecha__c,ClienteOferta__c from autorizacion__c where id=:idauto];
if (UserInfo.getUserId()=='005310000082ip0AAA'||UserInfo.getUserId()=='005310000082ip0'||Userinfo.getUserId()=='00531000006vpJwAAI')
{
system.debug('entre a autorizar'+UserInfo.getUserId());
estatus2.estatus__c='Autorizada';
estatus2.fecha__c=DateTime.now().format();
update estatus2;
}


//Empieza codigo Hector
if(!Test.isRunningTest()){

    if (estatus2.ClienteOferta__c!=null)
    {
            system.debug('hector');
        Utilities.generaCliente(ID.valueof(estatus2.ClienteOferta__c));
    }
            
}  
//Termina codigo Hector
//Empieza codigo Hector
    if(estatus2.tipo__c != 'Contado' && estatus2.ClienteOferta__c != NULL && estatus2.ofertas__c != NULL)
    {
        system.debug('hector2');
        Utilities.cambiarPropietario(estatus2.ofertas__c,estatus2.ClienteOferta__c);  
    }
    //Termina codigo Hector
    dat();
    }
    public void noautorizar()
    {
        estatus2 = [select estatus__c,Comentarios_Gasto__c, fecha__c from autorizacion__c where id=:idauto];
        estatus2.estatus__c='No Autorizada';
        estatus2.Comentarios_Gasto__c=comentarioRehab;
        estatus2.fecha__c=DateTime.now().format();
        update estatus2;
        dat();
    }
    public void validar()
    {
        estatus2 = [select estatus__c, fecha__c from autorizacion__c where id=:idauto];
        estatus2.estatus__c='Validada';
        estatus2.fecha__c=DateTime.now().format();
        update estatus2;
        dat();
    }
    public void descartar()
    {
        estatus2 = [select estatus__c, fecha__c from autorizacion__c where id=:idauto];
        estatus2.estatus__c='Descartada';
        estatus2.fecha__c=DateTime.now().format();
        update estatus2;
        dat();
    }


    public List<RehabBudget__c> listLimits {get;set;}
    public final Decimal promR=58.46;
    public string autoRhbId {get;set;}
    public Autorizacion__c rhbData {get;set;}

    public void getRehabData()
    {
        system.debug('vine a este metodo'+autoRhbId);
        autoRhbId=autoRhbId.trim();
        if(autoRhbId!=null)
        {
            rhbData=null;
            rhbData=[select Ofertas__r.Name, RehabilitacionId__c,RehabilitacionId__r.Total__c, Ofertas__r.Propiedad__r.Construccion_m2__c, Ofertas__r.Estado__r.Name, Ofertas__r.Contratista__r.Name from Autorizacion__c where id=:autoRhbId];
            system.debug('result'+rhbData);
            List<RehabBudget__c> myL = new List<RehabBudget__c>();
            for( RehabBudget__c x:[select Id, Total__c, Name, Precio_Unitario__c,Concepto__c,Unidades__c, Promedio_Unidades__c, Limite__c, Comentarios__c from RehabBudget__c where Rehabilitacion__c=:rhbData.RehabilitacionId__c and Unidades__c!=0 and Unidades__c!=null and Concepto__c!='Extraordinario'])
            {
                myL.add(x);
            }
            GetDesvEst(myL,rhbData.Ofertas__r.Propiedad__r.Construccion_m2__c);
        }
    }



                    public void GetDesvEst(List<RehabBudget__c> myList, decimal metros)
                {
                    System.debug('limites'+myList.size());
                    Set<RehabBudget__c> Comparative =new Set<RehabBudget__c>([Select Id, Name, Precio_Unitario_Mercado__c, Precio_Unitario_Revimex__c, Promedio_Unidades__c from RehabBudget__c where Tipo__c='Comparativa']);
                    Map<string,RehabBudget__c> val=new Map<string,RehabBudget__c>();

                    for(RehabBudget__c y: Comparative)
                    {
                        val.put(y.Name, y);
                    }
                    System.debug('prom: '+val);
                    listLimits= new List<RehabBudget__c>();
                    listLimits.clear();
                    for(RehabBudget__c x:myList)
                    {
                        x.Limite__c=x.Precio_Unitario__c-((val.get(x.name).Precio_Unitario_Revimex__c+val.get(x.name).Precio_Unitario_Mercado__c)/2);
                        x.Promedio_Unidades__c=((val.get(x.name).Promedio_Unidades__c)/(promR))*metros;
                        x.Total__c=x.Precio_Unitario__c*Integer.valueOf(x.Unidades__c);
                        listLimits.add(x);
                    }

                }
}