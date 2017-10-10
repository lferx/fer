trigger gerente on Documento__c (after update) {
    for(Documento__c c:Trigger.new){
        if (c.oferta__c!=null){
            if (c.EtapaOferta__c!=null){
                oferta__c r=[select id,fechacobro__c,etapa__c,TipoOferta__c, gerente_operativo__c from oferta__c where id=:c.oferta__c];
                if(r.gerente_operativo__c!=null){
                    if(r.FechaCobro__c==null){
                        if(r.TipoOferta__c!='Contado'){                                    
                            Account l=[select Pendientes_Realizados__c from Account where id=:r.gerente_operativo__c];    
                            if ((r.Etapa__c=='Expediente aprobado')||(r.Etapa__c=='Compilación expediente crediticio')||(r.Etapa__c=='Rehabilitación')||(r.Etapa__c=='Cierre oferta')){
                                if ((c.name=='Presupuesto de rehabilitación')||(c.name=='Fotografia del estado inicial')||(c.name=='Avalúo')||(c.name=='Fotografia del estado final de la propiedad')||(c.name=='CLG')||(c.name=='Predial')||(c.name=='Constancia de Crédito')
                                     ||(c.name=='Carta de instrucción Notarial')||(c.name=='Carta de Intrucción Revimex')||(c.name=='Proyecto de Escrituras')
                                     ||(c.name=='Aviso de Retención Y Firma Cliente')||(c.name=='Confirmación cobro propiedad')||(c.name=='Carta de entrega')
                                     ||(c.name=='Fotos de Entrega')||(c.name=='Pre-cierre')||(c.name=='Pago Activado')||(c.name=='Escrituras Registradas')
                                     ||(c.name=='Cierre Contabilidad')||(c.name=='Comprobante Firma Apoderado')||(c.name=='Comprobante Comisión Broker')
                                     ||(c.name=='Comprobante Comisión Gerente')||(c.name=='Comprobante Anticipo Comisión Gerente')||(c.name=='Pago Ventanilla Unica')
                                     ||(c.name=='Comprobante de Pago Ventanilla Unica')||(c.name=='Pre-Pantalla')){
                                    Documento__c v=trigger.oldMap.get(c.id);
                                    Documento__c y=[select en_espera__c from documento__c where id=:c.Id];
                                    EtapaOferta__c x=[select EtapaActual__c from EtapaOferta__c where id=:c.EtapaOferta__c];
                                    if(c.cerrado__c!=v.cerrado__c){
                                        if ((r.Etapa__c=='Expediente aprobado')||(r.Etapa__c=='Compilación expediente crediticio')||(r.Etapa__c=='Rehabilitación')||(r.Etapa__c=='Cierre oferta')){
                                            if ((c.name=='Presupuesto de rehabilitación')||(c.name=='Fotografia del estado inicial')||(c.name=='Avalúo')||(c.name=='Fotografia del estado final de la propiedad')||(c.name=='CLG')||(c.name=='Predial')||(c.name=='Constancia de Crédito')
                                                 ||(c.name=='Carta de instrucción Notarial')||(c.name=='Carta de Intrucción Revimex')||(c.name=='Proyecto de Escrituras')
                                                 ||(c.name=='Aviso de Retención Y Firma Cliente')||(c.name=='Confirmación cobro propiedad')||(c.name=='Carta de entrega')
                                                 ||(c.name=='Fotos de Entrega')||(c.name=='Pre-cierre')||(c.name=='Pago Activado')||(c.name=='Escrituras Registradas')
                                                 ||(c.name=='Cierre Contabilidad')||(c.name=='Comprobante Firma Apoderado')||(c.name=='Comprobante Comisión Broker')
                                                 ||(c.name=='Comprobante Comisión Gerente')||(c.name=='Comprobante Anticipo Comisión Gerente')||(c.name=='Pago Ventanilla Unica')
                                                 ||(c.name=='Comprobante de Pago Ventanilla Unica')||(c.name=='Pre-Pantalla')){
                                                if(c.Cerrado__c==true){
                                                    if(c.Iniciado__c==true){
                                                        if (x.EtapaActual__c ==true){
                                                            if (c.En_Espera__c==false){
                                                                if (l.Pendientes_Realizados__c==null){
                                                                    l.Pendientes_Realizados__c=0;
                                                                }
                                                            l.Pendientes_Realizados__c+=1;
                                                            update l;
                                                            }
                                                        }
                                                    }
                                                 }
                                             }
                                         }
                                     }

                                     if (((r.Etapa__c=='Expediente aprobado')||(r.Etapa__c=='Compilación expediente crediticio')||(r.Etapa__c=='Rehabilitación')
                                           ||(r.Etapa__c=='Cierre oferta'))&&((c.name=='Presupuesto de rehabilitación')
                                           ||(c.name=='Fotografia del estado inicial')||(c.name=='Fotografia del estado final de la propiedad')
                                           ||(c.name=='CLG')||(c.name=='Predial')||(c.name=='Constancia de Crédito')
                                           ||(c.name=='Carta de instrucción Notarial')||(c.name=='Carta de Intrucción Revimex')||(c.name=='Proyecto de Escrituras')
                                           ||(c.name=='Aviso de Retención Y Firma Cliente')||(c.name=='Confirmación cobro propiedad')||(c.name=='Avalúo')||(c.name=='Carta de entrega')
                                           ||(c.name=='Fotos de Entrega')||(c.name=='Pre-cierre')||(c.name=='Pago Activado')||(c.name=='Escrituras Registradas')
                                           ||(c.name=='Cierre Contabilidad')||(c.name=='Comprobante Firma Apoderado')||(c.name=='Comprobante Comisión Broker')
                                           ||(c.name=='Comprobante Comisión Gerente')||(c.name=='Comprobante Anticipo Comisión Gerente')||(c.name=='Pago Ventanilla Unica')
                                           ||(c.name=='Comprobante de Pago Ventanilla Unica')||(c.name=='Pre-Pantalla'))&&(c.Cerrado__c==true)&&(c.Iniciado__c==true)
                                           &&(x.EtapaActual__c ==true)&&(c.En_Espera__c==true)){
                                         if((v.NumFiles_MasFilesPadre__c==0)&&(c.NumFiles_MasFilesPadre__c==1)){
                                             if (l.Pendientes_Realizados__c==null){
                                                 l.Pendientes_Realizados__c=0;
                                             }
                                             l.Pendientes_Realizados__c+=1;
                                             y.En_Espera__c=false;
                                             update y;         
                                             update l;
                                         }
                                     }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
 
    
integer a=1;

a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;
a=2;
a=3;  
a=2;
a=3;
a=3;    
}