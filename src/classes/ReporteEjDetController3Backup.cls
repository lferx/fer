public with sharing class ReporteEjDetController3Backup {

    public String Lead { get; set; }
    
    public list<EtapaOferta__c> lofertas {get; set;}
    public list<wofertas> lwofertas6 = new list<wofertas>();
    public list<wofertas> lwofertas7 = new list<wofertas>();
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
    
    //Etapa 6
    
    public list<Documento__c> ldocuIni6 {get; set;}
    public list<Documento__c> ldocuFin6 {get; set;}
    
   
    public map<String, Integer> mEtapa6Ptes = new map<String, Integer>();
    public map<String, Integer> mEtapa6Reg = new map<String, Integer>();
    public map<String, Integer> mEtapa6Acum = new map<String, Integer>();
    public map<String, String > sOwnPza6 = new map<String, String>();
    
    public integer isumComEtapa6 {get; set;}
    public integer isumRegEtapa6 {get; set;}
    public integer isumPteEtapa6 {get; set;}
    
    
    //Etapa 7
    
    public list<Documento__c> ldocuIni7 {get; set;}
    public list<Documento__c> ldocuFin7 {get; set;}
    
    public list<EtapaOferta__c> lstock7 {get; set;}
    public map<String, Integer> mEtapa7Ptes = new map<String, Integer>();
    public map<String, Integer> mEtapa7Reg = new map<String, Integer>();
    public map<String, Integer> mEtapa7Acum = new map<String, Integer>();
    public map<String, String > sOwnPza7 = new map<String, String>();
    
    public integer isumComEtapa7 {get; set;}
    public integer isumRegEtapa7 {get; set;}
    public integer isumPteEtapa7 {get; set;}
    
    //Etapa 8
    public list<Documento__c> ldocuIni8 {get; set;}
    public list<Documento__c> ldocuFin8 {get; set;}
    
    public list<EtapaOferta__c> lstock8 {get; set;}
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
    
    
    public ReporteEjDetController3Backup()
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
        
        
        // Etapa 6 Compilación expediente compra
        
        if (Test.isRunningTest())
        {
            sopcion = '6a';
        }
        if(sopcion == '6a' || sopcion == '6b' || sopcion == '6c' || sopcion == '999')
        { 
            iEt = 6;
            
            list<EtapaOferta__c> lstock6open = new list<EtapaOferta__c>();
            lstock6open = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Oferta__r.OwnerId 
                                 FROM EtapaOferta__c WHERE NumEtapa__c =: 6 AND Estatus__c =: 'Abierta' AND Oferta__r.FechaCobro__c =: null
                                 AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                                 Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c]; 
            set<string> sofertaE6open = new set<string>();
            for (EtapaOferta__c etof :lstock6open)
            {
                sofertaE6open.add(etof.Oferta__c);
            }
            
            ldocuIni6 = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c,  
                         Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, DocumentoEtapa__r.Name,   
                         Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
                         FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 6 AND Oferta__r.FechaCobro__c =: null
                         AND Cerrado__c =: true AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND DocumentoEtapa__r.Orden__c = : 5
                         AND Oferta__c IN: sofertaE6open
                         Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
                         
            set<string> sofertaE6Reg = new set<string>();
            for (Documento__c doc :ldocuIni6)
            {
                sofertaE6Reg.add(doc.Oferta__c);
            }
            list<EtapaOferta__c> lPendientes6 = new list<EtapaOferta__c>();
            lPendientes6 = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Oferta__r.OwnerId 
                            FROM EtapaOferta__c WHERE NumEtapa__c =: 6 AND Estatus__c =: 'Abierta' AND Oferta__r.FechaCobro__c =: null
                            AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__c NOT IN: sofertaE6Reg 
                            Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c]; 
            
            
                
            if (sopcion == '6a' || sopcion == '999')
            {
                for (EtapaOferta__c etof :lPendientes6)
                {
                   sofertas.add(etof.Oferta__c);
                }  
                setapa = 'Etapa 6 Pendiente Registro';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {                    
                    wofertas wof = new wofertas('Etapa 6', 'Pendiente Registro',oft);
                    lwofertas6.add(wof);
                }
                
            }
                  
            
        }
        
        // Etapa 7 Compra final
        
        if(sopcion == '7' || sopcion == '999')
        {  
             iEt = 7;
            list<EtapaOferta__c> lstock6 = new list<EtapaOferta__c>();
            lstock6 = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Oferta__r.OwnerId 
                                 FROM EtapaOferta__c WHERE NumEtapa__c =: 6 AND Estatus__c =: 'Cerrada' AND Oferta__r.FechaCobro__c =: null
                                 AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                                 Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c]; 
            set<string> sofertaE6a = new set<string>();
            for (EtapaOferta__c etof :lstock6)
            {
                sofertaE6a.add(etof.Oferta__c);
            }
            
            lstock7 = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Oferta__r.OwnerId 
                         FROM EtapaOferta__c WHERE NumEtapa__c =: 7 AND Estatus__c =: 'Abierta' AND Oferta__r.FechaCobro__c =: null
                         AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                         AND Oferta__c IN: sofertaE6a
                         Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c]; 
        
            
            if (sopcion == '7' || sopcion == '999')
            {
                sofertas.clear();
                for (EtapaOferta__c etof :lstock7)
                {
                  sofertas.add(etof.Oferta__c);                                 
                }
                setapa = 'Etapa 7 Stock';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 7', 'Stock',oft);
                    lwofertas7.add(wof);
                }
            }
            
        } 
     
        // Etapa 8 Escrituras Registradas
        
        
         if(sopcion == '8' || sopcion == '999')
        {  
             iEt = 8;
            list<EtapaOferta__c> lstock7 = new list<EtapaOferta__c>();
            lstock7 = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Oferta__r.OwnerId 
                                 FROM EtapaOferta__c WHERE NumEtapa__c =: 7 AND Estatus__c =: 'Cerrada' AND Oferta__r.FechaCobro__c =: null
                                 AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                                 Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c]; 
            set<string> sofertaE7a = new set<string>();
            for (EtapaOferta__c etof :lstock7)
            {
                sofertaE7a.add(etof.Oferta__c);
            }
            
            lstock8 = [SELECT id, Oferta__c, Name, Oferta__r.Owner.Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Oferta__r.OwnerId 
                         FROM EtapaOferta__c WHERE NumEtapa__c =: 8 AND Estatus__c =: 'Abierta' AND Oferta__r.FechaCobro__c =: null
                         AND Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' 
                         AND Oferta__c IN: sofertaE7a
                         Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c]; 
        
            
            if (sopcion == '8' || sopcion == '999')
            {
                sofertas.clear();
                for (EtapaOferta__c etof :lstock8)
                {
                  sofertas.add(etof.Oferta__c);                                 
                }
                setapa = 'Etapa 8 Stock';
                lofertas = Database.query(sQuery);
                
                itotal = lofertas.size();
                for (EtapaOferta__c oft :lofertas)
                {
                    
                    wofertas wof = new wofertas('Etapa 8', 'Stock',oft);
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
    
    public list<wofertas> getlwofertas6()
    {       
        return lwofertas6;
    }
    public list<wofertas> getlwofertas7()
    {       
        return lwofertas7;
    }
    
    public list<wofertas> getlwofertas8()
    {       
        return lwofertas8;
    }
    public list<wofertas> getlwofertas9()
    {       
        return lwofertas9;
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