public with sharing class AutoLeadC {

    public Oferta__c acct {get;set;}
    public autorizacion__c autorizacion {get;set;}
    public account dcuenta {get;set;}
    public account dc {get;set;}
    public id x {get;set;}
    public string s {get;set;}
    public string c {get;set;}
    public id res {get;set;}
    public string tipo {get;set;}
    public Gasto__c gasto {get;set;}
    public string cempresa {get;set;}
    public string cla {get;set;}
    public string tipoo {get;set;}
    public autorizacion__c estatus {get;set;}
    public string fecha {get;set;}
    public autorizacion__c gastos {get;set;}
    public double pv {get;set;}
    public string xd {get;set;}
    public Date myf {get;set;}
    public string empresa {get;set;}
    public string cliente {get;set;}
    public string tp {get;set;}
    public string edo {get;set;}
    public string cd {get;set;}
    public estados__c edoc {get;set;}
    public ciudad__c cdc {get;set;}
    public string banco {get;set;}   
    public string cuenta {get;set;}
    public string clabe {get;set;}
    public string titular {get;set;}
    public account apoderado {get;set;}
    public string apo {get;set;}
    public oferta__c doferta {get;set;}
    public double monto {get;set;}
    public double montooriginal {get;set;}
    public string vt {get;set;}
    public string concepto {get;set;}
    public oferta__c ef {get;set;}
    public ConceptoCatalogo__c cat {get;set;}
    public Double ine {get;set;}
    public account dnotaria {get;set;}
    public user creador {get;set;}
    public boolean insertado {get;set;}
    public List<carrito__c> carrito {get;set;}
    public string idcarrito {get;set;}
        public List<SelectOption> user;   
        public boolean oferta {get;set;}


            public transient List<AggregateResult> idAsignados {get;set;} 

                                        public PageReference abrir()

                                       {
                                           PageReference pageRef = Page.Vistaauth;
                                           pageRef.setRedirect(false);        
                                           return pageRef;           
                                       }



            public AutoLeadC() {

idcarrito =ApexPages.currentPage().getParameters().get('idaccount');
if ((idcarrito!=null)&&(idcarrito!=''))
{
carrito =[select id, (select oferta__c, name from Detalles_del_Carrito__r) from carrito__c where cuenta__c=:idcarrito limit 1];
//for (Detalle_del_Carrito__c det:carrito.Detalles_del_Carrito__r)
//{

//}


}
else {
    carrito =[select id, (select oferta__c from Detalles_del_Carrito__r) from carrito__c limit 1];
}

            	tipoo='Ofertas';
            //s=System.currentPageReference().getParameters().get('id');
            myf=date.today();
            if (c==null)
            {
c='a08g0000008NAHr';
   }         //if (s==null){
            //c='a08g0000008NAHr';
            //}

                    ef=[select PrecioCompra__c,Saneamiento__c,BeneficioNeto__c,Total_pagado__c,MargenRehabilitacion__c,ComisionComercial__c,Devolucion__c,LiquidacionPendiente__c,Devoluci_n_plus_venta__c,
                    Anticipo__c,MontoContado__c,MargenBruto__c,Total_cobrado__c,PrecioVenta__c, CosteAdeudos__c,CosteDesalojo2__c,
                    CosteRehabilitacion__c,TotalCosto__c,PresupuestoRehabilitacion__c,CosteAdeudosVenta__c,CosteImpuestosNotaria__c,
                    CosteHonorariosNotaria__c,margenneto__c, Precio_Original__c,TiempoOferta__c,Plaza__c,Estado__c,Estatus_de_Invasion__c,
                    montocredito__c from oferta__c where id=:c];
                  acct= [select id,TipoOferta__c,Notaria_Ventas__c,CosteAdeudos__c, apoderado__c,paquete__c,Estado__c,Ciudad_Tabla__c,CosteRehabilitacion__c,
                  ValorReferencia__c,Saneamiento__c,CosteHonorariosNotaria__c,CosteImpuestosNotaria__c, CosteDesalojo2__c,PrecioVenta__c,PrecioCompra__c,
                    CosteAdeudosVenta__c, Paquete__r.Empresas_Grupo__c, ClienteFinal__c, Direccion2__c, Propiedad__r.Plaza__c, name, montocontado__c, montocredito__c,
                    anticipo__c from Oferta__c where id =:c ]; 
                  if ((acct.TipoOferta__c=='Contado')&&(acct.MontoContado__c!=null))
                  {
                    montooriginal=acct.montocontado__c;
                  } 
                  if ((acct.TipoOferta__c!='Contado')&&(acct.Montocredito__c!=null))
                  {
                    montooriginal=acct.montocredito__c;
                  } 
                  autorizacion= [select id,idoferta__c,montocarta__c,Montogasto__c,Comentarios_Gasto__c,comisioncomercial__c,broker__c,Beneficio__c,comisiongerente__c,
                  name,tipo__c,preciov__c, costos__c, empresa__c,plus__c, notaria__c, nnotaria__c, estatus__c, fecha__c from autorizacion__c LIMIT 1 ]; 
                  autorizacion.montocarta__c=null;
                  autorizacion.tipo__c=null;
                  autorizacion.Montogasto__c=null;
                  tp='Contado'; //se requiere que leads defina esto
                  acct.TipoOferta__c='';


                  if ((tipo=='Ofertas')&&(c!=null))
                  {
								if (tp!=null)
                            {
                                if (tp=='Contado')
                                {
                                monto=100000;
                                }
                                if (tp!='Contado')
                                {
                                monto=acct.montocredito__c;
                                }
                            }

     
            }

}

    //public List<AggregateResult> queryCarrito(){
    //return [SELECT name FROM carrito__c
    //            WHERE cuenta__c=:idcarrito];
    //}


public List<SelectOption> getUser(){                                  
        user = new List<SelectOption>();
        user.add(new SelectOption('a08g0000008NAF9','IF-12345'));
        return user;
}

                public Void Guardartipo(){

                autorizacion__c auto=new autorizacion__c();
tipoo='Ofertas';
                oferta=true;

                }

                                public void calcular()

                                {
                                if (insertado!=true)
                               
                                {
                                 autorizacion__c auto=new autorizacion__c();

                                     
                            auto.Tipo_Oferta__c=tp;
                            auto.plus__c=autorizacion.plus__c;
                            auto.oferta__c=acct.name;
                            auto.direccion__c=acct.Direccion2__c;
                           
                            auto.tipo__c = autorizacion.tipo__c;
                            auto.idoferta__c=acct.id;
                            if ((acct.Estado__c!=null)&&(acct.Ciudad_Tabla__c!=null))
                            {
                                edoc=[select name from estados__c where id=:acct.Estado__c];
                                edo=edoc.name;
                                auto.Estado__c=edoc.name;
                                cdc=[select name from ciudad__c where id=:acct.Ciudad_Tabla__c];
                                cd=cdc.name;
                                auto.ciudad__c=cdc.name;

                                auto.preciov__c=100000; //esto lo define el proceso de leads
                                insert auto;
                                insertado=true;
                            res=auto.id;
                            tipo=auto.tipo__c;
                            cla =auto.CLABE__c;
                           
                            }

                             if (auto.preciov__c==null)
                            {
                                auto.preciov__c=100000; //esto lo define el proceso de leads
                            }
                            pv=auto.preciov__c;
}                            
                  

                    
                        gastos=[select costos__c,broker__c,plus__c,margenneto__c,margenreferencia__c, preciov__c,comisioncomercial__c,comisiongerente__c, Beneficio__c from autorizacion__c where id=:res];
                        if (acct.CosteAdeudos__c==null)
                        {
                            acct.CosteAdeudos__c=0;
                        }
                        if (acct.CosteAdeudosVenta__c==null)
                        {
                            acct.CosteAdeudosVenta__c=0;
                        }
                        if (acct.CosteHonorariosNotaria__c==null)
                        {
                            acct.CosteHonorariosNotaria__c=0;
                        }
                        if (acct.CosteImpuestosNotaria__c==null)
                        {
                           acct.CosteImpuestosNotaria__c=0;
                        }
                        if (acct.CosteDesalojo2__c==null)
                        {
                            acct.CosteDesalojo2__c=0;
                        }
                        if (acct.CosteRehabilitacion__c==null)
                        {
                            acct.CosteRehabilitacion__c=0;
                        }
                        if (acct.Saneamiento__c==null)
                        {
                            acct.Saneamiento__c=0;
                        }
                        if (acct.PrecioCompra__c==null)
                        {
                            acct.PrecioCompra__c=0;
                        }
                        if (autorizacion.plus__c==null)
                        {
                            autorizacion.plus__c=0;
                            
                        }
                        if (autorizacion.comisiongerente__c==null)
                        {
                            autorizacion.comisiongerente__c=0;
                        }
                        if (autorizacion.comisioncomercial__c==null)
                        {
                            autorizacion.comisioncomercial__c=0;
                        }  
                        ine=pv-(autorizacion.plus__c+acct.CosteDesalojo2__c);
                        if ((autorizacion.broker__c!=null)&&(autorizacion.broker__c!=0)&&(gastos.preciov__c!=null)&&(ine!=null))
                               { 
                                gastos.comisioncomercial__c=(ine)*(autorizacion.broker__c);
                               } 
                        if (gastos.comisioncomercial__c==null)
                        {
                            gastos.comisioncomercial__c=0;
                        }

                        gastos.costos__c=(acct.PrecioCompra__c+acct.CosteAdeudos__c+acct.CosteAdeudosVenta__c+acct.CosteHonorariosNotaria__c+acct.CosteImpuestosNotaria__c+acct.CosteDesalojo2__c+acct.CosteRehabilitacion__c+autorizacion.Comisiongerente__c+gastos.Comisioncomercial__c+autorizacion.Plus__c)-(acct.Saneamiento__c);
                        gastos.Beneficio__c=(pv-gastos.costos__c);
                        gastos.margenneto__c=((pv/gastos.costos__c)-1)*100;
                        if (ine!=null)
                        {
                        gastos.margenreferencia__c=((ine)/(acct.ValorReferencia__c))*100;
                        }
                        update gastos;
                    }
                        public void estatus()
                        {
                        estatus = [select estatus__c,Montogasto__c,creado__c,acompra__c,createdbyid,montocarta__c,Concepto__c,Comentarios_Gasto__c,beneficio__c,fecha2__c, cdesalojo__c,broker__c, comisioncomercial__c,comisiongerente__c,margenneto__c,cadeudos__c,fecha__c, rehabilitacion__c from autorizacion__c where id=:res];
                        creador = [select name from user where id =:estatus.createdbyid];
                        estatus.creado__c=creador.name;
                        estatus.fecha2__c=myf;
                        fecha=system.now().format();
                        estatus.fecha__c=fecha;
                        estatus.estatus__c='pendiente';
                        if (tipoo =='ofertas')
                        {
                        estatus.costos__c=gastos.costos__c;
                        estatus.acompra__c=acct.CosteAdeudos__c;
                        estatus.cdesalojo__c=acct.CosteDesalojo2__c;
                        estatus.rehabilitacion__c=acct.CosteRehabilitacion__c;
                        estatus.cadeudos__c=acct.CosteAdeudosVenta__c;
                        estatus.comisiongerente__c=autorizacion.comisiongerente__c;
                        estatus.broker__c=autorizacion.broker__c;
                        estatus.comisioncomercial__c=gastos.comisioncomercial__c;
                        estatus.margenneto__c=gastos.margenneto__c;
                        estatus.beneficio__c=gastos.beneficio__c;
                        }

                        update estatus;
                        }
}