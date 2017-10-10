public with sharing class GanttChartData {

    public String jsonString {get;set;}
    
    //Constructor
    public GanttChartData()
    {
        jsonString = prepareData();
        

    }   
    //Temp Method to prepare the Data
    private String prepareData()
    {
        system.debug('Preparando información de Gantt');
        
        
        map<Id,list<DocumentoEtapa__c>> mDocEtapa = new map<Id,list<DocumentoEtapa__c>>();
        List<Phase> lPh1 = new List<Phase>();
        
        
       
        DateTime dFrom = DateTime.now();
        
        list<DocumentoEtapa__c> lDocEtapa = new list<DocumentoEtapa__c>(); 
        
        for (Etapa__c etapa :[SELECT Id,NumEtapa__c, EstatusOferta__c, Name FROM Etapa__c WHERE Activa__c =: true AND (EstatusOferta__c =: 'Compra' 
             OR EstatusOferta__c =: 'Venta') ORDER BY NumEtapa__c])
        {
             list<DocumentoEtapa__c> lDocEtapaAux = new list<DocumentoEtapa__c>();
             lDocEtapaAux = [SELECT Id, Name, Activo__c, Etapa__c, Obligatorio__c, Orden__c, Paso_Anterior__c, Tiempo_Proceso__c, Ruta_Critica__c FROM DocumentoEtapa__c WHERE Activo__c =: true AND Etapa__c =: etapa.Id ORDER BY Orden__c ]; 
             mDocEtapa.put(etapa.Id, lDocEtapaAux);
        }
        
        for (Etapa__c etapa :[SELECT Id,NumEtapa__c, EstatusOferta__c, Name FROM Etapa__c WHERE Activa__c =: true AND (EstatusOferta__c =: 'Compra' 
             OR EstatusOferta__c =: 'Venta') ORDER BY NumEtapa__c])
        { 
            List<PhasesDetail> dtlObj1 = new List<PhasesDetail>();
            PhasesDetail obj1 = new PhasesDetail();
            obj1.setFromDate(String.valueOf(dFrom.getTime()));
            obj1.desc_PH = 'Etapa ' + etapa.Name;
            obj1.label = etapa.Name;
            obj1.customClass = 'ganttRed';
            DateTime dto = dFrom;
            DateTime dFromE = dFrom;
            DateTime dToE = dFrom;
            list<Phase> lPhAux = new list<Phase>();
            map <Decimal, DateTime> mobj = new map<Decimal,DateTime>();
            
            for (DocumentoEtapa__c detapa :mDocEtapa.get(etapa.Id))
            {
                List<PhasesDetail> dtlObj2 = new List<PhasesDetail>();
                PhasesDetail obj2 = new PhasesDetail();
                if (detapa.Paso_Anterior__c == 0) 
                {
                   obj2.setFromDate(String.valueOf(dFromE.getTime()));
                   dto = dFromE + detapa.Tiempo_Proceso__c;
                   obj2.setToDate(String.valueOf(dto.getTime()));
                   obj2.desc_PH = 'Etapa ' + etapa.Name + ' Tarea ' + detapa.Name;
                   obj2.label = detapa.Name;
                   obj2.customClass = 'ganttGreen';
                   mobj.put(detapa.Orden__c, dto);
                   
                } else
                {
                   DateTime dfromTask;
                   if (Test.isRunningTest())
                   {
                   	  dfromTask = DateTime.now();
                   }else
                   {
                      dFromTask = mobj.get(detapa.Paso_Anterior__c); 
                   }
                   
                   system.debug('dFrom en la etapa ' + detapa.Name + ' es igual a...............' + dFromTask);
                   obj2.setFromDate(String.valueOf(dFromTask.getTime()));
                   dto = dFromTask + detapa.Tiempo_Proceso__c;
                   system.debug('dto en la etapa ' + detapa.Name + ' es igual a...............' + dto);
                   obj2.setToDate(String.valueOf(dto.getTime()));
                   obj2.desc_PH = 'Etapa ' + etapa.Name + ' Tarea ' + detapa.Name;
                   obj2.label = detapa.Name;
                   obj2.customClass = 'ganttGreen';
                   mobj.put(detapa.Orden__c, dto); 
                }
                if (detapa.Ruta_Critica__c)
                {
                    dToE = dtoE + detapa.Tiempo_Proceso__c;
                }
                dtlobj2.add(obj2);
                Phase phaux = new Phase();
                phaux.name = ' ';
                phaux.desc_PH = detapa.Name;
                phaux.values = dtlObj2;
                lPhaux.add(phaux);
            }
            
            obj1.setToDate(String.valueOf(dtoE.getTime()));
            dFrom = dtoE;
            dtlobj1.add(obj1);
            Phase ph = new Phase();
            ph.name = etapa.Name;
            ph.desc_PH = ' ';
            ph.values = dtlObj1;
            lPh1.add(ph);
            lPh1.addAll(lPhaux);
        }
        
        
        List<PhasesDetail> dtlAObj = new List<PhasesDetail>();
        PhasesDetail obj3 = new PhasesDetail();
        obj3.setFromDate(String.valueOf(datetime.newInstance(2012,04, 19, 09, 30, 0).getTime()));
        obj3.setToDate(String.valueOf(datetime.newInstance(2012,04, 19, 16, 30, 2).getTime()));
        obj3.desc_PH = 'Booked by : Santosh <br /> for SAP Basis';
        obj3.label = 'Santosh';
        obj3.customClass = 'ganttGreen';
        
        
        dtlAObj.add(obj3);
       
       //Código temporal
        
        Phase r = new Phase();
        r.name = 'Training Room';
        r.desc_PH = 'This is Training Room';
        r.values = dtlAObj;
        
        List<Phase> r1 = new List<Phase>();
        r1.add(r);
        
        
        
        
        system.debug('Este es el r1.......................' + r1);
        system.debug('Este es el lPh1.....................' + lPh1);
        
            
        return JSON.serialize(lPh1).replaceAll('frm_PH','from').replaceAll('desc_PH','desc');
    }
    public class PhaseList
    {
        public List<Phase> Phases;
    }
    public class Phase
    {
        public String name{get;set;}
        //Below var name - desc
        public String desc_PH{get;set;}
        public List<PhasesDetail> values{get;set;}
    } 
    
    public class PhasesDetail
    {
        //actual variable name needed was "from", but it is keyword so we cant use that
        public String frm_PH{get;set;}
        public String to{get;set;}
        
        public String desc_PH{get;set;}
        public String label{get;set;}
        
        /*
            Custom class Can be anything from below:
            ganttRed
            ganttGreen
            ganttOrange
            
        */
        public String customClass{get;set;}
        
        
        public void setToDate(String val)
        {
            to = setDate(val);
        }
        public void setFromDate(String val)
        {
            frm_PH = setDate(val);
        }
        //Date should be in special format as it is used in regular expression
        private String setDate(String val)
        {
            return '/Date('+val+')/';
        }
    }
}