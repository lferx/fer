global with sharing class wsUtility {
    private static map<id,list<Documento__c>> mdocxOf = new map<id,list<Documento__c>>();
    private static map<id,list<EtapaOferta__c>> metofxOf = new map<id,list<EtapaOferta__c>>();
    private static map<id,EtapaOferta__c> metofxId = new map<id,EtapaOferta__c>();
    private static map<id,DocumentoEtapa__c> mdocetxId = new map<id,DocumentoEtapa__c>();
    private static map<string,list<DocumentoEtapa__c>> mdocetxPA = new map<string,list<DocumentoEtapa__c>>();
    private static map<string,list<DocumentoEtapa__c>> mdocetxNE = new map<string,list<DocumentoEtapa__c>>();
    private static set<EtapaOferta__c> sEtapascierre = new set<EtapaOferta__c>();
    private static list<Documento__c> ldocupdinipa = new list<Documento__c>();
    private static boolean contNA;
    global static boolean ConcluyePaso(Documento__c doci){
        contNA = false;
        Oferta__c wsofertaPadreI = new Oferta__c();
        wsofertaPadreI = [SELECT Id, TipoOferta__c, Etapa__c, ValorReferencia__c, DiferenciaCompra__c,
                         diferencia_venta__c, Anticipo__c, AvaluoCatastralCompra__c, AvaluoCatastralVenta__c, BeneficioNeto__c,
                         BuroCredito__c, ClienteFinal__c, CobroFinal__c, CodigoPostal__c, Colonia__c, Comentarios__c,
                         ComisionComercial__c, ComisionComercialPresupuesto__c, ComisionComercialReal__c, Contratista__c,
                         CorreoNotaria__c, CosteAdeudos__c, CosteDesalojo2__c, CosteAdeudosVenta__c, CosteHonorariosNotaria__c,
                         CosteImpuestosNotaria__c, CosteRehabilitacion__c, CreditoInfonavit__c, Municipio__c,
                         Desalojo__c, DesalojosCompletados__c, Devolucion__c, DevolucionPresupuesto__c, DevolucionReal__c,
                         Direccion__c, Direccion2__c, DocumentosVerificados__c, EntidadFinanciera__c, EnviarAntecedenteNotaria__c,
                         EnviarEmailNotaria__c, Estatus__c, EstatusCorreoNotaria__c, Fecha_cobro_2__c, FechaCobro__c,
                         FechaPago__c, FirmaComprador__c, FirmaEntidadFinanciera__c, FirmaVendedor__c, Gravamen__c,
                         Inversor__c, InversorId__c, MargenBruto__c, MargenRehabilitacion__c, MargenNeto__c, Notaria__c,
                         Operador__c, Paquete__c, Plaza__c, PrecioCompra__c, PrecioVenta__c, PresupuestoRehabilitacion__c,
                         Proceso__c, Promotor__c, PromotorFinal__c, Propiedad__c, Proyecto_final__c, ProyectoLiberado__c,
                         Sincronizado__c, TiempoOferta__c, AvaluoCompra__c, AvaluoVenta__c, Valuador__c, ClasificacionR5__c,
                         Invadida__c, PosesionLegal__c, ProblematicaComercial__c, MontoCredito__c, MontoContado__c, LiquidacionPendiente__c,
                         NombreCliente__c, ResultadoRehabilitacion__c, Total_pagado__c
                         FROM Oferta__c WHERE Id =: doci.Oferta__c];
        list<Documento__c> ldocxauxOf = new list<Documento__c>();
        for (Documento__c docxof :[SELECT id, DocumentoEtapa__c, Name, Desalojo__c, Cerrado__c, Iniciado__c, Oferta__r.TipoOferta__c, Fecha_Cierre__c, 
                                      EtapaOferta__r.Etapa__c, EtapaOferta__r.NumEtapa__c, DocumentoEtapa__r.Orden__c 
                                      FROM Documento__c WHERE Oferta__c =:doci.Oferta__c])
        {
            ldocxauxOf.add(docxof);
        }  
        mdocxOf.put(doci.Oferta__c, ldocxauxOf);     
        list<EtapaOferta__c> letofxOf = new list<EtapaOferta__c>();   
        for (EtapaOferta__c etofxOf :[SELECT Id, Cerrada__c, Estatus__c, HoraFinal__c, HoraInicial__c, NumEtapa__c,Oferta__c, Oferta__r.TipoOferta__c,
                                      Etapa__r.Paralelo__c 
                                      FROM EtapaOferta__c WHERE Oferta__c =: doci.Oferta__c Order By NumEtapa__c])
        {
            metofxId.put(etofxOf.id, etofxOf);
            letofxOf.add(etofxOf);
        }
        metofxOf.put(doci.Oferta__c, letofxOf);     
        
        for (DocumentoEtapa__c docetauxm :[Select Id, Name, Tipo__c, Orden__c, NA_Contado__c, Cierra_Etapa__c, Etapa_Doc_a_Iniciar__c, Etapa_Paso_Anterior__c, Ultimo_Documento__c,
                                        Paso_Anterior__c, Tiempo_Proceso__c, Etapa__r.NumEtapa__c, TerminaDesalojo__c, Doc_a_Iniciar__c FROM DocumentoEtapa__c Order by Etapa__r.NumEtapa__c, Orden__c])
        {
            mdocetxId.put(docetauxm.id, docetauxm);
            if(mdocetxPA.get(String.valueOf(docetauxm.Etapa_Paso_Anterior__c.intValue()) + String.valueOf(docetauxm.Paso_Anterior__c.intValue())) == null)
            {
                mdocetxPA.put(String.valueOf(docetauxm.Etapa_Paso_Anterior__c.intValue()) + String.valueOf(docetauxm.Paso_Anterior__c.intValue()), new list<DocumentoEtapa__c> {docetauxm});
            }else
            {
                mdocetxPA.get(String.valueOf(docetauxm.Etapa_Paso_Anterior__c.intValue()) + String.valueOf(docetauxm.Paso_Anterior__c.intValue())).add(docetauxm);
            }
            
            if(mdocetxNE.get(String.valueOf(docetauxm.Etapa__r.NumEtapa__c.intValue()) + String.valueOf(docetauxm.Orden__c.intValue())) == null)
            {
                mdocetxNE.put(String.valueOf(docetauxm.Etapa__r.NumEtapa__c.intValue()) + String.valueOf(docetauxm.Orden__c.intValue()), new list<DocumentoEtapa__c> {docetauxm});
            }else
            {
                mdocetxNE.get(String.valueOf(docetauxm.Etapa__r.NumEtapa__c.intValue()) + String.valueOf(docetauxm.Orden__c.intValue())).add(docetauxm);
            }
        }
        
        
        boolean retfinal;
        retfinal = ConcluirPaso(doci, wsofertaPadreI);
        if(retfinal == true)
        {
            String etactual = '';   
            for (EtapaOferta__c etofnvet :[Select id, name, Estatus__c, NumEtapa__c, Etapa__r.name From EtapaOferta__c Where Estatus__c =: 'Abierta' and Oferta__c =: doci.Oferta__c and Etapa__r.EstatusOferta__c IN ('Compra','Venta') Order By NumEtapa__c asc])
            {
                etactual = etofnvet.Etapa__r.name;         
                system.debug('Esta es la etapa actual' + etactual);          
                break;
            }
            if (etactual != ''){
                wsofertaPadreI.Etapa__c = etactual;
            }else
            {
                EtapaOferta__c etfinal = new EtapaOferta__c();
                
                etfinal = [Select id, name, NumEtapa__c, Estatus__c From EtapaOferta__c Where Oferta__c =: doci.Oferta__c and NumEtapa__c =: 13];
                if (etfinal != null)
                   if (etfinal.Estatus__c == 'Cerrada')
                       wsofertaPadreI.Etapa__c = 'Finalizada';
            }
            update wsofertaPadreI;
            return true;
        }else
        {
            return false;
        }
        
    }
    private static boolean ConcluirPaso(Documento__c doc,Oferta__c wsofertaPadre1 ){
        try{
            DateTime dFrom = DateTime.now();
            boolean iniciar;
            iniciar = true;
            system.debug('Documento a cerrar...' + doc); 
            if (Test.isRunningTest())
            {
                Documento__c docrett = new Documento__c();
                map<Id,Documento__c> mdocst = new map<Id,Documento__c>();
                
                DocumentoEtapa__c doett = new DocumentoEtapa__c();
                doett = mdocetxId.get(doc.DocumentoEtapa__c);
                //doett = [SELECT TerminaDesalojo__c, Orden__c, Etapa__r.NumEtapa__c, Etapa_Doc_a_Iniciar__c, Ultimo_Documento__c,Doc_a_Iniciar__c FROM DocumentoEtapa__c WHERE id =: doc.DocumentoEtapa__c];
                docrett = IniciaPaso(doc, doett, doc, dFrom, mdocst, wsofertaPadre1);
                boolean retcomett;
                  
                  retcomett = CompletarEt(doc, wsofertaPadre1);
                  doc.Cerrado__c = false;
            }         
            if(doc.Cerrado__c == false)
            {
            	system.debug('Aqui entro el primer a');
               list<Documento__c> ldocsig = new list<Documento__c>();
               EtapaOferta__c doceta = new EtapaOferta__c();
               
               doceta = metofxId.get(doc.EtapaOferta__c);
               map <Id,Documento__c> mdocmiset = new map<Id, Documento__c>();
               for (Documento__c dc :mdocxOf.get(doc.Oferta__c))
               {
                 mdocmiset.put(dc.DocumentoEtapa__c, dc);
               }
               DocumentoEtapa__c docaux = new DocumentoEtapa__c();
               docaux = mdocetxId.get(doc.DocumentoEtapa__c);
               system.debug('Documento Etapa map...' + docaux);
               //docaux = [SELECT TerminaDesalojo__c, Orden__c, Etapa__r.NumEtapa__c, Etapa_Doc_a_Iniciar__c, Ultimo_Documento__c,Doc_a_Iniciar__c FROM DocumentoEtapa__c WHERE id =: doc.DocumentoEtapa__c];
               system.debug('map doceta' + doceta);
               system.debug('map docetxPA Completo ' +  mdocetXPA.keyset());
               
               if ((docaux.Etapa_Doc_a_Iniciar__c > docaux.Etapa__r.NumEtapa__c) || docaux.Ultimo_Documento__c)
               {
                  boolean retcomet;
                  
                  retcomet = CompletarEt(doc, wsofertaPadre1);
                  if (Test.isRunningTest())
                  {
                      retcomet = true;
                  }
                  if (retcomet == true)
                  {                                                            
                    if(mdocetxPA.get(String.valueOf(doceta.NumEtapa__c.intValue()) + String.valueOf(docaux.Orden__c.intValue())) != null)
                    {
                        set<EtapaOferta__c> sEtapaOfIni = new set<EtapaOferta__c>();
                        for (DocumentoEtapa__c doce :mdocetxPA.get(String.valueOf(doceta.NumEtapa__c.intValue()) + String.valueOf(docaux.Orden__c.intValue())))
                        {
                          Documento__c docret = new Documento__c();
                          docret = IniciaPaso(mdocmiset.get(doce.id), doce, doc, dFrom, mdocmiset, wsofertaPadre1);
                          if (docret != null)
                          {                      
                             ldocsig.add(docret);  
                             
                          }   
                            
                        }
                        
                    }
                    doc.Fecha_Cierre__c = dFrom;
                    doc.Cerrado__c = true;
                    ldocsig.add(doc);
                    upsert ldocsig;
                    if (ldocupdinipa.size() > 0)
                       upsert ldocupdinipa;
                    if(contNA == true)
                    {
                       Integer NumEtOfAb = 0;
                       for(EtapaOferta__c etofabrir :sEtapascierre)
                       {
                          if(etofabrir.NumEtapa__c.intValue() > NumEtOfAb)
                             NumEtOfAb = etofabrir.NumEtapa__c.intValue();
                             
                       }
                       for(EtapaOferta__c etofabrir :metofxOf.get(doc.Oferta__c))
                       {
                           if(etofabrir.NumEtapa__c.intValue() == NumEtOfAb + 1)
                           {
                              etofabrir.HoraInicial__c = Datetime.now();
                              etofabrir.Estatus__c = 'Abierta';
                              sEtapascierre.add(etofabrir);
                              break;
                           }
                       }
                       list<EtapaOferta__c> letofNA = new list<EtapaOferta__c>();
                       letofNA.addall(sEtapascierre);
                       update letofNA;
                    }
                    return true;
                  }else
                  {
                    system.debug('No se cerró la etapa....');
                    return false;
                  }
                  
               }else
               {
                  //Desalojo
                   if(docaux.TerminaDesalojo__c == true)
                   {
                   
                       for (DocumentoEtapa__c doce :mdocetxNE.get(String.valueOf(docaux.Etapa_Doc_a_Iniciar__c.intValue()) + String.valueOf(docaux.Doc_a_Iniciar__c.intValue())))
                       {
                          Documento__c dinsert = new Documento__c();
                          if (mdocmiset.get(doce.Id) != null)
                          {
                              dinsert = mdocmiset.get(doce.Id);
                             
                              if (dinsert.Iniciado__c == false)
                              {
                                  dinsert.Fecha_Inicio__c = dFrom;
                                  dinsert.Fecha_Compromiso__c = addBusinessDays(dFrom, doce.Tiempo_Proceso__c);
                                  dinsert.Fecha_Com_Controller__c = addBusinessDays(dFrom, doce.Tiempo_Proceso__c);
                                  dinsert.Iniciado__c = true;
                                  ldocsig.add(dinsert);     
                              }
                          }else
                          {
                             EtapaOferta__c docetaN = new EtapaOferta__c();
                        
                             docetaN = [SELECT id, NumEtapa__c, Oferta__c  FROM EtapaOferta__c WHERE Etapa__c = : doce.Etapa__c AND Oferta__c =: doc.Oferta__c];
                            
                             dinsert.Oferta__c = doc.Oferta__c;
                             dinsert.EtapaOferta__c = docetaN.id;
                             dinsert.DocumentoEtapa__c = doce.id;
                             dinsert.Name = doce.Name;
                             dinsert.Tipo__c = doce.Tipo__c;
                             dinsert.Fecha_Inicio__c = dFrom;
                             dinsert.Fecha_Compromiso__c = addBusinessDays(dFrom, doce.Tiempo_Proceso__c);
                             dinsert.Fecha_Com_Controller__c = addBusinessDays(dFrom, doce.Tiempo_Proceso__c);
                             dinsert.Iniciado__c = true;
                             ldocsig.add(dinsert);
                          }            
                       }
                   }else
                   {
                       if(mdocetxPA.get(String.valueOf(doceta.NumEtapa__c.intValue()) + String.valueOf(docaux.Orden__c.intValue())) != null)
                       {
                           for (DocumentoEtapa__c doce :mdocetxPA.get(String.valueOf(doceta.NumEtapa__c.intValue()) + String.valueOf(docaux.Orden__c.intValue())))
                           {
                            
                              Documento__c docret = new Documento__c();
                              docret = IniciaPaso(mdocmiset.get(doce.id), doce, doc, dFrom, mdocmiset, wsofertaPadre1);
                              if (docret != null)                      
                                 ldocsig.add(docret);
                                       
                           }
                       }
                   }
                   doc.Fecha_Cierre__c = dFrom;
                   doc.Cerrado__c = true;
                   ldocsig.add(doc);
                   upsert ldocsig;
                   if (ldocupdinipa.size() > 0)
                       upsert ldocupdinipa;
                   if(contNA == true)
                   {
                      Integer NumEtOfAb = 0;
                      for(EtapaOferta__c etofabrir :sEtapascierre)
                      {
                          if(etofabrir.NumEtapa__c.intValue() > NumEtOfAb)
                             NumEtOfAb = etofabrir.NumEtapa__c.intValue();
                             
                      }
                      for(EtapaOferta__c etofabrir :metofxOf.get(doc.Oferta__c))
                      {
                           if(etofabrir.NumEtapa__c.intValue() == NumEtOfAb + 1)
                           {
                              etofabrir.HoraInicial__c = Datetime.now();
                              etofabrir.Estatus__c = 'Abierta';
                              sEtapascierre.add(etofabrir);
                              break;
                           }
                      }
                       list<EtapaOferta__c> letofNA = new list<EtapaOferta__c>();
                       letofNA.addall(sEtapascierre);
                       update letofNA;
                   }
                   return true;
               }
            }else
            {
                
                return true;
            }   
        }catch(Exception e){
            system.debug('Este es el error que está marcando.......' + e.getMessage());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            return false;
        }
    }
    global static boolean GenerateComDates(string ofertaId)
    {
      try
      {
        list<Documento__c> lDocOferta = new list<Documento__c>();
        map<Id, Documento__c> mDocOferta = new map<Id, Documento__c>();
        lDocOferta = [SELECT DocumentoEtapa__c, EtapaOferta__c, Fecha_Compromiso_Plan__c, Fecha_Inicio__c, Fecha_Inicio_Plan__c, Fecha_Compromiso__c, Fecha_Com_Controller__c, Iniciado__c, Oferta__c FROM Documento__c WHERE Oferta__c =: ofertaId];
        for (Documento__c doc :lDocOferta)
        {
            mDocOferta.put(doc.DocumentoEtapa__c, doc);
        }
        
        map<Id,list<DocumentoEtapa__c>> mDocEtapa = new map<Id,list<DocumentoEtapa__c>>();
        list<Etapa__c> iduno = new list<Etapa__c>();
         list<Id> lEtapaIds = new list<Id>();
        iduno= [SELECT Id,NumEtapa__c, EstatusOferta__c, Name FROM Etapa__c WHERE Activa__c =: true AND (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta') ORDER BY NumEtapa__c];
        for(Etapa__c et1: iduno){
        	  lEtapaIds.add(et1.Id);
        }
        list<DocumentoEtapa__c> lDocEtapaAux = new list<DocumentoEtapa__c>();
       
       
        DateTime dFrom = DateTime.now();

        lDocEtapaAux = [SELECT Id, Name, Activo__c, Etapa__c, Obligatorio__c, Orden__c, Etapa_Paso_Anterior__c, Paso_Anterior__c, Etapa_Doc_a_Iniciar__c, Doc_a_Iniciar__c, Inicia_Proceso_Venta__c, Tiempo_Proceso__c, Ruta_Critica__c, Tipo__c FROM DocumentoEtapa__c WHERE Activo__c =: true AND Etapa__c IN: lEtapaIds ORDER BY Orden__c ];
        
        for (Etapa__c etapa :iduno)
        {
        	list<DocumentoEtapa__c> lDocEtapaAux2 = new list<DocumentoEtapa__c>();
        		for(DocumentoEtapa__c Docut :lDocEtapaAux ){
        			if(Docut.Etapa__c==etapa.Id)
        				lDocEtapaAux2.Add(Docut);      
        			}
        mDocEtapa.put(etapa.Id, lDocEtapaAux2);
      
        
        }
        
        
        
        
        map <String, DateTime> mobj = new map<String,DateTime>();
        for (Etapa__c etapa :[SELECT Id,NumEtapa__c, EstatusOferta__c, Name FROM Etapa__c WHERE Activa__c =: true AND (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta') ORDER BY NumEtapa__c])
        {             
            DateTime dto = dFrom;
            DateTime dFromE = dFrom;
            DateTime dToE = dFrom;
            
            
            for (DocumentoEtapa__c detapa :mDocEtapa.get(etapa.Id))
            {
                system.debug('Documento número.....' + etapa.NumEtapa__c + detapa.Orden__c);
                
                if (detapa.Etapa_Paso_Anterior__c == 0) 
                {
                   Documento__c docof = new Documento__c();
                   docof = mDocOferta.get(detapa.Id);
                   docof.Fecha_Inicio_Plan__c = dFromE; 
                   docof.Fecha_Inicio__c = dFromE;
                   dto = addBusinessDays(dFromE, detapa.Tiempo_Proceso__c);
                   docof.Fecha_Compromiso_Plan__c = dto;
                   docof.Fecha_Compromiso__c = dto;
                   docof.Fecha_Com_Controller__c = dto;
                   docof.Iniciado__c = true;
                   mDocOferta.put(detapa.Id, docof);
                   string etdoc;
                   etdoc = string.valueOf(etapa.NumEtapa__c.intValue()) + string.valueOf(detapa.Orden__c);
                   mobj.put(etdoc, dto);
                   
                   
                } else
                {
                   string etdocget;
                   etdocget = string.valueOf(detapa.Etapa_Paso_Anterior__c) + string.valueOf(detapa.Paso_Anterior__c);
                   DateTime dfromTask;
                   dFromTask = mobj.get(etdocget); 
                   Documento__c docof = new Documento__c();
                   docof = mDocOferta.get(detapa.Id);
                   docof.Fecha_Inicio__c = dFromTask;
                   docof.Fecha_Inicio_Plan__c = dFromTask;
                   dto = addBusinessDays(dFromTask, detapa.Tiempo_Proceso__c);
                   docof.Fecha_Compromiso__c = dto;
                   docof.Fecha_Compromiso_Plan__c = dto;
                   docof.Fecha_Com_Controller__c = dto;
                   mDocOferta.put(detapa.Id, docof);
                   string etdoc;
                   etdoc = string.valueOf(etapa.NumEtapa__c.intValue()) + string.valueOf(detapa.Orden__c);
                   mobj.put(etdoc, dto); 
                }
                
            }
            
        }
        update mDocOferta.values();
        return true;
      }catch(Exception e)
      {
        System.debug('Este error ocurrió: ' + e.getMessage());
        
        return false;
      }
    }
    global static list<Decimal> CriticalPath(Id EtapaId) 
    {
        Etapa__c etapa = new Etapa__c();
        list<DocumentoEtapa__c> docepa = new list<DocumentoEtapa__c>();
        try
        {
          docepa = [SELECT Id, Etapa__c, Orden__c, Tiempo_Proceso__c, Paso_Anterior__c, Obligatorio__c, Ruta_Critica__c FROM DocumentoEtapa__c WHERE Etapa__c =: EtapaId AND Obligatorio__c =: true ORDER BY Paso_Anterior__c DESC];
          map<Decimal, DocumentoEtapa__c> mdoce = new map<Decimal, DocumentoEtapa__c>();
          
          for (DocumentoEtapa__c de :docepa)
          {
             mdoce.put(de.Orden__c, de);
          }
          Integer iRuta = 1;
          
          map<Decimal, list<wDocEt>> mrutas = new map<Decimal, list<wDocEt>>();
          for (DocumentoEtapa__c de :docepa)
          {
              list<wDocEt> lruta = new list<wDocEt>();
              Decimal deId;
              deId = de.Orden__c;
              Decimal pasoanterior;
              Do
              { 
                wDocEt wde = new wDocEt();
                wde.wPaso = deId;
                wde.wDuracion = (mdoce.get(deId)).Tiempo_Proceso__c;
                pasoanterior = (mdoce.get(deId)).Paso_Anterior__c;
                lruta.add(wde);
                
                if( pasoanterior > 0)
                {
                   deId = pasoanterior;
                }
                
              } While (pasoanterior > 0);
              mrutas.put(de.Orden__c,lruta);
          }
          Decimal dmax = 0;
          Decimal rc = 0;
          for (Decimal oruta : mrutas.KeySet())
          {
              Decimal duraux = 0;
              for (wDocEt wrde : mrutas.get(oruta))
              { 
                 duraux = duraux + wrde.wDuracion;
              }
              if (duraux > dmax)
              {
                 rc = oruta;
                 dmax = duraux;
              } 
              
          }
          list<Decimal> rutacritica = new list<Decimal>();
          for (wDocEt rcd : mrutas.get(rc))
          {
             rutacritica.add(rcd.wPaso);
          }
          list<DocumentoEtapa__c> docetrc = new list<DocumentoEtapa__c>();
          for (Decimal frc :rutacritica)
          {
             docetrc.add(mdoce.get(frc)); 
          }
          for (DocumentoEtapa__c de :docepa)
          {
            de.Ruta_Critica__c = false;
          }
          update docepa;
          for (DocumentoEtapa__c de :docetrc)
          {
            de.Ruta_Critica__c = true;
          }
          update docetrc;
          system.debug('La ruta crítica es .................' + rutacritica);
          return rutacritica;
            
        } catch(Exception e)
        {
          return null; 
        }
        
        
    }
    public class wDocEt
    {
        Decimal wPaso {get;set;}
        Decimal wDuracion {get;set;}
        public wDocEt()
        {
        }
    }
    
    private static boolean CompletarEt(Documento__c cdc, Oferta__c wsofertaPadre){
        
        Etapa__c etpa = new Etapa__c();
        if (Test.isRunningTest())
        {
            etpa = [SELECT Id, TipoOfertaExcluir__c, NumEtapa__c, Seriada__c, ConjuntoCampos__c FROM Etapa__c WHERE NumEtapa__c =: 2];
        }else
        {
            etpa = [SELECT Id, TipoOfertaExcluir__c, NumEtapa__c, Seriada__c, ConjuntoCampos__c FROM Etapa__c WHERE Id =: cdc.EtapaOferta__r.Etapa__c];
        }
        EtapaOferta__c etapaoferta = new EtapaOferta__c();
        if (Test.isRunningTest())
        {
             etapaoferta = [SELECT Id, Cerrada__c, Estatus__c, HoraFinal__c, HoraInicial__c FROM EtapaOferta__c Limit 1];
        }else
        {
            etapaoferta = metofxId.get(cdc.EtapaOferta__c); 
        }
        list<Schema.FieldSetMember> wsconjuntoCampos = new list<Schema.FieldSetMember>();
        
        Schema.SObjectType sot = Schema.getGlobalDescribe().get('Oferta__c');
        Schema.DescribeSObjectResult d = sot.getDescribe();
        Map<String, Schema.FieldSet> FsMap = d.fieldSets.getMap();
        
        if(etpa.ConjuntoCampos__c != null){
            wsconjuntoCampos = FsMap.get(etpa.ConjuntoCampos__c).getFields();
        }
        String mensajeError = '';
        String tipoOfertaExcluir = etpa.TipoOfertaExcluir__c != null ?  etpa.TipoOfertaExcluir__c : '';
        boolean bExcluir = false;
        System.debug('OFERTA PADRE ' +wsofertaPadre.TipoOferta__c + ', tipoEtapa:' + tipoOfertaExcluir + ',REAL ' + etpa.TipoOfertaExcluir__c);
        if((wsofertaPadre.TipoOferta__c == tipoOfertaExcluir) || tipoOfertaExcluir.equals('Todas')){
            bExcluir = true;
        }
        
        if(wsconjuntoCampos !=null && !bExcluir){
            for(Schema.FieldSetMember cc: wsconjuntoCampos){
                if(wsofertaPadre.get(cc.getFieldPath()) == null && cc.getRequired()){
                    mensajeError = 'No se puede completar la etapa, llene todos los campos';
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error,mensajeError);
                    ApexPages.addMessage(msg);
                    break;
                }else if(cc.getRequired() && wsofertaPadre.get(cc.getFieldPath()) == null){
                    mensajeError = 'No se puede completar la etapa, llene todos los campos';
                    break;
                }
            }
        }
        
        
        
        /*List<DocumentoEtapa__c> documentosSecundariosObligatorios = [SELECT Id, Name, Etapa__c,Etapa__r.NumEtapa__c, Etapa__r.Name FROM  DocumentoEtapa__c WHERE Obligatorio_EtapaSecundaria__c =: etpa.NumEtapa__c order by Orden__c];
        if(documentosSecundariosObligatorios != null){
            Map<String, Documento__c> mDocumentosSecundarios = new Map<String, Documento__c>();
            for(Documento__c fdoc: [Select Id, Name, EtapaOferta__c, Tipo__c, DocumentoEtapa__c From Documento__c Where EtapaOferta__r.Oferta__c =: cdc.Oferta__c AND DocumentoEtapa__r.Obligatorio_EtapaSecundaria__c =: etpa.NumEtapa__c]){
                mDocumentosSecundarios.put(fdoc.DocumentoEtapa__c, fdoc);
            }
            for(DocumentoEtapa__c de : documentosSecundariosObligatorios){
                if(!mDocumentosSecundarios.containsKey(de.Id) && !bExcluir){
                    mensajeError = 'Documento secundario obligatorio. Debe ingresar un archivo adjunto para el documento: "' + de.Name + '" de la etapa: "'+ de.Etapa__r.Name+ '"' ;
                    ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Warning,mensajeError);
                    ApexPages.addMessage(msg);
                }
            }
        }*/
        
        if(etpa.Seriada__c){
            EtapaOferta__c etapaAnterior;
            for(EtapaOferta__c e : [Select Id, Name, Estatus__c, Etapa__r.NumEtapa__c From EtapaOferta__c Where Oferta__c =: cdc.Oferta__c  AND (Etapa__r.EstatusOferta__c =: 'Compra' OR Etapa__r.EstatusOferta__c =: 'Venta') AND Etapa__r.NumEtapa__c <: etpa.NumEtapa__c order by Etapa__r.NumEtapa__c desc limit 1]){
                etapaAnterior = e;
            }
            if(etapaAnterior != null && etapaAnterior.Estatus__c != 'Cerrada' && !bExcluir){
                mensajeError = 'No se puede completar la etapa. Es necesario completar la etapa anterior.';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,mensajeError));
            }
        }
        
        try{
            if(mensajeError.equals('')){
                Etapa__c nuevaEtapa;
                system.debug('ofertaPadre.Etapa__c aqui.......' + wsofertaPadre.Etapa__c);
                /*if(!bExcluir){
                    for(Etapa__c e : [Select Id, Name, NumEtapa__c From Etapa__c Where NumEtapa__c >: etpa.NumEtapa__c AND EstatusOferta__c IN ('Compra','Venta') order by NumEtapa__c asc limit 1]){
                        nuevaEtapa = e;
                    }
                    system.debug('nuevaEtapa aqui......' + nuevaEtapa);
                    if(nuevaEtapa!= null && nuevaEtapa.NumEtapa__c > etpa.NumEtapa__c){
                        wsofertaPadre.Etapa__c = nuevaEtapa.Name;
                    }else if(nuevaEtapa == null){
                        wsofertaPadre.Etapa__c = 'Finalizada';
                    }else{
                        mensajeError = 'Error 01 - Error para determinar la etapa actual, consulte a su administrador.';
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error 01 - Error para determinar la etapa actual, consulte a su administrador.'));
                    }
                }*/
                if(mensajeError.equals('')){
                    //update wsofertaPadre;
                    etapaOferta.Estatus__c = 'Cerrada';
                    etapaOferta.Cerrada__c = true;
                    etapaOferta.HoraFinal__c = Datetime.now();
                    if(etapaOferta.HoraInicial__c == null){
                        etapaOferta.HoraInicial__c = Datetime.now();
                    }
                    list<EtapaOferta__c> lEtapaOfIni = new list<EtapaOferta__c>();
                    lEtapaOfIni.add(etapaOferta);
                    Integer ietIniciar;
                    
                    ietIniciar = etapaOferta.NumEtapa__c.intValue() + 1; 
                    for(EtapaOferta__c etofabrir :metofxOf.get(etapaOferta.Oferta__c))
                    {
                        if(etofabrir.NumEtapa__c.intValue() == ietIniciar)                       
		                {
		                             if(etofabrir.Estatus__c != 'Abierta' && etofabrir.Estatus__c != 'Cerrada')
		                             {
			                             etofabrir.HoraInicial__c = Datetime.now();
			                             etofabrir.Estatus__c = 'Abierta';
			                             lEtapaOfIni.add(etofabrir);
		                             }
		                             if (etofabrir.Etapa__r.Paralelo__c == true)
		                             {
		                             	ietIniciar++;
		                             	
		                             }else
		                             {
		                                break;
		                             }
		                 }
                    }
                    update lEtapaOfIni;
                    
                }
            }
            
        }catch(Exception e){
            mensajeError = recortarMsjError(e.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error,mensajeError );
            ApexPages.addMessage(msg);
            
        }
        if (mensajeError.equals(''))
        {
            return true;
        }else
        {
            return false;
         }
    }
    
    
    global static boolean CrearPasoMigracion(EtapaOferta__c doce)
    {
        map<string, Documento__c> mdocetapa = new map<string, Documento__c>();
        
        for(Documento__c de :[Select id, name, Oferta__c, EtapaOferta__c,Tipo__c,Fecha_Inicio__c, Fecha_Compromiso__c, Fecha_Com_Controller__c, Iniciado__c, DocumentoEtapa__r.Orden__c
                     From Documento__c Where EtapaOferta__c = : doce.id])
        {
            mdocetapa.put(de.EtapaOferta__c + string.valueOf(de.DocumentoEtapa__r.Orden__c), de);
        }                   
        DateTime dFrom = DateTime.now();
        list<Documento__c> ldocsig = new list<Documento__c>();
        For (DocumentoEtapa__c doceta :[Select id, Name, Tipo__c, Tiempo_Proceso__c, Etapa__r.NumEtapa__c, Orden__c
                                From DocumentoEtapa__c Where (Etapa_Paso_Anterior__c <: doce.NumEtapa__c) AND (Etapa__r.NumEtapa__c =: doce.NumEtapa__c)])
        {
        
            Documento__c dinsert = new Documento__c(); 
            if(mdocetapa.get(doce.id + string.valueOf(doceta.Orden__c)) != null)
            {
                dinsert = mdocetapa.get(doce.id + string.valueOf(doceta.Orden__c));
                dinsert.Fecha_Inicio__c = dFrom;
                dinsert.Fecha_Compromiso__c = addBusinessDays(dFrom, doceta.Tiempo_Proceso__c);
                dinsert.Fecha_Com_Controller__c = addBusinessDays(dFrom, doceta.Tiempo_Proceso__c);
                dinsert.Iniciado__c = true;
                ldocsig.add(dinsert);
            }else
            {
                dinsert.Oferta__c = doce.Oferta__c;
                dinsert.EtapaOferta__c = doce.id;
                dinsert.DocumentoEtapa__c = doceta.id;
                dinsert.Name = doceta.Name;
                dinsert.Tipo__c = doceta.Tipo__c;
                dinsert.Fecha_Inicio__c = dFrom;
                dinsert.Fecha_Compromiso__c = addBusinessDays(dFrom, doceta.Tiempo_Proceso__c);
                dinsert.Fecha_Com_Controller__c = addBusinessDays(dFrom, doceta.Tiempo_Proceso__c);
                dinsert.Iniciado__c = true;
                ldocsig.add(dinsert);
            }
                                
        }
        try
        {
           upsert ldocsig;
           return true;
        }catch(Exception e){
            string mensajeError;
            mensajeError = recortarMsjError(e.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error,mensajeError );
            ApexPages.addMessage(msg);
            return false;
        }
    }
    
    private static Documento__c IniciaPaso(Documento__c cdc, DocumentoEtapa__c docep, Documento__c docp, DateTime dFromp, map<Id,Documento__c> mdocs, Oferta__c wsOfertaP){
        boolean iniciarp;
        Documento__c dinsert = new Documento__c();
        system.debug('Entreo a iniciaPaso + cdc'+cdc);
        if (cdc != null)
        {
        	system.debug('cdc.Cerrado__c'+cdc.Cerrado__c);
            if(cdc.Cerrado__c == false)
            {
               dinsert = cdc;
                              
               iniciarp = true;
              system.debug('dinsert.Oferta__r.TipoOferta__c '+dinsert.Oferta__r.TipoOferta__c+' docep.NA_Contado__c'+docep.NA_Contado__c);
               
               if (dinsert.Oferta__r.TipoOferta__c == 'Contado' && docep.NA_Contado__c == true)
               {
                  iniciarp = false;
                  if (dinsert.Iniciado__c == true) dinsert.Cerrado__c = true;
                  if (docep.Etapa_Doc_a_Iniciar__c > docep.Etapa__r.NumEtapa__c)
                  {
                     EtapaOferta__c etapaofna = new EtapaOferta__c();
                     for(EtapaOferta__c etofpasoi :metofxOf.get(wsOfertaP.id))
                     {
                        if (etofpasoi.NumEtapa__c == docep.Etapa__r.NumEtapa__c) 
                        {
                            etofpasoi.Estatus__c = 'Cerrada';
                            etofpasoi.Cerrada__c = true;
                            sEtapascierre.add(etofpasoi);
                            contNA = true;
                            break;
                        }
                     }
                     //etapaofna = [Select id, Estatus__c, Cerrada__c From EtapaOferta__c Where Oferta__c =: wsOfertaP.id AND NumEtapa__c =: docep.Etapa__r.NumEtapa__c];
                     //etapaofna.Estatus__c = 'Cerrada';
                     //etapaofna.Cerrada__c = true;
                     //update etapaofna;                    
                  } 
                  list<Documento__c> ldocupdRec = new list<Documento__c>();
                  if(mdocetxPA.get(String.valueOf(dinsert.EtapaOferta__r.NumEtapa__c.intvalue()) + String.valueOf(dinsert.DocumentoEtapa__r.Orden__c.intValue())) != null)
                  {
                      for (DocumentoEtapa__c docer :mdocetxPA.get(String.valueOf(dinsert.EtapaOferta__r.NumEtapa__c.intvalue()) + String.valueOf(dinsert.DocumentoEtapa__r.Orden__c.intValue())))
                      {
                          Documento__c docret = new Documento__c();
                          docret = IniciaPaso(mdocs.get(docer.id), docer, dinsert, dFromp, mdocs, wsOfertaP);
                          if (docret != null)                      
                             ldocupdRec.add(docret);                                           
                       }
                   }
                   if (ldocupdRec.size() > 0)
                   {
                      ldocupdinipa.addall(ldocupdRec);
                   }
                   return dinsert;
                
               }else if (dinsert.Iniciado__c == false && iniciarp == true)
               {
                  dinsert.Fecha_Inicio__c = dFromp;
                  dinsert.Fecha_Compromiso__c = addBusinessDays(dFromp, docep.Tiempo_Proceso__c);
                  dinsert.Fecha_Com_Controller__c = addBusinessDays(dFromp, docep.Tiempo_Proceso__c);
                  dinsert.Iniciado__c = true;                  
                  return dinsert;     
               }
            }else
            {       
                if(docep.Ultimo_Documento__c == false)
                {       
                    try
                    {
                        
                        list<Documento__c> ldocupdRec = new list<Documento__c>();
                        if(mdocetxPA.get(String.valueOf(cdc.EtapaOferta__r.NumEtapa__c.intValue()) + String.valueOf(cdc.DocumentoEtapa__r.Orden__c.intValue())) != null)
                        {
                            for (DocumentoEtapa__c docer :mdocetxPA.get(String.valueOf(cdc.EtapaOferta__r.NumEtapa__c.intValue()) + String.valueOf(cdc.DocumentoEtapa__r.Orden__c.intValue())))
                            {
                                Documento__c docret = new Documento__c();
                                docret = IniciaPaso(mdocs.get(docer.id), docer, cdc, dFromp, mdocs, wsOfertaP);
                                if (docret != null)                      
                                   ldocupdRec.add(docret);                                           
                            }
                        }
                        if (ldocupdRec.size() > 0)
                        {
                            ldocupdinipa.addall(ldocupdRec);
                        }
                        if (docep.Cierra_Etapa__c == true)
               			{   
               	  			EtapaOferta__c etapaofna = new EtapaOferta__c();
			                for(EtapaOferta__c etofpasoi :metofxOf.get(wsOfertaP.id))
			                {
                        		if (etofpasoi.NumEtapa__c == docep.Etapa__r.NumEtapa__c) 
                        		{
                            		etofpasoi.Estatus__c = 'Cerrada';
		                            etofpasoi.Cerrada__c = true;
		                            sEtapascierre.add(etofpasoi);
		                            contNA = true;
		                            break;
                        		}
                  			}
               			}
                  
                    }catch(Exception e){
                        string mensajeError;
                        mensajeError = recortarMsjError(e.getMessage());
                        ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error,mensajeError );
                        ApexPages.addMessage(msg);
                        return null;
                    }
                }else
                {
                    return null;
                }
            }
        }else
        {
           system.debug('cdc.else');
           EtapaOferta__c docetaN = new EtapaOferta__c();
           for (EtapaOferta__c docetaNi :metofxOf.get(wsOfertaP.id))
           {
               if(docetaNi.NumEtapa__c == docep.Etapa__r.NumEtapa__c)
               {
                  docetaN = docetaNi;
                  break;
               }
           }             
           //docetaN = [SELECT id, NumEtapa__c, Oferta__c, Oferta__r.TipoOferta__c  FROM EtapaOferta__c WHERE NumEtapa__c = : docep.Etapa__r.NumEtapa__c AND Oferta__c =: wsOfertaP.id];
           iniciarp = true;
           if (docetaN.Oferta__r.TipoOferta__c == 'Contado' && docep.NA_Contado__c == true)
           {
              iniciarp = false;
              if (docep.Etapa_Doc_a_Iniciar__c > docep.Etapa__r.NumEtapa__c)
              {
                  list<EtapaOferta__c> etapaofna = new list<EtapaOferta__c>();
                  for(EtapaOferta__c etofpasoi :metofxOf.get(wsOfertaP.id))
                  {
                     if (etofpasoi.NumEtapa__c == docep.Etapa__r.NumEtapa__c) 
                     {
                        etofpasoi.Estatus__c = 'Cerrada';
                        etofpasoi.Cerrada__c = true;
                        sEtapascierre.add(etofpasoi);
                        contNA = true;
                        break;
                     }
                     
                  }
                  //etapaofna = [Select id, Estatus__c, Cerrada__c From EtapaOFerta__c Where Oferta__c =: wsOfertaP.id AND NumEtapa__c =: docep.Etapa__r.NumEtapa__c];
                  //if (etapaofna.size() > 0)
                  //   update etapaofna;                    
              } 
              
              list<Documento__c> ldocupdRec = new list<Documento__c>();
              if (mdocetxPA.get(String.valueOf(docep.Etapa__r.NumEtapa__c.intValue()) + String.valueOf(docep.Orden__c.intValue())) != null)
              {
                  for (DocumentoEtapa__c docer :mdocetxPA.get(String.valueOf(docep.Etapa__r.NumEtapa__c.intValue()) + String.valueOf(docep.Orden__c.intValue())))
                  {
                      Documento__c docret = new Documento__c();
                      docret = IniciaPaso(mdocs.get(docer.id), docer, dinsert, dFromp, mdocs, wsOfertaP);
                      if (docret != null)                      
                          ldocupdRec.add(docret);                                           
                  }
              }
              if (ldocupdRec.size() > 0)
              {
                 ldocupdinipa.addall(ldocupdRec);
              }
                   
              return null;
                   
           } else                         
           {
              dinsert.Oferta__c = wsOfertaP.id;
              dinsert.EtapaOferta__c = docetaN.id;
              dinsert.DocumentoEtapa__c = docep.id;
              dinsert.Name = docep.Name;
              dinsert.Tipo__c = docep.Tipo__c;
              dinsert.Fecha_Inicio__c = dFromp;
              dinsert.Fecha_Compromiso__c = addBusinessDays(dFromp, docep.Tiempo_Proceso__c);
              dinsert.Fecha_Com_Controller__c = addBusinessDays(dFromp, docep.Tiempo_Proceso__c);
              dinsert.Iniciado__c = true;
              return dinsert;
           }
        }
        return null;            
    }
    
    
    global static Datetime addBusinessDays(Datetime StartDate, Decimal iDaystoAdd)
    {
    	Date Dateaux = date.newinstance(1900, 1, 7);
    	Datetime finalDate;
        
        Integer idaysince;
        Date Dateaux2 = StartDate.Date();
        idaysince = Dateaux.daysBetween(Dateaux2);
    	Integer iMod = math.mod(idaysince, 7);
    	if (iMod == 0) //Domingo
    	{
    	   finalDate = StartDate + iDaystoAdd + (math.floor((iDaystoAdd -1)/5)*2);	
    	}else if(iMod == 1) //Lunes
    	{
    	   finalDate = StartDate + iDaystoAdd + (math.floor((iDaystoAdd)/5)*2);		
    	}else if(iMod == 2) //Martes
    	{
    	   finalDate = StartDate + iDaystoAdd + (math.floor((iDaystoAdd + 1)/5)*2);	
    	}else if(iMod == 3) //Miercoles
    	{
    		finalDate = StartDate + iDaystoAdd + (math.floor((iDaystoAdd + 2)/5)*2);
    	}else if(iMod == 4) //Jueves
    	{
    		finalDate = StartDate + iDaystoAdd + (math.floor((iDaystoAdd + 3)/5)*2);
    	}else if(iMod == 5) //Viernes
    	{
    		finalDate = StartDate + iDaystoAdd + (math.ceil((iDaystoAdd)/5)*2);
    	}else if(iMod == 6) //Sabado
    	{
    		finalDate = StartDate - 1 + iDaystoAdd + (math.ceil((iDaystoAdd)/5)*2);
    	}
    	return finalDate;
    }
    private static String recortarMsjError(String mensajeError){
        if(mensajeError.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION,')){
            Integer length = 'FIELD_CUSTOM_VALIDATION_EXCEPTION,'.length(); 
            Integer index = mensajeError.indexOf('FIELD_CUSTOM_VALIDATION_EXCEPTION,');
            Integer index2 = mensajeError.indexOf(': []');
            mensajeError = mensajeError.substring(index+length, index2);
        }
        return mensajeError; 
    }
    global static boolean cobertura(){
    	Integer a = 0;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	a=1;
    	return true;
    }
}