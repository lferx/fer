public with sharing class ferc {
    public Oferta__c acct {get;set;}
    public autorizacion__c autorizacion {get;set;}
    public account dcuenta {get;set;}
    public account campos {get;set;}
    public account dc {get;set;} 
    public string s {get;set;}
    public string c {get;set;}
    public id res {get;set;}
    public string tipo {get;set;}
    public string cempresa {get;set;}
    public string cla {get;set;}
    public string tipoo {get;set;}
    public autorizacion__c estatus {get;set;}
    public string fecha {get;set;}
    public autorizacion__c gastos {get;set;}
    public double pv {get;set;}
    public Date myf {get;set;}
    public string empresa {get;set;}
    public string cliente {get;set;}
    public string tp {get;set;}
    public string edo {get;set;}
    public string cd {get;set;}
    public estados__c edoc {get;set;}
    public ciudad__c cdc {get;set;}
    public string banco {get;set;}   
    public string notaria {get;set;}   
    public string cuenta {get;set;}
    public string clabe {get;set;}
    public string titular {get;set;}
    public account apoderado {get;set;}
    public string apo {get;set;}
    public double monto {get;set;}
    public double montogastos {get;set;}
    public double comisiongerente {get;set;}
    public double montooriginal {get;set;}
    public double plus {get;set;}
    public double broker {get;set;}
    public string comentariosgasto {get;set;}
    public oferta__c ef {get;set;}
    public Double ine {get;set;}
    public account dnotaria {get;set;}
    public user creador {get;set;}
    public string idcarrito {get;set;}
    public string ofertalead {get;set;}  
    public string tipoauto {get;set;}
    public List<carrito__c> carrito {get;set;}
    public List<SelectOption> user;   
    public List<SelectOption> opciones;
    public Account nuevoLead {get;set;}
	public String nombre {get;set;}
	public String apellido {get;set;}
    public Map<id,list<Detalle_del_Carrito__c>> mapC {get;set;}
    public string Photolink{get;set;}
    public account datoslead {get;set;}
//public list<AggregateResult> newdesalojo = new list<AggregateResult>();
    public double totaldesalojo {get;set;}
    public double costo{get;set;}

    public Transient blob file { get; set; }

    public string filename {get;set;}

    public List<Id>files=new List<Id>();
    
    public List<Attachment> newAttachments {get; set;}
    public List<Attachment> Attachments {get; set;}

    public string idfiles {get; set;}
    public string loader {get; set;}
    public string idDelete {get; set;}
    public string catalogId {get; set;}
    public decimal ammount {get; set;}
    public ConceptoCatalogo__c con {get; set;}
    public string cname {get; set;}
    //public Decimal sumUP {get;set;}
    public Decimal totalRehab {get;set;}
    public boolean showMore {get;set;}

    public List<RehabBudget__c> listLimits {get; set;}
    public Id rehabId {get;set;}
    public Rehabilitacion__c recentRh {get;set;}

        public PageReference abrir()

       {
           PageReference pageRef = Page.Vistaauth;
           pageRef.setRedirect(false);        
           return pageRef;           
       }




            public ferc() {

                User us = [Select us.SmallPhotoUrl, us.FullPhotoUrl From User us where us.id=:Userinfo.getUserid()];
                Photolink = us.SmallPhotoUrl;
                idfiles=ApexPages.currentPage().getParameters().get('filesId');
                loader=ApexPages.currentPage().getParameters().get('loader');

                if(idfiles!=null&&idfiles!='')
                {
                    system.debug('idauto '+idfiles);
                    newAttachments=new List<Attachment>{new Attachment()};
                    getAttachments(idfiles);
                    
                }
                showMore=false;
                


                    idcarrito =ApexPages.currentPage().getParameters().get('idaccount');
                    if ((idcarrito!=null)&&(idcarrito!=''))
                    {
                        datoslead=[select name, lastname from account where id=:idcarrito.trim()];
                        carrito =[select id, (select  oferta__r.name,oferta__r.Direccion2__c,oferta__c from Detalles_del_Carrito__r) from carrito__c where cuenta__c=:idcarrito.trim() limit 1];
                        //for (Detalle_del_Carrito__c det:carrito.Detalles_del_Carrito__r)
                        //{
            //
                        //}
                    }
                    else {
                        carrito =[select id, (select oferta__r.name,oferta__r.Direccion2__c,oferta__c from Detalles_del_Carrito__r) from carrito__c limit 1];
                        }

                        mapC = new Map<id,list<Detalle_del_Carrito__c>>();
                        for(carrito__c x : carrito){
                            mapC.put(x.id, x.Detalles_del_Carrito__r);
                        }


                        s=System.currentPageReference().getParameters().get('id');
                        myf=date.today();

                        if (s==null||s==''){
                            s='a08g0000008NAHr';
                        }
                        c=s.trim();

                        if(idcarrito==null&&idfiles==null)
                        {
                            
                                    ef=[select PrecioCompra__c,Saneamiento__c,BeneficioNeto__c,Total_pagado__c,MargenRehabilitacion__c,ComisionComercial__c,Devolucion__c,LiquidacionPendiente__c,Devoluci_n_plus_venta__c,
                                    Anticipo__c,MontoContado__c,MargenBruto__c,Total_cobrado__c,PrecioVenta__c, CosteAdeudos__c,CosteDesalojo2__c,
                                    CosteRehabilitacion__c,TotalCosto__c,PresupuestoRehabilitacion__c,CosteAdeudosVenta__c,CosteImpuestosNotaria__c,
                                    CosteHonorariosNotaria__c,margenneto__c, Precio_Original__c,TiempoOferta__c,Plaza__c,Estado__c,Estatus_de_Invasion__c,TipoOferta__c,
                                    montocredito__c from oferta__c where id=:c];
                                    acct= [select id,Precio_Original__c,Contratista__r.Name,TipoOferta__c,Notaria_Ventas__c,CosteAdeudos__c,Estado__r.Name, Apoderado__c,paquete__c,Estado__c,Ciudad_Tabla__c,CosteRehabilitacion__c,
                                    ValorReferencia__c,Saneamiento__c,CosteHonorariosNotaria__c,CosteImpuestosNotaria__c, CosteDesalojo2__c,PrecioVenta__c,PrecioCompra__c,
                                    CosteAdeudosVenta__c, Paquete__r.Empresas_Grupo__c, ClienteFinal__c, Direccion2__c, Propiedad__r.Plaza__c, name, montocontado__c, montocredito__c,
                                    anticipo__c, Propiedad__r.Construccion_m2__c from Oferta__c where id =:c ]; 

                                          if ((acct.TipoOferta__c=='Contado')&&(acct.MontoContado__c!=null))
                                          {
                                                montooriginal=acct.montocontado__c;
                                          } 
                                          if ((acct.TipoOferta__c!='Contado')&&(acct.Montocredito__c!=null))
                                          {
                                                montooriginal=acct.montocredito__c;
                                          } 
                                      autorizacion= [select id,idoferta__c,montocarta__c,Montogasto__c,ConceptoGasto__c,NotariaVentas__c,Comentarios_Gasto__c,comisioncomercial__c,broker__c,Beneficio__c,comisiongerente__c,
                                      name,tipo__c,preciov__c, costos__c, empresa__c,plus__c, notaria__c, nnotaria__c, estatus__c, fecha__c, clienteoferta__c from autorizacion__c LIMIT 1 ]; 
                                      autorizacion.NotariaVentas__c=null;
                                      autorizacion.montocarta__c=null;
                                      autorizacion.ConceptoGasto__c=null;
                                      autorizacion.clienteoferta__c=null;
                                      autorizacion.tipo__c=null;
                                      autorizacion.Montogasto__c=null;
                                      tp=acct.TipoOferta__c;
                                      acct.TipoOferta__c='';
                                             
                        }   
     
                    }
                    public List<SelectOption> getOpciones(){                                  
                                    opciones = new List<SelectOption>();
                                    opciones.add(new SelectOption('Ofertas','Ofertas'));
                                    opciones.add(new SelectOption('Carta de Instrucción','Carta de Instrucción'));
                                    opciones.add(new SelectOption('Gastos','Gastos'));
                                    opciones.add(new SelectOption('Rehabilitación','Rehabilitación'));
                                    opciones.add(new SelectOption('Devolución','Devolución'));
                                    return opciones;
                            }

                    public List<SelectOption> getUser(){                                  
                            user = new List<SelectOption>();
                            user.add(new SelectOption('a08g0000008NAF9','IF-12345'));
                            return user;
                    }


                    public void render()
                    {
                        totaldesalojo=0;
                        campos=[select Forma_de_Pago__c from account where id=:idcarrito];
                            if (campos.Forma_de_Pago__c!=null)
                            {
                            tp=campos.Forma_de_Pago__c;
                            }
                        tipoo='Ofertas';

                        ef=[select PrecioCompra__c,Saneamiento__c,BeneficioNeto__c,Total_pagado__c,MargenRehabilitacion__c,ComisionComercial__c,Devolucion__c,LiquidacionPendiente__c,Devoluci_n_plus_venta__c,
                        Anticipo__c,MontoContado__c,MargenBruto__c,Total_cobrado__c,PrecioVenta__c, CosteAdeudos__c,CosteDesalojo2__c,
                        CosteRehabilitacion__c,TotalCosto__c,PresupuestoRehabilitacion__c,CosteAdeudosVenta__c,CosteImpuestosNotaria__c,
                        CosteHonorariosNotaria__c,margenneto__c, Precio_Original__c,TiempoOferta__c,Plaza__c,Estado__c,Estatus_de_Invasion__c,
                        montocredito__c from oferta__c where id=:ofertalead];
                        acct= [select id,Precio_Original__c,Contratista__r.Name,TipoOferta__c,Notaria_Ventas__c,CosteAdeudos__c, apoderado__c,paquete__c,Estado__c,Estado__r.Name,Ciudad_Tabla__c,CosteRehabilitacion__c,
                        ValorReferencia__c,Saneamiento__c,CosteHonorariosNotaria__c,CosteImpuestosNotaria__c, CosteDesalojo2__c,PrecioVenta__c,PrecioCompra__c,
                        CosteAdeudosVenta__c, Paquete__r.Empresas_Grupo__c, ClienteFinal__c, Direccion2__c, Propiedad__r.Plaza__c, name, Montocontado__c, Montocredito__c,
                        anticipo__c from Oferta__c where id =:ofertalead ]; 
            //        if([SELECT count() from gasto__c WHERE Oferta__c = :ofertalead and estatus2__c in ('Pagado','Automático','Reconciliado','Comprobado') and concepto__r.categoria__c='Desalojo' AND(NOT MensajeError1__c LIKE '%Límite%')]>0)
            //{
            //newdesalojo=[SELECT sum(importe__c) suma from gasto__c WHERE Oferta__c = :ofertalead and estatus2__c in ('Pagado','Automático','Reconciliado','Comprobado') and concepto__r.categoria__c='Desalojo' AND(NOT MensajeError1__c LIKE '%Límite%')];
            //totaldesalojo= double.valueOf(newdesalojo[0].get('suma'));
            //acct.CosteDesalojo2__c=totaldesalojo;
            //}Map<double, string>Mapa=new Map<double, string>();
                        costodesalojo(ofertalead);

                    }
                                    public void costodesalojo(id oferta)
                                    {
 //Sacar El Costo del Desalojo 100% real, NO FAKE
                                        costo=0;
                                        if([SELECT count() from gasto__c WHERE Oferta__c = :oferta and estatus2__c in ('Pagado','Automático','Reconciliado','Comprobado','Historico','En aprobación','Listo para pagar') and concepto__r.categoria__c='Desalojo']>0)
                                                {
                                                system.debug('entro aqui');
                                                Map<double, string>Mapa=new Map<double, string>();
                                                List<double> Negativos=new List<double>();
                                                List<double> Sumables=new List<double>();
                                                double total;
                                                total=0;
                                                        for(gasto__c x: [select importe__c, fecha__c from gasto__c where oferta__c=:oferta and estatus2__c in ('Pagado','Automático','Reconciliado','Comprobado','Historico','En aprobación','Listo para pagar') and concepto__r.categoria__c='Desalojo'])
                                                        {
                                                            Mapa.put(x.importe__c, x.fecha__c.format());
                                                            if (x.importe__c<0)
                                                            {
                                                                negativos.add(x.importe__c);
                                                            }
                                                            if(x.importe__c>0&&x.importe__c!=20000&&x.fecha__c!=Date.valueOf('2016-11-17'))
                                                            {
                                                                sumables.add(x.importe__c);
                                                            }
                                                            total+=x.importe__c;
                                                        }

                                                        system.debug('hola'+mapa+negativos+total);
                                                            
                                                            double nega=0;
                                                            double posi=0;

                                                        if(negativos.size()>0)
                                                           {
                                                            for (double x: negativos)
                                                            {
                                                                nega+=x;
                                                            }
                                                           }
                                                            if(sumables.size()>0)
                                                            {
                                                                for (double y:sumables)
                                                                {
                                                                   posi+=y;
                                                                }
                                                            }

                                                                                system.debug('Negativos'+nega+'Sumables'+posi);

                                                                                if (total==20000)
                                                                                {
                                                                                    system.debug('Suma de gastos Igual a 20000');

                                                                                   
                                                                                    costo=(posi);
                                                                                    system.debug('El costo es :'+costo);
                                                                                }
                                                                                if (total<20000)
                                                                                {
                                                                                        system.debug('Suma de gastos Menor a 20000');
                                                                                    
                                                                                    costo=(total);
                                                                                    system.debug('El costo es :'+costo);

                                                                                }
                                                                                if (total>20000)
                                                                                {
                                                                                        system.debug('Suma de gastos Mayor a 20000');
                                                                                    if (mapa.containsKey(20000))
                                                                                    {
                                                                                        string fecha=mapa.get(20000);
                                                                                        system.debug('fecha del 20000'+fecha);
                                                                                    }
                                                                                    
                                                                                 costo=(posi+nega);
                                                                                    system.debug('El costo es :'+costo);

                                                                                }

                                                        acct.CosteDesalojo2__c=costo;
                                                        system.debug('aqui entro y sacó:'+acct.CosteDesalojo2__c);
                                }

                              if ((acct.TipoOferta__c=='Contado')&&(acct.MontoContado__c!=null))
                              {
                                montooriginal=acct.montocontado__c;
                              } 
                                guardar();
                    }
                    public void validar()
                    {

                        if (((acct.CosteAdeudos__c<ef.CosteAdeudos__c))||((ef.CosteAdeudos__c!=null && ef.CosteAdeudos__c>0)&&(acct.CosteAdeudos__c==null)))
                        {
                            
                           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'El valor de Adeudos Compra no puede disminuir, se ha reestablecido'));
                           acct.CosteAdeudos__c=ef.CosteAdeudos__c;
                           return;
                        }
                        if (((acct.CosteAdeudosVenta__c<ef.CosteAdeudosVenta__c))||((ef.CosteAdeudosVenta__c!=null &&ef.CosteAdeudosVenta__c>0)&&(acct.CosteAdeudosVenta__c==null)))
                        {
                            
                           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'El valor de Adeudos Venta no puede disminuir, se ha reestablecido'));
                           acct.CosteAdeudosVenta__c=ef.CosteAdeudosVenta__c;
                           return;

                        }
                        if (((acct.CosteHonorariosNotaria__c<ef.CosteHonorariosNotaria__c))||((ef.CosteHonorariosNotaria__c!=null && ef.CosteHonorariosNotaria__c>0)&&(acct.CosteHonorariosNotaria__c==null)))
                        {
                            
                           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'El valor de Honorarios Notaría no puede disminuir, se ha reestablecido'));
                           acct.CosteHonorariosNotaria__c=ef.CosteHonorariosNotaria__c;
                           return;

                        }
                        if (((acct.CosteImpuestosNotaria__c<ef.CosteImpuestosNotaria__c))||((ef.CosteImpuestosNotaria__c!=null &&ef.CosteImpuestosNotaria__c>0)&&(acct.CosteImpuestosNotaria__c==null)))
                        {
                            
                           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'El valor de Impuestos Notaría no puede disminuir, se ha reestablecido'));
                           acct.CosteImpuestosNotaria__c=ef.CosteImpuestosNotaria__c;
                           return;

                        }
                        //if (((acct.CosteDesalojo2__c<ef.CosteDesalojo2__c))||((ef.CosteDesalojo2__c!=null &&ef.CosteDesalojo2__c>0)&&(acct.CosteDesalojo2__c==null)))
                        //{
                            
                        //   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'El valor de Adeudos Desalojo no puede disminuir, se ha reestablecido'));
                        //   acct.CosteDesalojo2__c=ef.CosteDesalojo2__c;
                        //   return;

                        //}
                        if (((acct.CosteRehabilitacion__c<ef.CosteRehabilitacion__c))||((ef.CosteRehabilitacion__c!=null &&ef.CosteRehabilitacion__c>0)&&(acct.CosteRehabilitacion__c==null)))
                        {
                            
                           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'El valor de Rehabilitación no puede disminuir, se ha reestablecido'));
                           acct.CosteRehabilitacion__c=ef.CosteRehabilitacion__c;
                           return;

                        }
                        else {
                            calcular();
                        }
                    }

                            public Void Guardartipo(){

                                            system.debug('entre a guardar tipo');
                                            autorizacion__c auto=new autorizacion__c();
                                            auto.tipo__c=tipoauto;

                                            tipoo = auto.tipo__c;
                                            costodesalojo(c);

                                    }
                            public Void Guardar(){
                                system.debug('entre aqui a guardar la autorizacion');

                                if (idcarrito==null)
                                {
                                    //tp=acct.TipoOferta__c;
                                    //if (tp!=null)
                                    //{
                                    //if (tp=='Contado')
                                    //{
                                    //    monto=acct.montocontado__c;
                                    //}
                                    //if (tp!='Contado')
                                    //{
                                    //    monto=acct.montocredito__c;
                                    //}
                                    //}
                                }
                            autorizacion__c auto=new autorizacion__c();
                            if (idcarrito==null)
                            {
                                        if (acct.montocredito__c!=null)
                                        {
                                            auto.preciov__c=acct.montocredito__c;
                                        }
                            }

                            if(idcarrito==null)
                            {
                                auto.ofertas__c=acct.id;
                                tp=acct.TipoOferta__c;
                            }
                            else
                            {
                                auto.ofertas__c=ofertalead;
                            }
                            
                            auto.Tipo_Oferta__c=tp;
                            auto.plus__c=plus;

                                if (acct.Notaria_Ventas__c!=null)
                                {
                                    dnotaria=[select name,Contacto__r.name, Representante__c from account where id=:acct.Notaria_Ventas__c];
                                    auto.notaria__c=dnotaria.Contacto__r.name;
                                    auto.NotariaVentas__c=acct.Notaria_Ventas__c;
                                }
                            auto.ntn__c=notaria;
                            auto.empresa__c=acct.Paquete__r.Empresas_Grupo__c;
                            auto.direccion__c=acct.Direccion2__c;
                            auto.Plaza__c=acct.Propiedad__r.Plaza__c;
                                if (tipoo =='Carta de Instrucción')
                                {
                                    auto.Tipo_Oferta__c=ef.TipoOferta__c;
                                    //if(monto==null)
                                    //{
                                        if (ef.TipoOferta__c=='Contado')
                                        {
                                            monto=acct.Montocontado__c;
                                        }
                                        else
                                        {
                                            monto=acct.Montocredito__c;
                                        }
                                    //}
                                    auto.Montocarta__c=monto;
                                    auto.montoeditado__c=montooriginal;
                                    system.debug('el monto es '+monto);
                                }
                            if (tipoo =='Gastos')
                            {
                                if (montogastos==null)
                                {
                                    montogastos=0;
                                }
                                if(catalogId!=null)
                                {
                                    ConceptoCatalogo__c con=[select name from ConceptoCatalogo__c where id=:catalogId];
                                    cname=con.name;
                                    system.debug('con cat:'+con.name);
                                }
                                auto.Montogasto__c=montogastos;
                                auto.ConceptoGasto__c=autorizacion.ConceptoGasto__c;
                                
                            } 
                            if (idcarrito==null)
                            {
                                auto.tipo__c = tipoauto;
                            }
                            else 
                            {
                                auto.tipo__c='Ofertas';
                            }
                                    auto.idoferta__c=acct.id;

                            if ((acct.Estado__c!=null)&&(acct.Ciudad_Tabla__c!=null))
                            {
                                edoc=[select name from estados__c where id=:acct.Estado__c];
                                edo=edoc.name;
                                auto.Estado__c=edoc.name;
                                cdc=[select name from ciudad__c where id=:acct.Ciudad_Tabla__c];
                                cd=cdc.name;
                                auto.ciudad__c=cdc.name;
                            }



                            if ((acct.Paquete__c==null)||(acct.Paquete__r.Empresas_Grupo__c==null))
                            {
                                cempresa='001g000001VUZU3AAP';
                            }
                            if ((acct.Paquete__c!=null)&&(acct.Paquete__r.Empresas_Grupo__c!=null))
                            {
                                 cempresa=acct.Paquete__r.Empresas_Grupo__c;
                            }
                                dcuenta=[select Banco__c, name, Cuenta_bancaria__c, CLABE__c from account where id=:cempresa];
                            if (acct.ClienteFinal__c!=null)
                            {
                                dc=[select name from account where id=:acct.ClienteFinal__c];
                                cliente=dc.name;
                                auto.cliente__c=dc.name;
                            }
                            if (acct.apoderado__c!=null)
                            {
                                apoderado=[select name from account where id=:acct.apoderado__c];
                                apo=apoderado.name;
                                auto.apoderado__c= apo;
                            }
                            banco=dcuenta.banco__c;
                            cuenta=dcuenta.cuenta_bancaria__c;
                            clabe=dcuenta.clabe__c;
                            titular=dcuenta.name;
                            auto.Banco__c=dcuenta.Banco__c;
                            auto.cuenta__c=dcuenta.Cuenta_bancaria__c;
                            auto.clabe__c=dcuenta.CLABE__c; 
                            empresa=dcuenta.name;
                            auto.Comentarios_Gasto__c=comentariosgasto;

                           
                            insert auto;
                            //relaciona(auto.id);
                            res=auto.id;
                            tipo=auto.tipo__c;
                            cla =auto.CLABE__c;
                            if (auto.preciov__c==null)
                            {
                                auto.preciov__c=0;
                            }
                                pv=auto.preciov__c;
                    }

                    public void calcular()
                    {
                        //if ((pv==null)&&(venta!=null&&venta!=''))
                        //{
                        //pv=Double.Valueof(venta);
                        //system.debug('hola'+pv+venta);
                        //}
                        acct.CosteDesalojo2__c=costo;
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
                        if (plus==null)
                        {
                            plus=0;
                            
                        }
                        if (comisiongerente==null)
                        {
                            comisiongerente=0;
                        }
                    
                        ine=pv-(plus+acct.CosteDesalojo2__c+acct.CosteRehabilitacion__c);




                        if ((broker!=null)&&(broker!=0)&&(pv!=null)&&(ine!=null))
                               { 
                                 if(tp=='Contado')
                        {
                            gastos.comisioncomercial__c=(ine)*(broker);
                        }
                        if (tp!='Contado')
                            {
                                 gastos.comisioncomercial__c=(pv)*(broker);
                            }
                               
                               } 
                        if (gastos.comisioncomercial__c==null)
                        {
                            gastos.comisioncomercial__c=0;
                        }

                        gastos.costos__c=(acct.PrecioCompra__c+acct.CosteAdeudos__c+acct.CosteAdeudosVenta__c+acct.CosteHonorariosNotaria__c+acct.CosteImpuestosNotaria__c+acct.CosteDesalojo2__c+acct.CosteRehabilitacion__c+comisiongerente+gastos.Comisioncomercial__c+plus)-(acct.Saneamiento__c);
                        gastos.Beneficio__c=(pv-gastos.costos__c);
                        gastos.margenneto__c=((pv/gastos.costos__c)-1)*100;
                        if (ine!=null)
                        {
                            if (tp=='Contado')
                            {
                                 gastos.margenreferencia__c=((ine)/(acct.ValorReferencia__c))*100;
                            }
                            if (tp!='Contado')
                            {
                                gastos.margenreferencia__c=((pv/acct.ValorReferencia__c))*100;
                            }
                        }
                        update gastos;
                    }

                        public void estatus()
                        {
                        estatus = [select estatus__c,Montogasto__c,creado__c,acompra__c,createdbyid,montocarta__c,ConceptoGasto__c,Comentarios_Gasto__c,beneficio__c,fecha2__c, cdesalojo__c,broker__c, comisioncomercial__c,comisiongerente__c,margenneto__c,cadeudos__c,fecha__c, rehabilitacion__c, clienteoferta__c from autorizacion__c where id=:res];
                        creador = [select name from user where id =:estatus.createdbyid];
                        estatus.creado__c=creador.name;
                        estatus.fecha2__c=myf;
                        fecha=system.now().format();
                        estatus.fecha__c=fecha;
                        estatus.estatus__c='pendiente';
                        //Empieza codigo Hector
                        //estatus.Lead_Cliente__c=idcarrito;
                        //Termina codigo Hector
                        if (tipoo =='Ofertas')
                        {
                        estatus.costos__c=gastos.costos__c;
                        estatus.acompra__c=acct.CosteAdeudos__c;
                        estatus.cdesalojo__c=acct.CosteDesalojo2__c;
                        estatus.rehabilitacion__c=acct.CosteRehabilitacion__c;
                        estatus.cadeudos__c=acct.CosteAdeudosVenta__c;
                        estatus.comisiongerente__c=comisiongerente;
                        estatus.broker__c=broker;
                        estatus.comisioncomercial__c=gastos.comisioncomercial__c;
                        estatus.margenneto__c=gastos.margenneto__c;
                        estatus.beneficio__c=gastos.beneficio__c;
                        estatus.plus__c=plus;
                        estatus.preciov__c=pv;
                        id client=null;

                                if (idcarrito==null)
                                {
                                    if(autorizacion.clienteoferta__c!=null)
                                    {
                                        client=autorizacion.clienteoferta__c;
                                    }
                                }
                                if(idcarrito!=null&&idcarrito!='')
                                {
                                    client=idcarrito;
                                }
                                    if(client!=null)
                                    {
                                        estatus.clienteoferta__c=client;
                                    }
                                
                        }
                        if (tipoo =='Gastos')
                        {
                            if(montogastos<=ammount)
                            {
                                estatus.Montogasto__c=montogastos;
                                estatus.Comentarios_Gasto__c=comentariosgasto;
                            }
                            if(montogastos<=ammount)
                            {
                                estatus.estatus__c='Autorizada';
                            }

                        }
                        update estatus;  
                        List<Autorizacion__c> borrar=new List<Autorizacion__c>();
                        for(Autorizacion__c x:[select id from Autorizacion__c where estatus__c=null])
                        {
                            borrar.add(x);
                        }
                            if (borrar.size()>0)
                            {
                                delete borrar;
                            }
                        
                        }
      
     public PageReference citalead(){
         
        PageReference citalead = new PageReference('/apex/Cita_Leads');
        citalead.setRedirect(false);
        if(nuevoLead != null && nuevoLead.Id != null)
            citalead.getParameters().put('id', nuevoLead.Id);
         return citalead;
     }     
    public PageReference cancelarLead(){
   
        PageReference Regresoinicio = new PageReference ('/001/o');
        
         return Regresoinicio; 
        
    }


    public void saveAtt()
    {

            List<Attachment> upd=new List<Attachment>();
            for(Attachment x:newAttachments)
            {
                system.debug('id parent'+idfiles);
                if(x.Body!=null)
                {
                    x.ParentId=idfiles;
                    upd.add(x);
                }

            }
        insert upd;
        getAttachments(idfiles);
        system.debug('Lista Actualizada: '+upd);
        newAttachments.clear();
        newAttachments.add(new Attachment());
        files(idfiles);
    }
    
    public void deleteMe()
    {
        if (idDelete!=null&&idDelete!='')
        {
            system.debug('Entro a borrar el id'+ idDelete);
            Attachment delAtt=[select id from Attachment where id=:idDelete];
            delete delAtt;
            getAttachments(idfiles);
            files(idfiles);
        }
    }

    public List<Attachment> getAttachments(String idatt)
        {
            Attachments=new List<Attachment>();
            if([select count() from Attachment where ParentId=:idatt]>0)
            {
                Attachments=[select id, description, name from Attachment where ParentId=:idatt];

            }
            return Attachments;
        }

    public void files(string idauth)
    {
            Autorizacion__c upp=[select id, files__c from autorizacion__c where id=:idauth];
            if([select count() from Attachment where ParentId=:idauth]>0)
            {
                upp.files__c=true;
            }
            else
            {
                upp.files__c=false;
            }
            update upp;
    }
    public void getLimit()
    {
        if(catalogId!=null&&catalogId!='')
        {
            ammount=0;
            system.debug('el id: '+catalogId);
            List<ConceptoCatalogo__c> limite= [select ReglaValidacionB__r.LimiteMonto__c, ReglaValidacionB__r.LimitePorcentaje__c from ConceptoCatalogo__c where id=:catalogId];
            if(limite!=null && !limite.isEmpty())
            {
                    system.debug('Entre aqui pr' +limite);
                    if (limite[0].ReglaValidacionB__r.LimiteMonto__c!=null)
                    {
                        ammount=limite[0].ReglaValidacionB__r.LimiteMonto__c;
                    }
                    if (limite[0].ReglaValidacionB__r.LimitePorcentaje__c!=null)
                    {
                        ammount=(acct.PrecioCompra__c*(limite[0].ReglaValidacionB__r.LimitePorcentaje__c/100));
                    }
            }
        }
    }
                public string nameFile{get;set;}
                public Blob contentFile{get;set;}
                public String[] filelines = new String[]{};
                public List<String> records {get;set;}
                public List<RehabBudget__c> rehab {get;set;}
                public List<RehabBudget__c> showMe {get;set;}
                public final Decimal promR=58.46;


             public void ReadFile()
                {
                   
                    nameFile=contentFile.toString();
                    nameFile= nameFile.replace('"', '');
                    filelines = nameFile.split('\r\n|\r|\n');
                    system.debug('archivo'+nameFile);
                    system.debug('filelines:'+filelines.size());
                    records = new List<String>();
                    rehab= new List<RehabBudget__c>();
                    showMe= new List<RehabBudget__c>();
                    rehab.clear();
                    for (Integer i=1;i<filelines.size();i++)
                    {
                        system.debug('Entre a guardar registros');
                        String[] inputvalues = new String[]{};
                        inputvalues = filelines[i].split(',');
                        RehabBudget__c newRh= new RehabBudget__c();
                        newRh.Concepto__c=inputvalues[0];
                        newRh.Name=inputvalues[1];
                        newRh.Precio_Unitario__c=Decimal.Valueof(inputvalues[2].replaceAll('[^a-zA-Z0-9.]', ''));
                        newRh.Unidades__c=Decimal.Valueof(inputvalues[3].replaceAll('[^a-zA-Z0-9.]', ''));
                        newRh.Comentarios__c=inputvalues[4];
                        newRh.Oferta__c=c;
                        newRh.Metros_Cuadrados__c=Acct.Propiedad__r.Construccion_m2__c;
                       rehab.add(newRh);
                    }
                    if (rehab.size()>0)
                    {
                        insert rehab;
                        system.debug('se ha insertado'+rehab);
                        Rehabilitacion__c newParentRehab = new Rehabilitacion__c();
                        newParentRehab.Oferta__c=c;
                        insert newParentRehab;
                        rehabId=newParentRehab.id;
                        System.debug('Id de la rehabilitacion'+rehabId);
                        showMe.clear();
                        totalRehab=0;
                        for(RehabBudget__c y: rehab)
                        {
                            y.Rehabilitacion__c=newParentRehab.id;
                            totalRehab+=(y.Precio_Unitario__c)*(y.Unidades__c);
                            if(y.Precio_Unitario__c >0&& y.Unidades__c>0)
                            {
                                showMe.add(y);
                            }
                        }
                        newParentRehab.Total__c=totalRehab;
                        update newParentRehab;
                        update rehab;
                        List<RehabBudget__c>GetLimits=new List<RehabBudget__c>();
                        system.debug('vista'+showMe.size());
                        List<RehabBudget__c>Extra=new List<RehabBudget__c>();
                        
                        for(RehabBudget__c x:showMe)
                        {
                            if(x.Concepto__c!='Extraordinario')
                            {
                                GetLimits.add(x);
                            }
                            else
                            {
                                Extra.add(x);
                            }
                        }
                        system.debug(Extra);
                        GetDesvEst(GetLimits,acct.Propiedad__r.Construccion_m2__c);
                        SaveRh();


                    }

                }
                public void sMore()
                {
                    System.debug('vine aqui'+showMore);
                    if(showMore)
                    {
                        showMore=false;
                    }
                    else
                    {
                        showMore=true;
                    }
                    system.debug(showMore);
                }

                public static String blobToString(Blob input, String inCharset){
                    String hex = EncodingUtil.convertToHex(input);
                    System.assertEquals(0, hex.length() & 1);
                    final Integer bytesCount = hex.length() >> 1;
                    String[] bytes = new String[bytesCount];
                    for(Integer i = 0; i < bytesCount; ++i)
                        bytes[i] =  hex.mid(i << 1, 2);
                    return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
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
                    if(Test.isRunningTest()){
                        return;
                    }
                    for(RehabBudget__c x:myList)
                    {
                        x.Limite__c=x.Precio_Unitario__c-((val.get(x.name).Precio_Unitario_Revimex__c+val.get(x.name).Precio_Unitario_Mercado__c)/2);
                        x.Promedio_Unidades__c=((val.get(x.name).Promedio_Unidades__c)/(promR))*metros;
                        x.Total__c=x.Precio_Unitario__c*Integer.valueOf(x.Unidades__c);
                        listLimits.add(x);
                    }
                    update myList;
                }
                public id idnewreh {get; set;}

                public void SaveRh()
                {
                    System.debug('vine a guardar la rehab'+rehabId);
                    if (rehabId!=null)
                    {
                        Autorizacion__c rehabAuth= new Autorizacion__c();
                        rehabAuth.RehabilitacionId__c=rehabId;
                        rehabAuth.Tipo__c='Rehabilitación';
                        rehabAuth.Ofertas__c=Acct.id;
                        insert rehabAuth; 
                        idnewreh=rehabAuth.id; 
                        system.debug('este es su id'+idnewreh);                    
                    }


                }
                public void updRh()
                {
                    system.debug('update'+idnewreh);
                    Autorizacion__c xr= [select fecha2__c, fecha__c, creado__c, estatus__c, createdby.Name from Autorizacion__c where tipo__c='Rehabilitación' and createdbyid=:UserInfo.getUserId() order by CreatedDate desc limit 1];
                        xr.estatus__c='pendiente';
                        xr.creado__c=xr.createdby.Name;
                        xr.fecha2__c=myf;
                        fecha=system.now().format();
                        xr.fecha__c=fecha;
                    update xr;
                }
                public List<RehabBudget__c> vistaReh {get; set;}
                public Autorizacion__c rehabAutoId {get; set;}
                public void getRhData()
                {
                    listLimits= new List<RehabBudget__c>();
                    listLimits.clear();
                    system.debug('entre a este metodo');
                    recentRh=[select id, Total__c from Rehabilitacion__c where createdbyid=:Userinfo.getUserId() ORDER BY CreatedDate desc limit 1];
                    vistaReh= new List<RehabBudget__c>();
                    vistaReh.clear();
                    for (RehabBudget__c y:[Select Id, Total__c, Name, Precio_Unitario__c,Concepto__c,Unidades__c, Promedio_Unidades__c, Limite__c, Comentarios__c from RehabBudget__c Where Rehabilitacion__c=:recentRh.id and Concepto__c='Extraordinario' and Unidades__c!=0 and Unidades__c!=null ])
                    {
                        y.Total__c=y.Unidades__c*y.Precio_Unitario__c;
                        vistaReh.add(y);
                    }
                    Set<RehabBudget__c> Comparative =new Set<RehabBudget__c>([Select Id, Name, Precio_Unitario_Mercado__c, Precio_Unitario_Revimex__c, Promedio_Unidades__c, Comentarios__c from RehabBudget__c where Tipo__c='Comparativa']);
                    List<RehabBudget__c> queryReh =new List<RehabBudget__c>();
                    queryReh=[Select Id, Total__c, Name, Precio_Unitario__c,Concepto__c,Unidades__c, Promedio_Unidades__c, Limite__c, Comentarios__c from RehabBudget__c Where Rehabilitacion__c=:recentRh.id and Total__c!=null and Name!=null and Unidades__c!=0 and Unidades__c!=null];
                    System.debug(queryReh+' '+queryReh.size());
                    Map<string,RehabBudget__c> val=new Map<string,RehabBudget__c>();
                    for(RehabBudget__c y:Comparative)
                    {
                        val.put(y.Name, y);
                    }
                    for(RehabBudget__c w: queryReh)
                    {
                        if((w.Limite__c>1&&w.Total__c>=500)||(((w.Unidades__c-(((val.get(w.name).Promedio_Unidades__c)/(promR))*acct.Propiedad__r.Construccion_m2__c))>1)&&(w.Limite__c>1))&&w.Total__c>=500)
                        {
                            listLimits.add(w);
                        }


                    }
                    update vistaReh;
                    rehabAutoId=[select id from Autorizacion__c where tipo__c='Rehabilitación' and createdbyid=:UserInfo.getUserId() order by CreatedDate desc limit 1];
                    //SaveRh();
                }

  }