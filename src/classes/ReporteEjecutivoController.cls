public with sharing class ReporteEjecutivoController {
                
    //Etapa 8
    public list<Documento__c> ldocuIni8 {get; set;}
    public list<Documento__c> ldocuFin8 {get; set;}
    
    public map<String,cEtapa8> mInfoEtapa8 = new map<String,cEtapa8>();
    public map<String, Integer> mEtapa8Ptes = new map<String, Integer>();
    public map<String, Integer> mEtapa8Reg = new map<String, Integer>();
    public map<String, Integer> mEtapa8Acum = new map<String, Integer>();
    public map<String, String > sOwnPza8 = new map<String, String>();
    
    public integer isumComEtapa8 {get; set;}
    public integer isumRegEtapa8 {get; set;}
    public integer isumPteEtapa8 {get; set;}
    
    //Etapa 9
    public list<EtapaOferta__c> lstock9 {get; set;}
    public list<Documento__c> lingEsc9 {get; set;}
    public list<Documento__c> loftaSem9 {get; set;} 
    public list<Documento__c> loftaAcum9 {get; set;}
    
    public map<String,cEtapa9> mInfoEtapa9 = new map<String,cEtapa9>();
    public map<String, Integer> mEtapa9stk = new map<String, Integer>();
    public map<String, Integer> mEtapa9Esc = new map<String, Integer>();
    public map<String, Integer> mEtapa9Oft = new map<String, Integer>();
    public map<String, String > sOwnPza9 = new map<String, String>();
    
    public integer isumEscEtapa9 {get; set;}
    public integer isumOftEtapa9 {get; set;}
    public integer isumStkEtapa9 {get; set;}
    public integer isumAcumEtapa9 {get; set;}
    
    public string sQueryEtapa9 {get; set;}
    public string sQueryEtapa9a {get; set;}
    
    //Etapa 10 y 10.1
    
    public string sQueryEtapa101 {get; set;}
    public string sQueryEtapa101a {get; set;}
    public string sQueryEtapa101b {get; set;}
    
    public list<Documento__c> lInvNoPag101 {get; set;}
    public list<Documento__c> lInvmas5101 {get; set;}
    public list<Documento__c> lInvmenos5101 {get; set;} 
    public list<Documento__c> lInvNoPag10a {get; set;}
    public list<Documento__c> lInvmas510a {get; set;}
    public list<Documento__c> lInvmenos510a {get; set;} 
    public list<Documento__c> lInvNoPag10b {get; set;}
    public list<Documento__c> lInvmas510b {get; set;}
    public list<Documento__c> lInvmenos510b {get; set;} 
    
    public map<String,cEtapa10> mInfoEtapa101 = new map<String,cEtapa10>();
    public map<String, Integer> mEtapa101NoPag = new map<String, Integer>();
    public map<String, Integer> mEtapa101Mas5 = new map<String, Integer>();
    public map<String, Integer> mEtapa101Menos5 = new map<String, Integer>();
    public map<String,cEtapa10> mInfoEtapa10a = new map<String,cEtapa10>();
    public map<String, Integer> mEtapa10aNoPag = new map<String, Integer>();
    public map<String, Integer> mEtapa10aMas5 = new map<String, Integer>();
    public map<String, Integer> mEtapa10aMenos5 = new map<String, Integer>();
    public map<String,cEtapa10> mInfoEtapa10b = new map<String,cEtapa10>();
    public map<String, Integer> mEtapa10bNoPag = new map<String, Integer>();
    public map<String, Integer> mEtapa10bMas5 = new map<String, Integer>();
    public map<String, Integer> mEtapa10bMenos5 = new map<String, Integer>();
    
    public set<String> sPza = new set<String>();
    public set<String> sPzaa = new set<String>();
    public set<String> sPzab = new set<String>();
    
    public integer isumInvEtapa101 {get; set;}
    public integer isumDesEtapa101 {get; set;}
    public integer isumChgEtapa101 {get; set;}
    public integer isumRehEtapa10a {get; set;}
    public integer isumChgEtapa10a {get; set;}
    public integer isumRehEtapa10b {get; set;}
    public integer isumRehdasEtapa10b {get; set;}
    public integer isumChgEtapa10b {get; set;}
    public integer isumAcuEtapa10b {get; set;}
    
    //Etapa 11
    public list<Documento__c> lOfNoPag11a {get; set;}
    public list<Documento__c> lOfmas511a {get; set;}
    public list<Documento__c> lOfmenos511a {get; set;} 
    public list<Documento__c> lOfNoPag11b {get; set;}
    public list<Documento__c> lOfmas511b {get; set;}
    public list<Documento__c> lOfmenos511b {get; set;}
    public list<Documento__c> lOfmas511c {get; set;}
    public list<Documento__c> lOfmenos511c {get; set;} 
    public list<Documento__c> lOfmas511d {get; set;}
    public list<Documento__c> lOfmenos511d {get; set;}
    
    
    public map<String,cEtapa10> mInfoEtapa11a = new map<String,cEtapa10>();
    public map<String, Integer> mEtapa11aNoPag = new map<String, Integer>();
    public map<String, Integer> mEtapa11aMas5 = new map<String, Integer>();
    public map<String, Integer> mEtapa11aMenos5 = new map<String, Integer>();
    public map<String,cEtapa10> mInfoEtapa11b = new map<String,cEtapa10>();
    public map<String, Integer> mEtapa11bNoPag = new map<String, Integer>();
    public map<String, Integer> mEtapa11bMas5 = new map<String, Integer>();
    public map<String, Integer> mEtapa11bMenos5 = new map<String, Integer>();
    public map<String,cEtapa10> mInfoEtapa11c = new map<String,cEtapa10>();
    public map<String, Integer> mEtapa11cMas5 = new map<String, Integer>();
    public map<String, Integer> mEtapa11cMenos5 = new map<String, Integer>();
    public map<String,cEtapa10> mInfoEtapa11d = new map<String,cEtapa10>();
    public map<String, Integer> mEtapa11dMas5 = new map<String, Integer>();
    public map<String, Integer> mEtapa11dMenos5 = new map<String, Integer>();
    
    public set<String> sPza11a = new set<String>();
    public set<String> sPza11b = new set<String>();
    public set<String> sPza11c = new set<String>();
    public set<String> sPza11d = new set<String>();
    
    public integer isumAvaEtapa11 {get; set;}
    public integer isumClgEtapa11 {get; set;}
    public integer isumChgEtapa11 {get; set;}
    public integer isumInfEtapa11 {get; set;}
    public integer isumNotEtapa11 {get; set;}
    public integer isumChgEtapa11c {get; set;}
    public integer isumExpEtapa11 {get; set;}
    public integer isumChgEtapa11d {get; set;}
    //Etapa 12
    public list<Documento__c> lOfNci12 {get; set;}
    public list<Documento__c> lOfInIn12 {get; set;}
    
    public map<String,cEtapa12> mInfoEtapa12 = new map<String,cEtapa12>();
    public map<String, Integer> mEtapa12Nci = new map<String, Integer>();
    public map<String, Integer> mEtapa12InIn = new map<String, Integer>();
    
    public map<String, cSupGer > sOwnPza12 = new map<String, cSupGer>();
    
    //Etapa 13
    public list<Documento__c> lOfxDet13 {get; set;}
    public list<Documento__c> lPrePan13 {get; set;}
    public list<Documento__c> lOfDet13 {get; set;}
    
    
    public map<String, Integer> mEtapa13xDet = new map<String, Integer>();
    public map<String, Integer> mEtapa13PrePan = new map<String, Integer>();
    public map<String, Integer> mEtapa13Det = new map<String, Integer>();
    
    public integer isumExpEtapa12 {get; set;}
    public integer isumCobEtapa12 {get; set;}
    public integer isumChgEtapa12 {get; set;}
    public integer isumAcuEtapa13 {get; set;}
    
    public integer isumContado {get; set;}
    
    
    //Resumen
    
    public map<Integer, String> mEtapaName = new map<Integer, String>();
    list<EtapaOferta__c> lEtapaOfI {get; set;}
    list<EtapaOferta__c> lEtapaOfF {get; set;}
    public map<Integer, list<EtapaOferta__c>> mEtapaOfE = new map<Integer, list<EtapaOferta__c>>();
    public map<Integer, list<EtapaOferta__c>> mEtapaOfS = new map<Integer, list<EtapaOferta__c>>();
    public map<Integer, cResumen > mInfoRes = new map<Integer, cResumen>();
    public map<Integer, Integer> mResEtEnt = new map<Integer, Integer>();
    public map<Integer, Integer> mResEtSal = new map<Integer, Integer>();
    
    public map<Integer, Integer> mResEtAcu = new map<Integer, Integer>();
    
    //public map<Integer, list
    
    // 
    public list<Documento__c> ldocplaza {get;set;}
    public date dhoy {get;set;}
    public datetime dthoy;
    public date dIniSem;
    public date dFinSem; 
    public string shoy {get;set;}
    public string stockhoy {get;set;}
    public map<String, User> musers = new map<String, User>();
       
    public integer iRmetaMensual {get;set;}
    public integer iRmetaDiaria {get;set;}
    public integer iEmetaSemanal {get;set;}
    public integer iEmetaDiaria {get;set;}
    public integer iOmetaSemanal {get;set;}
    public integer iOmetaDiaria {get;set;}
    
    public ReporteEjecutivoController()
    { 
        dhoy = date.Today();
        dthoy = system.now();
        shoy = string.valueOf(dhoy);
        dIniSem = dhoy.toStartofWeek();
        dFinSem = dIniSem + 7;
        stockhoy = 'Stock (' + shoy + ')'; 
        
        for (Metas__c met :[Select Name, Meta_Mensual__c, Meta_Semanal__c, Meta_Diaria__c From Metas__c])
        {
            if( met.Name == 'Rehabilitacion')
            {
                iRmetaMensual = met.Meta_Mensual__c.intValue();
                iRmetaDiaria = met.Meta_Diaria__c.intValue();
            }
            if(met.Name == 'Expediente')
            {
                iEmetaSemanal = met.Meta_Semanal__c.intValue();
                iEmetaDiaria = met.Meta_Diaria__c.intValue();  
            }
            if(met.Name == 'Oferta')
            {
                iOmetaSemanal = met.Meta_Semanal__c.intValue();
                iOmetaDiaria = met.Meta_Diaria__c.intValue(); 
            }
        }
     
        // Etapa 8 Escrituras Registradas
        
        for (User suser :[SELECT id, Name, ManagerId FROM User])
        {
            musers.put(suser.id, suser);
        }
        
        list<EtapaOferta__c> lstock8open = new list<EtapaOferta__c>();
        lstock8open = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Oferta__r.OwnerId 
                             FROM EtapaOferta__c WHERE NumEtapa__c =: 8 AND Estatus__c =: 'Abierta' AND Oferta__r.FechaCobro__c =: null
                             AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                             Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c]; 
        set<string> sofertaE8open = new set<string>();
        for (EtapaOferta__c etof :lstock8open)
        {
            sofertaE8open.add(etof.Oferta__c);
        }
        
        ldocuIni8 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                     Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name,   
                     Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
                     FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 8 AND Oferta__r.FechaCobro__c =: null
                     AND Cerrado__c =: true AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND DocumentoEtapa__r.Orden__c = : 5
                     AND Oferta__c IN: sofertaE8open
                     Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
                     
        set<string> sofertaE8Reg = new set<string>();
        for (Documento__c doc :ldocuIni8)
        {
            sofertaE8Reg.add(doc.Oferta__c);
        }
        list<EtapaOferta__c> lPendientes8 = new list<EtapaOferta__c>();
        lPendientes8 = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Oferta__r.OwnerId 
                        FROM EtapaOferta__c WHERE NumEtapa__c =: 8 AND Estatus__c =: 'Abierta' AND Oferta__r.FechaCobro__c =: null
                        AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__c NOT IN: sofertaE8Reg 
                        Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c]; 
        
        
        ldocuFin8 = [SELECT id, Oferta__c, Name, Fecha_Cierre__c, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                     Fecha_Com_Controller__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Owner.Name,  
                     Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
                     FROM Documento__c WHERE Iniciado__c =: true AND DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 8
                     AND Cerrado__c =: true AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.FechaCobro__c =: null
                     AND Fecha_Cierre__c = THIS_WEEK AND DocumentoEtapa__r.Orden__c =: 5
                     Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        
        isumComEtapa8 = 0;
        isumRegEtapa8 = 0;
        isumPteEtapa8 = 0;
        for (EtapaOferta__c etof :lPendientes8)
        {
           sOwnPza8.put(etof.Oferta__r.OwnerId + etof.Oferta__r.Propiedad__r.Plaza__c,etof.Oferta__r.Owner.Name); 
           isumComEtapa8++;
           isumPteEtapa8++;
           if(mEtapa8Ptes.get(etof.Oferta__r.OwnerId + etof.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
               mEtapa8Ptes.put(etof.Oferta__r.OwnerId + etof.Oferta__r.Propiedad__r.Plaza__c, 1);
               
           }else
           {
               integer iadd = mEtapa8Ptes.get(etof.Oferta__r.OwnerId + etof.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa8Ptes.put(etof.Oferta__r.OwnerId + etof.Oferta__r.Propiedad__r.Plaza__c, iadd);
           }                                   
        }
        for (Documento__c doc :ldocuFin8)
        {
           sOwnPza8.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, doc.Owner.Name); 
           if(mEtapa8Acum.get(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
               mEtapa8Acum.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, 1);
               if (doc.Fecha_Cierre__c.date() == dhoy)
               {               
                  isumComEtapa8++;
                  isumRegEtapa8++;
                  mEtapa8Reg.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, 1);
               } else
               {
                  mEtapa8Reg.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, 0);
               }
                 
               
           }else
           {
               integer iadd1 = (mEtapa8Acum.get(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c)) + 1;
               mEtapa8Acum.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, iadd1);
               if (doc.Fecha_Cierre__c.Date() == dhoy)
               {
                  isumComEtapa8++;
                  isumRegEtapa8++;
                  integer iadd2 = mEtapa8Reg.get(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
                  mEtapa8Reg.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, iadd2); 
               }                               
           }                                   
        }
        
        
         // Etapa 9 Ofertas
        list<EtapaOferta__c> lstock8 = new list<EtapaOferta__c>();
        lstock8 = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Oferta__r.OwnerId 
                             FROM EtapaOferta__c WHERE NumEtapa__c =: 8 AND Estatus__c =: 'Cerrada' AND Oferta__r.FechaCobro__c =: null
                             AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                             Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c]; 
        set<string> sofertaE8a = new set<string>();
        for (EtapaOferta__c etof :lstock8)
        {
            sofertaE8a.add(etof.Oferta__c);
        }
        
        lstock9 = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Oferta__r.OwnerId 
                     FROM EtapaOferta__c WHERE NumEtapa__c =: 9 AND Estatus__c =: 'Abierta' AND Oferta__r.FechaCobro__c =: null
                     AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                     AND Oferta__c IN: sofertaE8a
                     Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c]; 
        
        set<string> sofaux9 = new set<string>();
        
        for(EtapaOferta__c doc9 :lstock9)
        {
            sofaux9.add(doc9.Oferta__c);
        }
        sQueryEtapa9a = 'SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c, '  
                      + 'Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c, ' 
                      + 'Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c '
                      + 'FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =: btrue AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: ietapa AND Oferta__r.FechaCobro__c =: dnull '
                      + 'AND Cerrado__c =: btrue AND DocumentoEtapa__r.Orden__c =: iorden AND Fecha_Cierre__c = TODAY  AND Oferta__r.TipoOferta__c !=: scontado';
                     
        lingEsc9 = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                     Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                     Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                     FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 9 AND Oferta__r.TipoOferta__c !=: 'Contado'
                     AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 7 AND Fecha_Cierre__c = TODAY AND Oferta__r.FechaCobro__c =: null 
                     Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        loftaSem9 = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                     Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                     Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
                     FROM Documento__c WHERE Iniciado__c =: true AND DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 9
                     AND Cerrado__c =: true AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND DocumentoEtapa__r.Orden__c =: 7
                     AND Fecha_Cierre__c = THIS_WEEK AND Oferta__r.FechaCobro__c =: null AND Oferta__r.TipoOferta__c !=: 'Contado' 
                     Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
         loftaAcum9 = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                      Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                      Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                      FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 9 AND Oferta__r.TipoOferta__c !=: 'Contado'
                      AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 1 AND Fecha_Cierre__c = TODAY AND Oferta__r.FechaCobro__c =: null
                      Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
         
         isumEscEtapa9 = 0;
         isumOftEtapa9 = 0;
         isumStkEtapa9 = 0;
         isumAcumEtapa9 = 0;
        
        for (Documento__c doc :loftaAcum9) 
        { 
            isumAcumEtapa9++;
        }            
        for (EtapaOferta__c doc :lstock9)
        {
           sOwnPza9.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c,doc.Oferta__r.Owner.Name); 
           isumStkEtapa9++;
           
           if(mEtapa9stk.get(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
               mEtapa9stk.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, 1);
               
           }else
           {
               integer iadd = mEtapa9stk.get(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa9stk.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, iadd);
           }                                   
        }
        for (Documento__c doc :lingEsc9)
        {
           sOwnPza9.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c,doc.Oferta__r.Owner.Name); 
           isumEscEtapa9++;
           if(mEtapa9Esc.get(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
               mEtapa9Esc.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, 1);
               
           }else
           {
               integer iadd = mEtapa9Esc.get(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa9Esc.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, iadd);
           }                                   
        }
        for (Documento__c doc :loftaSem9)
        {
           sOwnPza9.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c,doc.Oferta__r.Owner.Name); 
           isumOftEtapa9++;
           if(mEtapa9Oft.get(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
               mEtapa9Oft.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, 1);
               
           }else
           {
               integer iadd = mEtapa9Oft.get(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa9Oft.put(doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, iadd);
           }                                   
        } 
        
        //Etapa 10 y 10.1
        
        lInvNoPag101 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                      Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                      Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
                      FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 
                      AND Iniciado__c =: false AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                      AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__r.Invadida__c =: true AND Iniciado__c =: false
                      AND DocumentoEtapa__r.Orden__c =: 1 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__r.FechaCobro__c =: null
                      Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c]; 
        
        set<string> sofertas10 = new set<string>();
        for(Documento__c doc :lInvNoPag101)
        {
            sofertas10.add(doc.Oferta__c);
        }
        
        
        list<EtapaOferta__c> letofertas101 = new list<EtapaOferta__c>();
        letofertas101 = [Select Oferta__c, Oferta__r.name, Oferta__r.Propiedad__r.Plaza__c From EtapaOferta__c Where Etapa__r.NumEtapa__c =: 10.1 
                          and Oferta__r.FechaCobro__c =: null and Oferta__r.Estatus__c !=: 'Finalizada' 
                          and Oferta__r.Invadida__c =: true and Oferta__r.Estatus__c !=: 'Descartada'
                          and Oferta__r.TipoOferta__c !=: 'Contado' and Oferta__c IN: sofertas10
                          Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c];                                  
        
        lInvmenos5101 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10.1 AND Oferta__r.Invadida__c =: true
                       AND Cerrado__c =: false AND Iniciado__c =: true AND (DocumentoEtapa__r.Orden__c =: 13 OR DocumentoEtapa__r.Orden__c =: 14) 
                       AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__r.FechaCobro__c =: null
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        
        set<string> sofaux101 = new set<string>();
        for (Documento__c doc :lInvmenos5101)
        {
            sofaux101.add(doc.Oferta__c);
        }
        lInvmenos5101.clear();
        lInvmenos5101 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10.1 AND Oferta__r.FechaCobro__c =: null
                       AND Fecha_Inicio__c = LAST_N_DAYS:5 AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 12 AND Oferta__c IN: sofaux101
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        
                     
            
        lInvmas5101 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10.1 AND Oferta__r.FechaCobro__c =: null
                       AND Fecha_Inicio__c < LAST_N_DAYS:5 AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 12 AND Oferta__c IN: sofaux101
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];  
        
        set<EtapaOferta__c> sInvNoPag101 = new set<EtapaOferta__c>();
        for (EtapaOferta__c etof :letofertas101)
        {
            if(sofaux101.contains(etof.Oferta__c) == false)
            {
               sInvNoPag101.add(etof);  
            }
        }
        
        
        isumInvEtapa101 = 0; 
        isumDesEtapa101 = [Select Count() From Documento__c Where DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10.1 AND Oferta__r.FechaCobro__c =: null
                           AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 13 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Fecha_Cierre__c = TODAY];  
        
                   
        isumChgEtapa101 = [Select Count() From Documento__c Where DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10.1 AND Oferta__r.FechaCobro__c =: null
                           AND Cerrado__c =: false AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 11 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Fecha_Inicio__c = TODAY];
                           
        integer isumchgaux = [Select Count() From Documento__c Where DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10.1 AND Oferta__r.FechaCobro__c =: null
                           AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 14 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Fecha_Cierre__c = TODAY];
        
        isumChgEtapa101 = isumChgEtapa101 - isumchgaux;
        
        for(EtapaOferta__c etof :sInvNoPag101)
        {
           
           isumInvEtapa101++;
           sPza.add(etof.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa101NoPag.get(etof.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa101NoPag.put(etof.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa101NoPag.get(etof.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa101NoPag.put(etof.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }  
        for(Documento__c doc :lInvmenos5101)
        {
           isumInvEtapa101++;
            
           sPza.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa101menos5.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa101menos5.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa101menos5.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa101menos5.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }
        for(Documento__c doc :lInvmas5101)
        {
           isumInvEtapa101++;
            
           sPza.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa101mas5.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa101mas5.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa101mas5.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa101mas5.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }
                
        
        lInvmenos510a = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10
                       AND Fecha_Inicio__c = LAST_N_DAYS:5 AND Cerrado__c =: false AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 1
                       AND Oferta__r.FechaCobro__c =: null AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__r.TipoOferta__c !=: 'Contado'
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        lInvmas510a = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10
                       AND Fecha_Inicio__c < LAST_N_DAYS:5 AND Cerrado__c =: false AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 1 
                       AND Oferta__r.FechaCobro__c =: null AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__r.TipoOferta__c !=: 'Contado'
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];  
        
        
                
        isumChgEtapa10a = [Select Count() From Documento__c Where DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 AND Oferta__r.FechaCobro__c =: null
                           AND Cerrado__c =: false AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 1 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Fecha_Inicio__c = TODAY];
        integer iauxsal = [Select Count() From Documento__c Where DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 AND Oferta__r.FechaCobro__c =: null
                           AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 2 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Fecha_Cierre__c = TODAY];
        isumChgEtapa10a = isumChgEtapa10a - iauxsal;
        isumRehEtapa10a = 0;
        for(Documento__c doc :lInvmenos510a)
        {
           isumRehEtapa10a++;
           sPzaa.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa10amenos5.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa10amenos5.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa10amenos5.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa10amenos5.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }
        for(Documento__c doc :lInvmas510a)
        {
           isumRehEtapa10a++;
           sPzaa.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa10amas5.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa10amas5.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa10amas5.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa10amas5.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        } 
        
        lInvNoPag10b = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                      Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                      Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
                      FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 
                      AND Cerrado__c =: false AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                      AND DocumentoEtapa__r.Orden__c =: 3 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__r.FechaCobro__c =: null AND Iniciado__c =: true
                      Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c]; 
        
        set<string> sofaux10b = new set<string>();
        for (Documento__c doc :lInvNoPag10b)
        {
            sofaux10b.add(doc.Oferta__c);
        }
        
        lInvNoPag10b.clear();
        lInvNoPag10b = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                      Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                      Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                      FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10
                      AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 1 AND Oferta__c IN: sofaux10b AND Oferta__r.FechaCobro__c =: null
                      Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c]; 
                      
         lInvmenos510b = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10
                       AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 2                      
                       AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__r.FechaCobro__c =: null
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
         
         set<string> sofaux10b2 = new set<string>();
         for (Documento__c doc :lInvmenos510b)
         {
            sofaux10b2.add(doc.Oferta__c);
         }
         lInvmenos510b.clear();
         
         lInvmenos510b = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                      Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                      Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
                      FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 AND Fecha_Cierre__c = LAST_N_DAYS:5 
                      AND Cerrado__c =: true AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                      AND DocumentoEtapa__r.Orden__c =: 3 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__r.FechaCobro__c =: null AND Oferta__c IN: sofaux10b2
                      Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];  
                      
         lInvmas510b = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                      Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                      Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
                      FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 AND Fecha_Cierre__c < LAST_N_DAYS:5 
                      AND Cerrado__c =: true AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                      AND DocumentoEtapa__r.Orden__c =: 3 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__r.FechaCobro__c =: null AND Oferta__c IN: sofaux10b2
                      Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];              
        
        
        
        isumRehEtapa10b = 0;
        isumRehdasEtapa10b = [Select Count() From Documento__c Where DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 AND Oferta__r.FechaCobro__c =: null
                           AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 4 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Fecha_Cierre__c = TODAY];
        isumAcuEtapa10b = [Select Count() From Documento__c Where DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 AND Oferta__r.FechaCobro__c =: null
                           AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 4 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Fecha_Cierre__c = THIS_WEEK];
        isumChgEtapa10b = [Select Count() From Documento__c Where DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 AND Oferta__r.FechaCobro__c =: null
                           AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 1 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Fecha_Cierre__c = TODAY];
        isumChgEtapa10b = isumChgEtapa10b - isumRehdasEtapa10b;                   
        for(Documento__c doc :lInvNoPag10b)
        {
           isumRehEtapa10b++; 
           sPzab.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa10bNoPag.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa10bNoPag.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa10bNoPag.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa10bNoPag.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }  
        for(Documento__c doc :lInvmenos510b)
        {
           isumRehEtapa10b++;
           sPzab.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa10bmenos5.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa10bmenos5.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa10bmenos5.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa10bmenos5.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }
        for(Documento__c doc :lInvmas510b)
        {
           isumRehEtapa10b++;
           sPzab.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa10bmas5.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa10bmas5.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa10bmas5.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa10bmas5.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }  
        
         //Etapa 11
        
        set<string> sofet11abierta = new set<string>();
        for(EtapaOferta__c et10Com :[Select Oferta__c From EtapaOferta__c Where NumEtapa__c =: 11 and Estatus__c =: 'Abierta' 
                                     AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.FechaCobro__c =: null
                                     AND Oferta__r.Estatus__c !=: 'Descartada'])
        {
            sofet11abierta.add(et10Com.Oferta__c);
        }
        set<string> sofet10completa = new set<string>();
        for(EtapaOferta__c et10Com :[Select Oferta__c From EtapaOferta__c Where NumEtapa__c = : 10 and Estatus__c =: 'Cerrada' and Oferta__c IN: sofet11abierta])
        {
            sofet10completa.add(et10Com.Oferta__c);
        }
        
        //Ingreso a Infonavit Primero                                
        
        lOfmenos511c = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                       AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 1
                       AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__c IN:sofet10completa 
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
                       
                       
                       
        set<string> sofaux11c = new set<string>();
        for (Documento__c doc :lOfmenos511c)
        {
            sofaux11c.add(doc.Oferta__c);
        }
        lOfmenos511c.clear();
            
        lOfmas511c = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                       AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 3
                       AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__c IN: sofaux11c 
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
            
            
            
        set<string> sofaux11c2 = new set<string>();
        for (Documento__c doc :lOfmas511c)
        {
            sofaux11c2.add(doc.Oferta__c);
        }
        lOfmas511c.clear();
            
        lOfmenos511c = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                        Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                        Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                        FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11
                        AND EtapaOferta__r.HoraInicial__c = LAST_N_DAYS:5 AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 9
                        AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__c IN: sofaux11c AND Oferta__r.FechaCobro__c =: null
                        Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        lOfmas511c = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                        Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                        Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                        FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11
                        AND EtapaOferta__r.HoraInicial__c < LAST_N_DAYS:5 AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 9
                        AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__c IN: sofaux11c AND Oferta__r.FechaCobro__c =: null
                        Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];  
        
        list<Documento__c> lOfmenos511c2 = new list<Documento__c>();
        list<Documento__c> lOfmas511c2 = new list<Documento__c>();
       
        lOfmenos511c2 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                        Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                        Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                        FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11
                        AND EtapaOferta__r.HoraInicial__c = LAST_N_DAYS:5 AND Cerrado__c =: false AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 9
                        AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__c IN: sofaux11c2 AND Oferta__r.FechaCobro__c =: null
                        Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        lOfmas511c2 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                        Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                        Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                        FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11
                        AND EtapaOferta__r.HoraInicial__c < LAST_N_DAYS:5 AND Cerrado__c =: false AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 9
                        AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__c IN: sofaux11c2 AND Oferta__r.FechaCobro__c =: null
                        Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];  
        
        lOfmenos511c.addall(lOfmenos511c2);
        lOfmas511c.addall(lOfmas511c2);
        
        
        /*    
        isumChgEtapa11c = [Select Count() From Documento__c Where DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11
                           AND Fecha_Inicio__c = TODAY AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 1 AND Oferta__r.FechaCobro__c =: null
                           AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__c IN:sofet10completa ];
        integer chgaux =  [Select Count() From Documento__c Where DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11
                           AND Fecha_Cierre__c = TODAY AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 9 AND Oferta__r.FechaCobro__c =: null
                           AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__c IN:sofet10completa ];   
        isumChgEtapa11c = isumChgEtapa11c - chgaux;   */            
        isumInfEtapa11 = 0;
        set<string> sofIngInf11 = new set<string>();
        
        for(Documento__c doc :lOfmenos511c)
        {
           sofIngInf11.add(doc.Oferta__c);
           isumInfEtapa11++;
           sPza11c.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa11cmenos5.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa11cmenos5.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa11cmenos5.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa11cmenos5.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }
        for(Documento__c doc :lOfmas511c)
        {
           sofIngInf11.add(doc.Oferta__c);
           isumInfEtapa11++;
           sPza11c.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa11cmas5.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa11cmas5.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa11cmas5.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa11cmas5.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        } 
        
        // Avaluo
        
        lOfNoPag11a = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                      Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                      Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
                      FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                      AND Cerrado__c =: false AND Iniciado__c =: true AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                      AND DocumentoEtapa__r.Orden__c =: 2 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__c IN:sofet10completa AND Oferta__c NOT IN: sofIngInf11
                      Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c]; 
        
        lOfmenos511a = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                       AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 2 AND Fecha_Cierre__c = LAST_N_DAYS:5 
                       AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.TipoOferta__c !=: 'Contado'
                       AND Oferta__c IN:sofet10completa 
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        
        set<string> sofaux11a = new set<string>();
        for (Documento__c doc :lOfmenos511a)
        {
            sofaux11a.add(doc.Oferta__c);
        }
        lOfmenos511a.clear();
        lOfmas511a = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                       AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 2 AND Fecha_Cierre__c < LAST_N_DAYS:5 
                       AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.TipoOferta__c !=: 'Contado'
                       AND Oferta__c IN:sofet10completa 
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        
        set<string> sofaux11a5 = new set<string>();
        for (Documento__c doc :lOfmas511a)
        {
            sofaux11a5.add(doc.Oferta__c);
        }
        lOfmas511a.clear();
        lOfmenos511a = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                       AND Cerrado__c =: false AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 1
                       AND Oferta__c IN: sofaux11a
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
                       
                       
        lOfmas511a = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                       AND Cerrado__c =: false AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 1
                       AND Oferta__c IN: sofaux11a5
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];  
        
        isumAvaEtapa11 = 0;
        isumClgEtapa11 = 0;
        isumChgEtapa11 = 0;
        
        for(Documento__c doc :lOfNoPag11a)
        {
           isumAvaEtapa11++;
           sPza11a.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa11aNoPag.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa11aNoPag.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa11aNoPag.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa11aNoPag.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }  
        for(Documento__c doc :lOfmenos511a)
        {
           isumAvaEtapa11++;
           sPza11a.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa11amenos5.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa11amenos5.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa11amenos5.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa11amenos5.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }
        for(Documento__c doc :lOfmas511a)
        {
           isumAvaEtapa11++;
           sPza11a.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa11amas5.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa11amas5.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa11amas5.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa11amas5.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        } 
        
        // CLG
        
        lOfNoPag11b = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                       AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 2
                       AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__c IN:sofaux11c 
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        
        set<string> sofaux11c11 = new set<string>();
        for (Documento__c doc :lOfNoPag11b)
        {
            sofaux11c11.add(doc.Oferta__c);
        }
        lOfNoPag11b.clear();
        lOfNoPag11b = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                      Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                      Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
                      FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                      AND Cerrado__c =: false AND Iniciado__c =: true AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                      AND DocumentoEtapa__r.Orden__c =: 4 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__c IN: sofaux11c11 AND Oferta__c NOT IN: sofIngInf11
                      Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c]; 
        
        lOfmenos511b = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                       AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 4 AND Fecha_Cierre__c = LAST_N_DAYS:5 
                       AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.TipoOferta__c !=: 'Contado'
                       AND Oferta__c IN:sofaux11c11
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        
        set<string> sofaux11b = new set<string>();
        for (Documento__c doc :lOfmenos511b)
        {
            sofaux11b.add(doc.Oferta__c);
        }
        lOfmenos511b.clear();
        lOfmas511b = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                       AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 4 AND Fecha_Cierre__c < LAST_N_DAYS:5 
                       AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.TipoOferta__c !=: 'Contado'
                       AND Oferta__c IN:sofaux11c11
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        
        set<string> sofaux11b5 = new set<string>();
        for (Documento__c doc :lOfmas511b)
        {
            sofaux11b5.add(doc.Oferta__c);
        }
        lOfmas511b.clear();
        lOfmenos511b = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                       AND Cerrado__c =: false AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 3
                       AND Oferta__c IN: sofaux11b AND Oferta__c NOT IN: sofIngInf11
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
                       
                       
        lOfmas511b = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                       Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                       Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                       FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 11 AND Oferta__r.FechaCobro__c =: null
                       AND Cerrado__c =: false AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 3
                       AND Oferta__c IN: sofaux11b5 AND Oferta__c NOT IN: sofIngInf11
                       Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c]; 
        
        for(Documento__c doc :lOfNoPag11b)
        {
           isumClgEtapa11++;
           sPza11b.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa11bNoPag.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa11bNoPag.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa11bNoPag.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa11bNoPag.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }  
        for(Documento__c doc :lOfmenos511b)
        {
           isumClgEtapa11++;
           sPza11b.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa11bmenos5.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa11bmenos5.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa11bmenos5.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa11bmenos5.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }
        for(Documento__c doc :lOfmas511b)
        {
           isumClgEtapa11++;
           sPza11b.add(doc.Oferta__r.Propiedad__r.Plaza__c);
           if(mEtapa11bmas5.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa11bmas5.put(doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa11bmas5.get(doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa11bmas5.put(doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        } 
        isumChgEtapa11 = isumClgEtapa11 - isumAvaEtapa11;
        
             
        
        //Etapa 12
        
        lOfNci12 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                    Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c, Oferta__r.Owner.Name, 
                    Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                    FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 12
                    AND Cerrado__c =: false AND EtapaOferta__r.Estatus__c =: 'Abierta' AND DocumentoEtapa__r.Orden__c =: 2
                    AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__r.FechaCobro__c =: null
                    Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
                    
         lOFInIn12 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                     Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c, Oferta__r.Owner.Name, 
                     Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                     FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 12
                     AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 2
                     AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__r.FechaCobro__c =: null AND EtapaOferta__r.Estatus__c =: 'Abierta'
                     Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        
        
        String sManager;  
        String sName;    
        isumExpEtapa12 = 0;       
        for(Documento__c doc :lOfNci12)
        {
           isumExpEtapa12++;
           if(musers.get(doc.Oferta__r.OwnerId).ManagerId != null)
           { 
               sManager = musers.get(doc.Oferta__r.OwnerId).ManagerId;
               sName = musers.get(sManager).Name;
           }else
           {               
               sManager = 'Sin Supervisor    ';
               sName = 'Sin Supervisor';
           }
           sOwnPza12.put( sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, new cSupGer(sName, doc.Oferta__r.Owner.Name)); 
           if(mEtapa12Nci.get(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa12Nci.put(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa12Nci.get(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa12Nci.put(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, iadd);
           }    
        }
        for(Documento__c doc :lOFInIn12)
        {
           isumExpEtapa12++;
           if(musers.get(doc.Oferta__r.OwnerId).ManagerId != null)
           { 
               sManager = musers.get(doc.Oferta__r.OwnerId).ManagerId;
               sName = musers.get(sManager).Name;
           }else
           {
               sManager = 'Sin Supervisor    ';
               sName = 'Sin Supervisor';
           }
           sOwnPza12.put( sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, new cSupGer(sName, doc.Oferta__r.Owner.Name));  
           if(mEtapa12InIn.get(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa12InIn.put(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa12InIn.get(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa12InIn.put(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        } 
        
        //Etapa 13
        set<string> sofet13abierta = new set<string>();
        for(EtapaOferta__c et10Com :[Select Oferta__c From EtapaOferta__c Where NumEtapa__c =: 13 and Estatus__c =: 'Abierta' 
                                     AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.FechaCobro__c =: null
                                     AND Oferta__r.Estatus__c !=: 'Descartada'])
        {
            sofet13abierta.add(et10Com.Oferta__c);
        }
        set<string> sofet12completa = new set<string>();
        for(EtapaOferta__c et12Com :[Select Oferta__c From EtapaOferta__c Where NumEtapa__c = : 12 and Estatus__c =: 'Cerrada' and Oferta__c IN: sofet13abierta])
        {
            sofet12completa.add(et12Com.Oferta__c);
        }
        /*
        lOfxDet13 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                    Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                    Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                    FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 13
                    AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.TipoOferta__c !=: 'Contado'
                    AND Cerrado__c =: false AND DocumentoEtapa__r.Orden__c =: 10 AND Oferta__r.FechaCobro__c =: null
                    AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__c IN: sofet12completa
                    Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
                    
        set<string> sofaux13 = new set<string>();
        for (Documento__c doc :lOfxDet13)
        {
            sofaux13.add(doc.Oferta__c);
        }
        lOfxDet13.clear();
        */
        lOfxDet13 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                    Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c, Oferta__r.Owner.Name, 
                    Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                    FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 13
                    AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.TipoOferta__c !=: 'Contado'
                    AND Cerrado__c =: false AND DocumentoEtapa__r.Orden__c =: 24 AND Oferta__r.FechaCobro__c =: null
                    AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__c IN: sofet12completa
                    Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        lPrePan13 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                    Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c, Oferta__r.Owner.Name, 
                    Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                    FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 13
                    AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.TipoOferta__c !=: 'Contado'
                    AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 24 AND Oferta__r.FechaCobro__c =: null
                    AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__c IN: sofet12completa
                    Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        
        lOFDet13 =  [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                     Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c, Oferta__r.Owner.Name, 
                     Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                     FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 13
                     AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.TipoOferta__c !=: 'Contado'
                     AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 10 AND Oferta__r.FechaCobro__c =: null
                     AND EtapaOferta__r.Estatus__c =: 'Abierta'
                     Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
        list<Oferta__c> lOfCobradas = new list<Oferta__c>();
        lOfCobradas = [Select Id, Estatus__c, FechaCobro__c From Oferta__c Where Estatus__c =: 'Cobrada' and FechaCobro__c = THIS_WEEK];
        
        
        isumChgEtapa12 = [Select Count() FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 13
                          AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.TipoOferta__c !=: 'Contado'
                          AND Cerrado__c =: false AND DocumentoEtapa__r.Orden__c =: 10 AND Oferta__r.FechaCobro__c =: null
                          AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Fecha_Inicio__c = TODAY];
                          
        
        isumCobEtapa12 = 0;
        isumAcuEtapa13 = 0;
        
        
        
        for(Oferta__c oftot :lOfCobradas)
        {
            if(oftot.FechaCobro__c == dhoy)
               isumCobEtapa12++;
            isumAcuEtapa13++;
        }
                     
        for(Documento__c doc :lOfxDet13)
        {
           
           if(musers.get(doc.Oferta__r.OwnerId).ManagerId != null)
           { 
               sManager = musers.get(doc.Oferta__r.OwnerId).ManagerId;
               sName = musers.get(sManager).Name;
           }else
           {
               sManager = 'Sin Supervisor    ';
               sName = 'Sin Supervisor';
           }
           sOwnPza12.put( sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, new cSupGer(sName, doc.Oferta__r.Owner.Name)); 
           if(mEtapa13xDet.get(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa13xDet.put(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa13xDet.get(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa13xDet.put(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }
        for(Documento__c doc :lPrePan13)
        {
           
           if(musers.get(doc.Oferta__r.OwnerId).ManagerId != null)
           { 
               sManager = musers.get(doc.Oferta__r.OwnerId).ManagerId;
               sName = musers.get(sManager).Name;
           }else
           {
               sManager = 'Sin Supervisor    ';
               sName = 'Sin Supervisor';
           }
           sOwnPza12.put( sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, new cSupGer(sName, doc.Oferta__r.Owner.Name)); 
           if(mEtapa13PrePan.get(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa13PrePan.put(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa13PrePan.get(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa13PrePan.put(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        }
        for(Documento__c doc :lOfDet13)
        {
           
           if(musers.get(doc.Oferta__r.OwnerId).ManagerId != null)
           { 
               sManager = musers.get(doc.Oferta__r.OwnerId).ManagerId;
               sName = musers.get(sManager).Name;
           }else
           {
               sManager = 'Sin Supervisor    ';
               sName = 'Sin Supervisor';
           }
           sOwnPza12.put( sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, new cSupGer(sName, doc.Oferta__r.Owner.Name));  
           if(mEtapa13Det.get(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
                mEtapa13Det.put(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c, 1);
           }else
           {
               integer iadd = mEtapa13Det.get(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c) + 1;
               mEtapa13Det.put(sManager + doc.Oferta__r.OwnerId + doc.Oferta__r.Propiedad__r.Plaza__c,iadd);
           }    
        } 
        
        
        // Contado
        
        isumContado = [Select Count() From Oferta__c Where Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada' AND TipoOferta__c =: 'Contado'
                       AND FechaCobro__c =: null];
        
        
        // Resumen
        
        lEtapaOfI = [Select Id, Name, NumEtapa__c, Nombre_etapa__c, Oferta__c, Estatus__c, Oferta__r.Estatus__c,
                    HoraInicial__c, HoraFinal__c 
                    From EtapaOferta__c Where HoraInicial__c = TODAY AND Oferta__r.FechaCobro__c =: null AND Oferta__r.TipoOferta__c !=: 'Contado' and 
                    (Etapa__r.EstatusOferta__c =: 'Compra' or Etapa__r.EstatusOferta__c =: 'Venta') and NumEtapa__c > 7 Order by NumEtapa__c];
        lEtapaOfF = [Select Id, Name, NumEtapa__c, Nombre_etapa__c, Oferta__c, Estatus__c, Oferta__r.Estatus__c,
                    HoraInicial__c, HoraFinal__c 
                    From EtapaOferta__c Where HoraFinal__c = THIS_WEEK AND Oferta__r.FechaCobro__c =: null AND Oferta__r.TipoOferta__c !=: 'Contado' and
                    (Etapa__r.EstatusOferta__c =: 'Compra' or Etapa__r.EstatusOferta__c =: 'Venta') and NumEtapa__c > 7 Order by NumEtapa__c];   
                              
        for (EtapaOferta__c etof :lEtapaOfI)
        {
            if(mEtapaName.get(etof.NumEtapa__c.intValue()) == null)
            {
               mEtapaName.put(etof.NumEtapa__c.intValue(), etof.Nombre_etapa__c);
            }
            if(mResEtEnt.get(etof.NumEtapa__c.intValue()) == null)
            {
               mResEtEnt.put(etof.NumEtapa__c.intValue(), 1);
            }else
            {
               integer iaddR = mResEtEnt.get(etof.NumEtapa__c.intValue()) + 1;
               mResEtEnt.put(etof.NumEtapa__c.intValue(), iaddR);
               
            }
            
        } 
        for (EtapaOferta__c etof :lEtapaOfF)
        {   
            if(mEtapaName.get(etof.NumEtapa__c.intValue()) == null)
            {
               mEtapaName.put(etof.NumEtapa__c.intValue(), etof.Nombre_etapa__c);
            }
            if (etof.HoraFinal__c.date() == dhoy)
            {
                if(mResEtSal.get(etof.NumEtapa__c.intValue()) == null)
                {
                    mResEtSal.put(etof.NumEtapa__c.intValue(), 1);
                }else
                {
                    integer iaddR1 = mResEtSal.get(etof.NumEtapa__c.intValue()) + 1;
                    mResEtSal.put(etof.NumEtapa__c.intValue(), iaddR1);
                }       
            }
              
            if(mResEtAcu.get(etof.NumEtapa__c.intValue()) == null)
            {
               mResEtAcu.put(etof.NumEtapa__c.intValue(), 1);
            }else
            {
               integer iaddR2 = mResEtAcu.get(etof.NumEtapa__c.intValue()) + 1;
               mResEtAcu.put(etof.NumEtapa__c.intValue(), iaddR2);
            }       
        }
                           
    }
    
    public map<String,cEtapa8> getmInfoEtapa8()
    {
        for (String ownPza :sOwnPza8.keySet())
        {
           cEtapa8 infoEtapa8 = new cEtapa8(mEtapa8Ptes.get(ownPza),mEtapa8Reg.get(ownPza), mEtapa8Acum.get(ownPza), sOwnPza8.get(ownPza), ownPza.substring(18));
           mInfoEtapa8.put(ownPza, infoEtapa8);           
            
        }
        return mInfoEtapa8;
    }
    
    public map<String,cEtapa9> getmInfoEtapa9()
    {
        for (String ownPza :sOwnPza9.keySet())
        {
           cEtapa9 infoEtapa9 = new cEtapa9(mEtapa9stk.get(ownPza),mEtapa9Esc.get(ownPza), mEtapa9Oft.get(ownPza), sOwnPza9.get(ownPza), ownPza.substring(18));
           mInfoEtapa9.put(ownPza, infoEtapa9);           
            
        }
        return mInfoEtapa9;
    }
    
    public map<String,cEtapa10> getmInfoEtapa101()
    {
        for (String Pza :sPza)
        {
           cEtapa10 infoEtapa101 = new cEtapa10(mEtapa101NoPag.get(Pza),mEtapa101Menos5.get(Pza), mEtapa101Mas5.get(Pza), '', Pza);
           mInfoEtapa101.put(Pza, infoEtapa101);           
            
        }
        return mInfoEtapa101;
    }
    
    public map<String,cEtapa10> getmInfoEtapa10a()
    {
        for (String Pza :sPzaa)
        {
           cEtapa10 infoEtapa10a = new cEtapa10(0,mEtapa10aMenos5.get(Pza), mEtapa10aMas5.get(Pza), '', Pza);
           mInfoEtapa10a.put(Pza, infoEtapa10a);           
            
        }
        return mInfoEtapa10a;
    }
    
    public map<String,cEtapa10> getmInfoEtapa10b()
    {
        for (String Pza :sPzab)
        {
           cEtapa10 infoEtapa10b = new cEtapa10(mEtapa10bNoPag.get(Pza),mEtapa10bMenos5.get(Pza), mEtapa10bMas5.get(Pza), '', Pza);
           mInfoEtapa10b.put(Pza, infoEtapa10b);           
            
        }
        return mInfoEtapa10b;
    }
    
    public map<String,cEtapa10> getmInfoEtapa11a()
    {
        for (String Pza :sPza11a)
        {
           cEtapa10 infoEtapa11a = new cEtapa10(mEtapa11aNoPag.get(Pza),mEtapa11aMenos5.get(Pza), mEtapa11aMas5.get(Pza), '', Pza);
           mInfoEtapa11a.put(Pza, infoEtapa11a);           
            
        }
        return mInfoEtapa11a;
    }
    
    public map<String,cEtapa10> getmInfoEtapa11b()
    {
        for (String Pza :sPza11b)
        {
           cEtapa10 infoEtapa11b = new cEtapa10(mEtapa11bNoPag.get(Pza),mEtapa11bMenos5.get(Pza), mEtapa11bMas5.get(Pza), '', Pza);
           mInfoEtapa11b.put(Pza, infoEtapa11b);           
            
        }
        return mInfoEtapa11b;
    }
    
    public map<String,cEtapa10> getmInfoEtapa11c()
    {
        for (String Pza :sPza11c)
        {
           cEtapa10 infoEtapa11c = new cEtapa10(0,mEtapa11cMenos5.get(Pza), mEtapa11cMas5.get(Pza), '', Pza);
           mInfoEtapa11c.put(Pza, infoEtapa11c);           
            
        }
        return mInfoEtapa11c;
    }
    
    public map<String,cEtapa10> getmInfoEtapa11d()
    {
        for (String Pza :sPza11d)
        {
           cEtapa10 infoEtapa11d = new cEtapa10(0,mEtapa11dMenos5.get(Pza), mEtapa11dMas5.get(Pza), '', Pza);
           mInfoEtapa11d.put(Pza, infoEtapa11d);           
            
        }
        return mInfoEtapa11d;
    }
    
    public map<String,cEtapa12> getmInfoEtapa12()
    {
        for (String ownPza :sOwnPza12.keySet())
        {
           cEtapa12 infoEtapa12 = new cEtapa12(mEtapa12Nci.get(ownPza),mEtapa12InIn.get(ownPza), mEtapa13xDet.get(ownPza), mEtapa13PrePan.get(ownPza), mEtapa13Det.get(ownPza),sOwnPza12.get(ownPza).sNomSup, sOwnPza12.get(ownPza).sNomGer, ownPza.substring(36));
           mInfoEtapa12.put(ownPza, infoEtapa12);           
            
        }
        return mInfoEtapa12;
    }
    
    public map<Integer,cResumen> getmInfoRes()
    {
        for (Integer netpa :mEtapaName.KeySet())
        {
           cResumen infoResumen = new cResumen(mResEtEnt.get(netpa),mResEtSal.get(netpa), mResEtAcu.get(netpa), mEtapaName.get(netpa));
           mInfoRes.put(netpa, infoResumen);           
            
        }
        return mInfoRes;
    }
    
    //Clases
    
    public class cEtapa8 {
        public integer iPdteRegistro {get;set;}
        public integer iRegistradas {get;set;}
        public integer iAcumuladas {get;set;}
        public String sGerente {get;set;}
        public String sPlaza {get;set;}
        public cEtapa8(integer p, integer r, integer a, String sg, String sp)
        {
            this.sPlaza = sp;
            this.sGerente = sg;
            if (p == null)
            {
               this.iPdteRegistro = 0;
            }else
            {   
               this.iPdteRegistro = p;
            }
            if (r == null)
            {
                this.iRegistradas = 0;
            }else
            {
                this.iRegistradas = r;
            }
            if (a == null)
            {
                this.iAcumuladas = 0;
            }else
            {
                this.iAcumuladas = a;
            }
        }
    }
    
    public class cEtapa9 {
        public integer iStock {get;set;}
        public integer iIngresoEsc {get;set;}
        public integer iOfertaSem {get;set;}
        public String sGerente {get;set;}
        public String sPlaza {get;set;}
        public cEtapa9(integer s, integer i, integer o, String sg, String sp)
        {
            this.sPlaza = sp;
            this.sGerente = sg;
            if (s == null)
            {
               this.iStock = 0;
            }else
            {   
               this.iStock = s;
            }
            if (i == null)
            {
                this.iIngresoEsc = 0;
            }else
            {
                this.iIngresoEsc = i;
            }
            if (o == null)
            {
                this.iOfertaSem = 0;
            }else
            {
                this.iOfertaSem = o;
            }
        }
    }
    public class cEtapa10 {
        public integer iNoPagada {get;set;}
        public integer iMenos5 {get;set;}
        public integer iMas5 {get;set;}
        public integer iTotalGral {get;set;}
        public String sGerente {get;set;}
        public String sPlaza {get;set;}
        public cEtapa10(integer np, integer m5, integer p5, String sg, String sp)
        {
            this.sPlaza = sp;
            this.sGerente = sg;
            if (np == null)
            {
               this.iNoPagada = 0;
            }else
            {   
               this.iNoPagada = np;
            }
            if (m5 == null)
            {
                this.iMenos5 = 0;
            }else
            {
                this.iMenos5 = m5;
            }
            if (p5 == null)
            {
                this.iMas5 = 0;
            }else
            {
                this.iMas5 = p5;
            }
            this.iTotalGral = this.iNoPagada + this.iMenos5 + this.iMas5;
        }
    }
    public class cEtapa12 {
        public integer iNoCarta {get;set;}
        public integer iIngresoInf {get;set;}
        public integer ixDet {get;set;}
        public integer iPrePan {get;set;}
        public integer iDet {get;set;}
        
        public String sGestor {get; set;}
        public String sGerente {get;set;}
        public String sPlaza {get;set;}
        public cEtapa12(integer nc, integer ii, integer xd, integer ipp, integer id, String ss, String sg, String sp)
        {
            this.sPlaza = sp;
            this.sGerente = sg;
            this.sGestor = ss;
            if (nc == null)
            {
               this.iNoCarta = 0;
            }else
            {   
               this.iNoCarta = nc;
            }
            if (ii == null)
            {
                this.iIngresoInf = 0;
            }else
            {
                this.iIngresoInf = ii;
            }
            if (xd == null)
            {
                this.ixDet = 0;
            }else
            {
                this.ixDet = xd;
            }
            if (ipp == null)
            {
                this.iPrePan = 0;
            }else
            {
                this.iPrePan = ipp;
            }
            if (id == null)
            {
                this.iDet = 0;
            }else
            {
                this.iDet = id;
            }
            
        }
    }
    public class cResumen {
        public integer iEtapaEnt {get;set;}
        public integer iEtapaSal {get;set;}
        public integer iEtapaAcu {get;set;}
        public integer iEtapaDif {get;set;}
        public String sEtapa {get;set;}
        public cResumen(integer ee, integer es, integer ec, String se)
        {
            
            this.sEtapa = se;
            if (ee == null)
            {
               this.iEtapaEnt = 0;
            }else
            {   
               this.iEtapaEnt = ee;
            }
            if (es == null)
            {
                this.iEtapaSal = 0;
            }else
            {
                this.iEtapaSal = es;
            }
            if (ec == null)
            {
                this.iEtapaAcu = 0;
            }else
            {
                this.iEtapaAcu = ec;
            }
            this.iEtapaDif = this.iEtapaEnt - this.iEtapaSal;
            
        }
    }
    public class cSupGer {
        public String sNomSup {get;set;}
        public String sNomGer {get;set;}
        public cSupGer (String sn, String sg)
        {
            if(sn == null)
            {
                this.sNomSup = 'Sin Supervisor';
            }else
            {
                this.sNomSup = sn;
            }
            this.sNomGer = sg;
        }
    }
    public PageReference DetalleEtapa8a()
    {
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=8a');
    }
    public PageReference DetalleEtapa8b()
    {
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=8b');
    }
    public PageReference DetalleEtapa8c()
    {
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=8c');
    }
    public PageReference DetalleEtapa9()
    {
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=9');
    }
    public PageReference DetalleEtapa9a()
    {
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=9a');
    }
    public PageReference DetalleEtapa9b()
    {
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=9b');
    }
    public PageReference DetalleEtapa101()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=101');
    }
    public PageReference DetalleEtapa101a()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=101a');
    }
    public PageReference DetalleEtapa101b()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=101b');
    }
    public PageReference DetalleEtapa101c()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=101c');
    }
    public PageReference DetalleEtapa10a1()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=10a1');
    }
    public PageReference DetalleEtapa10a2()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=10a2');
    }
    public PageReference DetalleEtapa10b()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=10b');
    }
    public PageReference DetalleEtapa10b1()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=10b1');
    }
    public PageReference DetalleEtapa10b2()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=10b2');
    }
    public PageReference DetalleEtapa11a()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=11a');
    }
    public PageReference DetalleEtapa11a1()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=11a1');
    }
    public PageReference DetalleEtapa11a2()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=11a2');
    }
    public PageReference DetalleEtapa11b()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=11b');
    }
    public PageReference DetalleEtapa11b1()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=11b1');
    }
    public PageReference DetalleEtapa11b2()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=11b2');
    }
    public PageReference DetalleEtapa11c1()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=11c1');
    }
    public PageReference DetalleEtapa11c2()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=11c2');
    }
    public PageReference DetalleEtapa11d1()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=11d1');
    }
    public PageReference DetalleEtapa11d2()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=11d2');
    }
    public PageReference DetalleEtapa12a1()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=12a1');
    }
    public PageReference DetalleEtapa12a2()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=12a2');
    }
    public PageReference DetalleEtapa13a1()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=13a1');
    }
    public PageReference DetalleEtapa13a3()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=13a3');
    }
    public PageReference DetalleEtapa13a2()
    {
        
        return new PageReference('/apex/ReporteEjDet?retURL=%2F&sfdc.override=1&sop=13a2');
    }
    public PageReference DetalleContado()
    {
        
        return new PageReference('/apex/ReporteEjCont?retURL=%2F&sfdc.override=1&sop=14');
    }
}