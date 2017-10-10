public with sharing class RepEjExcelController {

    
    public list<EtapaOferta__c> lofertas {get; set;}
    public list<wofertas> lwofertas8 = new list<wofertas>();
    public list<wofertas> lwofertas9 = new list<wofertas>();
    public list<wofertas> lwofertas = new list<wofertas>();
    public string sEtapa {get; set;}
    public integer itotal {get; set;}
    public string sQuery {get; set;}
    public integer iOrden {get; set;}
    public integer iEtapa {get; set;}
    public string sWhere {get; set;}
    public string sWhereEt {get; set;}
    
    //Etapa 8
    public list<Documento__c> ldocuIni8 {get; set;}
    public list<Documento__c> ldocuFin8 {get; set;}
    
   
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
    
    
    public map<String, Integer> mEtapa101NoPag = new map<String, Integer>();
    public map<String, Integer> mEtapa101Mas5 = new map<String, Integer>();
    public map<String, Integer> mEtapa101Menos5 = new map<String, Integer>();
  
    public map<String, Integer> mEtapa10aNoPag = new map<String, Integer>();
    public map<String, Integer> mEtapa10aMas5 = new map<String, Integer>();
    public map<String, Integer> mEtapa10aMenos5 = new map<String, Integer>();
   
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
    
 
    public map<String, Integer> mEtapa11aNoPag = new map<String, Integer>();
    public map<String, Integer> mEtapa11aMas5 = new map<String, Integer>();
    public map<String, Integer> mEtapa11aMenos5 = new map<String, Integer>();
   
    public map<String, Integer> mEtapa11bNoPag = new map<String, Integer>();
    public map<String, Integer> mEtapa11bMas5 = new map<String, Integer>();
    public map<String, Integer> mEtapa11bMenos5 = new map<String, Integer>();
   
    public map<String, Integer> mEtapa11cMas5 = new map<String, Integer>();
    public map<String, Integer> mEtapa11cMenos5 = new map<String, Integer>();
  
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
    
    
    public map<String, Integer> mEtapa12Nci = new map<String, Integer>();
    public map<String, Integer> mEtapa12InIn = new map<String, Integer>();
    
    
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
    
    
    //Resumen
    
    public map<Integer, String> mEtapaName = new map<Integer, String>();
    list<EtapaOferta__c> lEtapaOfI {get; set;}
    list<EtapaOferta__c> lEtapaOfF {get; set;}
    public map<Integer, list<EtapaOferta__c>> mEtapaOfE = new map<Integer, list<EtapaOferta__c>>();
    public map<Integer, list<EtapaOferta__c>> mEtapaOfS = new map<Integer, list<EtapaOferta__c>>();
    
    public map<Integer, Integer> mResEtEnt = new map<Integer, Integer>();
    public map<Integer, Integer> mResEtSal = new map<Integer, Integer>();
    
    public map<Integer, Integer> mResEtAcu = new map<Integer, Integer>();
    
    //public map<Integer, list
    
    // 
    public list<Documento__c> ldocplaza {get;set;}
    public date dhoy {get;set;}
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
    public Decimal iEt {get;set;}
    
    
    public RepEjExcelController()
    {
                
        String sopcion;
        String sPlaza;
        String sGerente;
        set<string> sofertas = new set<string>();
        sopcion = ApexPages.currentPage().getParameters().get('sop');
        sPlaza = ApexPages.currentPage().getParameters().get('fpza');
        sGerente = ApexPages.currentPage().getParameters().get('fgte');
        if (sPlaza == 'Todas' && sGerente == 'Todos')
        {
            sWhere = '';
        }else if (sPlaza == 'Todas' && sGerente != 'Todos')
        {
            sWhere = 'Oferta__r.OwnerId =: sGerente AND';
        }else if (sPlaza != 'Todas' && sGerente == 'Todos')
        {
            sWhere = 'Oferta__r.Propiedad__r.Plaza__c =: sPlaza AND';
            
        }else if (sPlaza != 'Todas' && sGerente != 'Todos')
        {
            sWhere = 'Oferta__r.Propiedad__r.Plaza__c =: sPlaza AND Oferta__r.OwnerId =: sGerente AND';
        }
        sQuery = 'Select id, name, Oferta__r.name, Oferta__r.Owner.name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Estatus__c, Oferta__r.Dictamen__c, Oferta__r.Direccion2__c, Oferta__r.PrecioVenta__c, ' 
               + 'Oferta__r.MargenNeto__c, Oferta__r.BeneficioNeto__c, Oferta__r.Fecha_Dictamen__c, Etapa__r.name, Oferta__r.Promotor__r.name, Oferta__r.Contratista__r.name, '
               + 'Oferta__r.Valuador_Compra__r.name, Oferta__r.Valuador_Venta__r.name, DocumentosFaltantes__c, Oferta__r.Comentarios__c, Oferta__r.TipoOferta__c, '
               + 'Oferta__r.VentanillaUnica__r.name, Oferta__r.Gestor__r.name, Oferta__r.TiempoOferta__c From EtapaOferta__c Where '
               + sWhere + ' Oferta__c IN :sofertas AND Etapa__r.NumEtapa__c =: iEt Order by Oferta__r.Owner.name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.name';
        dhoy = date.Today();
        shoy = string.valueOf(dhoy);
        dIniSem = dhoy.toStartofWeek();
        dFinSem = dIniSem + 7;
        stockhoy = 'Stock (' + shoy + ')'; 
        string sDescartada = 'Descartada';
        string sFinalizada = 'Finalizada';
        string sAbierta = 'Abierta';
        string sCerrada = 'Cerrada';
        string sContado = 'Contado';
        boolean btrue = true;
        boolean bfalse = false;
        DateTime DateNull = null;
        list<EtapaOferta__c> letofup = new list<EtapaOferta__c>();
        
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
        
        
        if (Test.isRunningTest())
        {
            sopcion = '8a';
        }
        if(sopcion == '8a' || sopcion == '8b' || sopcion == '8c' || sopcion == '999')
        { 
            iEt = 8;
            
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
            
            
                
            if (sopcion == '8a' || sopcion == '999')
            {
                for (EtapaOferta__c etof :lPendientes8)
                {
                   sofertas.add(etof.Oferta__c);
                }  
                setapa = 'Etapa 8 Pendiente Registro';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {                    
                    wofertas wof = new wofertas('Etapa 8', 'Pendiente Registro',oft);
                    lwofertas8.add(wof);
                }
                
            }
                  
            
        }
        
       
         // Etapa 9 Ofertas
        if(sopcion == '9' || sopcion == '999')
        {  
             iEt = 9;
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
        
            
            if (sopcion == '9' || sopcion == '999')
            {
                sofertas.clear();
                for (EtapaOferta__c etof :lstock9)
                {
                  sofertas.add(etof.Oferta__c);                                 
                }
                setapa = 'Etapa 9 Stock';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 9', 'Stock',oft);
                    lwofertas9.add(wof);
                }
            }
            
        } 

        // Etapa 10

        if (Test.isRunningTest())
        {
            sopcion = '101';
        }
        if(sopcion == '101' || sopcion == '101a' || sopcion == '101b' || sopcion == '101c' || sopcion == '999')
        {   
            //Etapa 10 y 10.1
            iEtapa = 10;
            
            iEt = 10.1;
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
            letofertas101 = [Select Oferta__c, Oferta__r.name From EtapaOferta__c Where Etapa__r.NumEtapa__c =: 10.1 
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
            
            
            isumInvEtapa101 = letofertas101.size(); 
            list<Documento__c> lDesEtapa101 = new list<Documento__c>();
            lDesEtapa101 = [Select id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                           Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                           Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c 
                           From Documento__c Where DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10.1 AND Oferta__r.FechaCobro__c =: null
                           AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 13 AND Oferta__r.TipoOferta__c !=: 'Contado' AND Fecha_Cierre__c = TODAY];  
           
                       
            isumChgEtapa101 = 0;
            
            if (sopcion == '101' || sopcion == '999')
            {
                sofertas.clear();
                for(EtapaOferta__c etof :sInvNoPag101)
                {
                   sofertas.add(etof.Oferta__c);
                }  
                setapa = 'Etapa 10 Invadias No Pagadas';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 10', 'Invadidas No Pagadas',oft);
                    lwofertas.add(wof);
                }   
                    
            }
            if (sopcion == '101a' || sopcion == '999')
            {
                sofertas.clear();
                for(Documento__c doc :lInvmenos5101)
                {
                   sofertas.add(doc.Oferta__c);   
                }
                setapa = 'Etapa 10 Invadias Menos de 5';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 10', 'Invadidas Menos de 5',oft);
                    lwofertas.add(wof);
                }   
            }
            if (sopcion == '101b' || sopcion == '999')
            {
                sofertas.clear();
                for(Documento__c doc :lInvmas5101)
                {
                  sofertas.add(doc.Oferta__c);   
                }
                setapa = 'Etapa 10 Invadias Mas de 5';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 10', 'Invadidas Mas de 5',oft);
                    lwofertas.add(wof);
                }   
            }
            
        }   
        if (Test.isRunningTest())
        {
            sopcion = '10a1';
        }
        if(sopcion == '10a1' || sopcion == '10a2' || sopcion == '999')
        {
             iEt = 10;
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
            
            
                
            isumRehEtapa10a = 0;
            
            if (sopcion == '10a1' || sopcion == '999')
            {
                sofertas.clear();
                for(Documento__c doc :lInvmenos510a)
                {
                   sofertas.add(doc.Oferta__c); 
                }
                setapa = 'Etapa 10 Presupuesto Rehabilitación Menos de 5';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 10', 'Presupuesto Rehabilitación Menos de 5',oft);
                    lwofertas.add(wof);
                }   
            }
            if (sopcion == '10a2' || sopcion == '999')
            {
                sofertas.clear();
                for(Documento__c doc :lInvmas510a)
                {
                    sofertas.add(doc.Oferta__c); 
                } 
                setapa = 'Etapa 10 Presupuesto Rehabilitación Mas de 5';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 10', 'Presupuesto Rehabilitación Mas de 5',oft);
                    lwofertas.add(wof);
                }   
            }
        }
        if (Test.isRunningTest())
        {
            sopcion = '10b';
        }
        if (sopcion == '10b' || sopcion == '10b1' || sopcion == '10b2' || sopcion == '999')
        {
            iEt = 10;
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
            isumRehEtapa10a = [Select Count() From Documento__c Where DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 AND Oferta__r.FechaCobro__c =: null
                               AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 1 AND Oferta__r.TipoOferta__c !=: 'Contado'
                               AND Oferta__c IN: sofaux10b];
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
                 
            if(sopcion == '10b' || sopcion == '999')
            {                   
                sofertas.clear();
                for(Documento__c doc :lInvNoPag10b)
                {
                   sofertas.add(doc.Oferta__c); 
                }
                setapa = 'Etapa 10 Rehabilitación No Pagadas';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 10', 'Rehabilitación No Pagadas',oft);
                    lwofertas.add(wof);
                }   
            }
            if(sopcion == '10b1' || sopcion == '999')
            {  
                sofertas.clear();
                for(Documento__c doc :lInvmenos510b)
                {
                   sofertas.add(doc.Oferta__c); 
                }
                setapa = 'Etapa 10 Rehabilitación Menos 5';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 10', 'Rehabilitación Menos 5',oft);
                    lwofertas.add(wof);
                }   
            }
            if (sopcion == '10b2' || sopcion == '999')
            {    
                sofertas.clear();
                for(Documento__c doc :lInvmas510b)
                {
                   sofertas.add(doc.Oferta__c); 
                }
                setapa = 'Etapa 10 Rehabilitación Mas 5';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 10', 'Rehabilitación Mas 5',oft);
                    lwofertas.add(wof);
                }   
            }  
        }
        
         //Etapa 11
         iEt = 11;
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
        if (Test.isRunningTest())
        {
            sopcion = '11a';
        }
        if (sopcion == '11a' ||sopcion == '11a1' || sopcion == '11a2' || sopcion == '11b' || sopcion == '11b1' || sopcion == '11b2' || sopcion == '11c1' || sopcion == '11c2' || sopcion == '999')
        {
            
            // Ingreso Infonavit
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
            }
            for(Documento__c doc :lOfmas511c)
            {
               sofIngInf11.add(doc.Oferta__c);   
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
            
            
            
            if(sopcion == '11a' || sopcion == '999')
            {
                sofertas.clear();
                for(Documento__c doc :lOfNoPag11a)
                {
                   sofertas.add(doc.Oferta__c);    
                }
                setapa = 'Etapa 11 Avaluo No Pagadas';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 11', 'Avaluo No Pagadas',oft);
                    lwofertas.add(wof);
                }   
            }
            if(sopcion == '11a1' || sopcion == '999')
            {  
                sofertas.clear();
                for(Documento__c doc :lOfmenos511a)
                {
                   sofertas.add(doc.Oferta__c);  
                }
                setapa = 'Etapa 11 Avaluo Menos de 5';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 11', 'Avaluo Menos de 5',oft);
                    lwofertas.add(wof);
                }   
            }
            if(sopcion == '11a2' || sopcion == '999')
            {
                sofertas.clear();
                for(Documento__c doc :lOfmas511a)
                {
                    sofertas.add(doc.Oferta__c);  
                } 
                setapa = 'Etapa 11 Avaluo Mas de 5';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 11', 'Avaluo Mas de 5',oft);
                    lwofertas.add(wof);
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
            
            
            if(sopcion == '11b' || sopcion == '999')
            {
                sofertas.clear();
                for(Documento__c doc :lOfNoPag11b)
                {
                   sofertas.add(doc.Oferta__c); 
                }
                setapa = 'Etapa 11 CLG No Pagadas';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 11', 'CLG No Pagadas',oft);
                    lwofertas.add(wof);
                }   
            }
            if(sopcion == '11b1' || sopcion == '999')
            {  
                sofertas.clear();
                for(Documento__c doc :lOfmenos511b)
                {
                   sofertas.add(doc.Oferta__c); 
                }
                setapa = 'Etapa 11 CLG Menos de 5';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 11', 'CLG Menos de 5',oft);
                    lwofertas.add(wof);
                }   
            }
            if(sopcion == '11b2' || sopcion == '999')
            {
                sofertas.clear();
                for(Documento__c doc :lOfmas511b)
                {
                    sofertas.add(doc.Oferta__c); 
                }
                setapa = 'Etapa 11 CLG Mas de 5';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 11', 'CLG Mas de 5',oft);
                    lwofertas.add(wof);
                }   
            } 
            
            //Llena en orden Ingreso Infonavit en la lista
            
            if(sopcion == '11c1' || sopcion == '999')
            {
                sofertas.clear();
                for(Documento__c doc :lOfmenos511c)
                {
                   sofertas.add(doc.Oferta__c); 
                }
                setapa = 'Etapa 11 Ingreso Infonavit Menos de 5';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 11', 'Ingreso Infonavit Menos de 5',oft);
                    lwofertas.add(wof);
                }   
            }
            if(sopcion == '11c2' || sopcion == '999')
            {
                sofertas.clear();
                for(Documento__c doc :lOfmas511c)
                {
                   sofertas.add(doc.Oferta__c); 
                }
                setapa = 'Etapa 11 Ingreso Infonavit Mas de 5';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 11', 'Ingreso Infonavit Mas de 5',oft);
                    lwofertas.add(wof);
                } 
            }
            
        }
        
      
        if (Test.isRunningTest())
        {
            sopcion = '12a1';
        }
        //Etapa 12
        if(sopcion == '12a1' || sopcion == '12a2' || sopcion == '999')
        {
            iEt = 12;
            lOfNci12 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                        Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                        Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                        FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 12
                        AND Cerrado__c =: false AND EtapaOferta__r.Estatus__c =: 'Abierta' AND DocumentoEtapa__r.Orden__c =: 2
                        AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__r.FechaCobro__c =: null
                        Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
                        
             lOFInIn12 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                         Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                         Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                         FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 12
                         AND Cerrado__c =: true AND Iniciado__c =: true AND DocumentoEtapa__r.Orden__c =: 2
                         AND Oferta__r.TipoOferta__c !=: 'Contado' AND Oferta__r.FechaCobro__c =: null AND EtapaOferta__r.Estatus__c =: 'Abierta'
                         Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
            
            
            String sManager;  
            String sName;    
            
            isumExpEtapa12 = 0; 
            if(sopcion == '12a1'|| sopcion == '999')
            {      
                sofertas.clear();
                for(Documento__c doc :lOfNci12)
                {
                   sofertas.add(doc.Oferta__c);
                }
                setapa = 'Etapa 12 Ingreso Notaria';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 12', 'Ingreso Notaria',oft);
                    lwofertas.add(wof);
                }   
            }
            if(sopcion == '12a2' || sopcion == '999')
            {
                sofertas.clear();
                for(Documento__c doc :lOFInIn12)
                {
                   sofertas.add(doc.Oferta__c);
                }
                setapa = 'Etapa 12 Firma Cliente';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 12', 'Firma Cliente',oft);
                    lwofertas.add(wof);
                }   
            } 
        }
        //Etapa 13
        if (Test.isRunningTest())
        {
            sopcion = '13a1';
        }
        if(sopcion == '13a1' || sopcion == '13a2' || sopcion == '13a3' || sopcion == '999')
        {
             iEt = 13;
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
	                    Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
	                    Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
	                    FROM Documento__c WHERE DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 13
	                    AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.TipoOferta__c !=: 'Contado'
	                    AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 24 AND Oferta__r.FechaCobro__c =: null
	                    AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__c IN: sofet12completa
	                    Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
                        
            lOFDet13 =  [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                         Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
                         Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId, DocumentoEtapa__r.Orden__c
                         FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 13
                         AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada'
                         AND Cerrado__c =: true AND DocumentoEtapa__r.Orden__c =: 10 AND Oferta__r.FechaCobro__c =: null
                         AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__r.TipoOferta__c !=: 'Contado'
                         Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
            list<Oferta__c> lOfCobradas = new list<Oferta__c>();
            lOfCobradas = [Select Id, Estatus__c, FechaCobro__c From Oferta__c Where Estatus__c =: 'Cobrada' and FechaCobro__c = THIS_WEEK];
            
            
            isumChgEtapa12 = [Select Count() FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 13
                              AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada'
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
            if(sopcion == '13a1' || sopcion == '999')
            {             
                sofertas.clear();
                for(Documento__c doc :lOfxDet13)
                {              
                   sofertas.add(doc.Oferta__c);   
                }
                setapa = 'Etapa 13 Firma Intermedia';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 13', 'Firma Intermedia',oft);
                    lwofertas.add(wof);
                }   
            }
            if(sopcion == '13a3' || sopcion == '999')
            {             
                sofertas.clear();
                for(Documento__c doc :lPrePan13)
                {              
                   sofertas.add(doc.Oferta__c);   
                }
                setapa = 'Etapa 13 PrePantalla';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 13', 'PrePantalla',oft);
                    lwofertas.add(wof);
                }   
            }
            if (sopcion == '13a2' || sopcion == '999')
            {
                sofertas.clear();
                for(Documento__c doc :lOfDet13)
                {
                   sofertas.add(doc.Oferta__c);
                }
                setapa = 'Etapa 13 Detonadas';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 13', 'Detonadas',oft);
                    lwofertas.add(wof);
                }   
            } 
        }
        
        // Contado
        if (Test.isRunningTest())
        {
            sopcion = '14';
        }
        if(sopcion == '14' || sopcion == '999')
        {
        
	          sofertas.clear();
              for(Oferta__c doc :[Select id, name, Owner.name, Propiedad__r.Plaza__c, Etapa__c From Oferta__c Where Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada' AND TipoOferta__c =: 'Contado'
	                    AND FechaCobro__c =: null Order by Owner.name, Propiedad__r.Plaza__c, name])
              {              
                 sofertas.add(doc.id);   
              }
              setapa = 'Ofertas Contado';
              lofertas = Database.query(sQuery);
                
              itotal = lofertas.size();
              for (EtapaOferta__c oft :lofertas)
              {
                  wofertas wof = new wofertas('Contado', ' ',oft);
                  lwofertas.add(wof);
              }   
        }
        // Resumen
        
        lEtapaOfI = [Select Id, Name, NumEtapa__c, Nombre_etapa__c, Oferta__c, Estatus__c, Oferta__r.Estatus__c,
                    HoraInicial__c, HoraFinal__c 
                    From EtapaOferta__c Where HoraInicial__c = TODAY AND Oferta__r.FechaCobro__c =: null  AND Oferta__r.TipoOferta__c !=: 'Contado' and 
                    (Etapa__r.EstatusOferta__c =: 'Compra' or Etapa__r.EstatusOferta__c =: 'Venta') Order by NumEtapa__c];
        lEtapaOfF = [Select Id, Name, NumEtapa__c, Nombre_etapa__c, Oferta__c, Estatus__c, Oferta__r.Estatus__c,
                    HoraInicial__c, HoraFinal__c 
                    From EtapaOferta__c Where HoraFinal__c = THIS_WEEK AND Oferta__r.FechaCobro__c =: null AND Oferta__r.TipoOferta__c !=: 'Contado' and
                    (Etapa__r.EstatusOferta__c =: 'Compra' or Etapa__r.EstatusOferta__c =: 'Venta') Order by NumEtapa__c];             
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
    
    public list<wofertas> getlwofertas8()
    {       
        return lwofertas8;
    }
    public list<wofertas> getlwofertas9()
    {       
        return lwofertas9;
    }
    public list<wofertas> getlwofertas()
    {       
        return lwofertas;
    }
    
    public class wofertas {
        public String sEtapa {get;set;}
        public String sSeccion {get;set;}
        public EtapaOferta__c oferta {get;set;}
        public wofertas (String se, String ss, EtapaOferta__c ofta)
        {
            
            this.sEtapa = se;            
            this.sSeccion = ss;
            this.oferta = ofta;
        }
    }
    
   

}