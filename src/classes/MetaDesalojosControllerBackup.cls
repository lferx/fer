public with sharing class MetaDesalojosControllerBackup {
    
    public Integer censo=0;
    public Integer tramite_de_poder=0;
    public Integer recepcion_de_poder=0;
    public Integer tramite_de_copias_certificadas=0;
    public Integer elaboracion_de_demanda=0;
    public Integer ingreso_demanda=0;
    public Integer acuerdo_de_admision=0;
    public Integer notificacion=0;
    public Integer notificacion_2=0;
    public Integer notificacion_3=0;
    public Integer termino_de_notificacion=0;
    public Integer desahogo_pruebas=0;
    public Integer fecha_de_audiencia=0;
    public Integer solicita_sentencia=0;
    public Integer se_dicta_sentencia=0;
    public Integer ejecucion=0;
    public Integer re_invadida=0;
    public Integer amparo=0;
    public Integer desalojada=0;
    public List<Oferta__C> ofertas {get;set;}
    public List<SelectOption> fechaLst;
    public String fechaSeleccionada{get;set;}
    public List<SelectOption> mesLst;
    public String mesSeleccionado{get;set;}
    public List<SelectOption> anoLst;
    public String anoSeleccionado{get;set;}
    public DateTime fecha_ini;
    public DateTime fecha_fin;
    
    // 2016-11-08T00:00:00.000Z  2016-11-25T23:59:59Z

    public MetaDesalojosControllerBackup(ApexPages.StandardController controller) {
        ofertas =[SELECT Plaza__c, Name, (SELECT Documento__c.Name FROM Documentos__r 
                                          WHERE Fecha_Cierre__c >= :fecha_ini
                                          AND Fecha_Cierre__c <= :fecha_fin
                                          AND EtapaOferta__r.Etapa__r.Name = 'Desalojo')
                  FROM Oferta__c
                  ORDER BY Plaza__c];    
    }
    
    public List<SelectOption> getFechaLst(){
    
        List<SelectOption> fechaLst = new List<SelectOption>();
        
        fechaLst.add(new SelectOption('','-None-'));
        
        
        for(Integer i=1;i<32;i++){
            string s=string.valueof(i);
            fechaLst.add(new SelectOption('0'+s,s));
        }
        
        return fechaLst;
    }
    
    public List<SelectOption> getMesLst(){
    
        List<SelectOption> mesLst = new List<SelectOption>();
        
        mesLst.add(new SelectOption('','-None-'));
        mesLst.add(new SelectOption('01','Enero'));
        mesLst.add(new SelectOption('02','Febrero'));
        mesLst.add(new SelectOption('03','Marzo'));
        mesLst.add(new SelectOption('04','Abril'));
        mesLst.add(new SelectOption('05','Mayo'));
        mesLst.add(new SelectOption('06','Junio'));
        mesLst.add(new SelectOption('07','Julio'));
        mesLst.add(new SelectOption('08','Agosto'));
        mesLst.add(new SelectOption('09','Septiembre'));
        mesLst.add(new SelectOption('10','Octubre'));
        mesLst.add(new SelectOption('11','Noviembre'));
        mesLst.add(new SelectOption('12','Diciembre'));
        
        return mesLst;
    }
    
    public List<SelectOption> getAnoLst(){
    
        List<SelectOption> anoLst = new List<SelectOption>();
        
        anoLst.add(new SelectOption('','-None-'));
        anoLst.add(new SelectOption('2015','2015'));
        anoLst.add(new SelectOption('2016','2016'));
        anoLst.add(new SelectOption('2017','2017'));
        anoLst.add(new SelectOption('2018','2018'));
        anoLst.add(new SelectOption('2019','2019'));
        anoLst.add(new SelectOption('2020','2020'));
        anoLst.add(new SelectOption('2021','2021'));
        anoLst.add(new SelectOption('2022','2022'));
        anoLst.add(new SelectOption('2023','2023'));
        anoLst.add(new SelectOption('2024','2024'));
        anoLst.add(new SelectOption('2025','2025'));
        
        return anoLst;
    }
    
      
    
    public Integer getCenso(){
        
        censo = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Censo' 
        AND Fecha_Cierre__c >= :fecha_ini
        AND Fecha_Cierre__c <= :fecha_fin];
        
        return(censo);
    
    }
    
    
    public Integer gettramite_de_poder(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Trámite de Poder' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getrecepcion_de_poder(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Recepción de Poder' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer gettramite_de_copias_certificadas(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Trámite de Copias Certificada' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getelaboracion_de_demanda(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Elaboración de Demanda' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getingreso_demanda(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Ingreso de Demanda' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getacuerdo_de_admision(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Acuerdo de Admisión' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getnotificacion(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Notificación 1' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getnotificacion_2(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Notificación 2' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getnotificacion_3(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Notificación 3' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer gettermino_de_notificacion(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Termino de Notificación' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getdesahogo_pruebas(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Desahogo de Prueba' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getfecha_de_audiencia(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Fecha de Audiencia' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getsolicita_sentencia(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Solicitud de Sentencia' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getse_dicta_sentencia(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'Se dicta sentencia' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
       
        return(contador);
    
    }
    
    public Integer getejecucion(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'X' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getre_invadida(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'X' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getamparo(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'X' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    public Integer getdesalojada(){
    
        Integer contador = [SELECT COUNT()
        FROM Documento__c 
        WHERE Name = 'X' 
        AND Fecha_Cierre__c >= 2016-11-08T00:00:00.000Z 
        AND Fecha_Cierre__c <= 2016-11-24T23:59:59.000Z];
        
        return(contador);
    
    }
    
    
    public void asignaFecha(){
    
        DateTime fecha_ini = DateTime.parse(fechaSeleccionada+'/'+mesSeleccionado+'/'+anoSeleccionado+' 12:00 AM');
        DateTime fecha_fin = DateTime.parse(fechaSeleccionada+'/'+mesSeleccionado+'/'+anoSeleccionado+' 11:59 PM');
        ofertas =[SELECT Plaza__c, Name, (SELECT Documento__c.Name FROM Documentos__r 
                                          WHERE Fecha_Cierre__c >= :fecha_ini
                                          AND Fecha_Cierre__c <= :fecha_fin
                                          AND EtapaOferta__r.Etapa__r.Name = 'Desalojo')
                  FROM Oferta__c
                  ORDER BY Plaza__c];
       
    }
    
    public void actualizar(){
        DateTime fecha_ini = DateTime.parse(fechaSeleccionada+'/'+mesSeleccionado+'/'+anoSeleccionado+' 12:00 AM');
        DateTime fecha_fin = DateTime.parse(fechaSeleccionada+'/'+mesSeleccionado+'/'+anoSeleccionado+' 11:59 PM');
        asignaFecha();
        censo=0;
    }

   
}