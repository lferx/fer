global with sharing class PropiedadesController2 {
    public List<Attachment> fotos {get;set;}
    
    public Map<String,String> mapaFotos1 {get;set;}
    public Map<String,String> mapaFotos2 {get;set;}
    public Map<String,String> mapaFotos3 {get;set;}
    public Map<String,String> mapaFotos4 {get;set;}
    public Map<String,String> mapaFotos5 {get;set;}
    public Map<String,String> mapaFotos6 {get;set;}
    public Map<String,String> mapaFotos7 {get;set;}
    public Map<String,String> mapaFotos8 {get;set;}
    public Map<String,String> mapaFotos9 {get;set;}
    public Map<String,String> mapaFotos10 {get;set;}
    public Map<String,String> mapaFotos11 {get;set;}
    public Map<String,String> mapaFotos12 {get;set;}
    public Map<String,String> mapaFotos13 {get;set;}
    public Map<String,String> mapaFotos14 {get;set;}
    public Map<String,String> mapaFotos15 {get;set;}
    public Map<String,String> mapaFotos16 {get;set;}
    public Map<String,String> mapaFotos17 {get;set;}
    public Map<String,String> mapaFotos18 {get;set;}
    public Map<String,String> mapaFotos19 {get;set;}
    public Map<String,String> mapaFotos20 {get;set;}
    public Map<String,String> mapaFotos21 {get;set;}
    public Map<String,String> mapaFotos22 {get;set;}
    public Map<String,String> mapaFotos23 {get;set;}
    public Map<String,String> mapaFotos24 {get;set;}
    public Map<String,String> mapaFotos25 {get;set;}
    public Map<String,String> mapaFotos26 {get;set;}
    public Map<String,String> mapaFotos27 {get;set;}
    public Map<String,String> mapaFotos28 {get;set;}
    public Map<String,String> mapaFotos29 {get;set;}
    public Map<String,String> mapaFotos30 {get;set;}
    public Map<String,String> mapaFotos31 {get;set;}
    public Map<String,String> mapaFotos32 {get;set;}
    public Map<String,String> mapaFotos33 {get;set;}
    public Map<String,String> mapaFotos34 {get;set;}
    
  
     
   
    
     public Integer countProp{
        get{
            return [select count() from Propiedad__c WHERE Name<>'' and (Geolocalizada__c='' or Geolocalizada__c='No')];
        }
        set;
    }
    
    public Integer countProp2{
        get{
            return [select count() from Propiedad__c WHERE Name<>''];
        }
        set;
    }
    
    public Integer countPropAll{
        get{
            
            return [select count() from Propiedad__c];
        }
        set;
    }
    
      public List<Propiedad__c> propiedades1
    {
        get
        {
            List<Propiedad__c> propiedades1 = new List<Propiedad__c>();
            try {
                propiedades1 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Torreon' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades1) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos1 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos1.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos1.containsKey(id)) {
                        mapaFotos1.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos1);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades1;
        }
        set;
   }
    public List<Propiedad__c> propiedades2
    {
        get
        {
            List<Propiedad__c> propiedades2 = new List<Propiedad__c>();
            try {
                propiedades2 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Aguascalientes' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades2) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos2 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos2.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos2.containsKey(id)) {
                        mapaFotos2.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos2);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades2;
        }
        set;
   }
   
     public List<Propiedad__c> propiedades3
    {
        get
        {
            List<Propiedad__c> propiedades3 = new List<Propiedad__c>();
            try {
                propiedades3 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Celaya' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades3) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos3 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos3.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos3.containsKey(id)) {
                        mapaFotos3.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos3);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades3;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades4
    {
        get
        {
            List<Propiedad__c> propiedades4 = new List<Propiedad__c>();
            try {
                propiedades4 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Colima' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades4) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos4 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos4.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos4.containsKey(id)) {
                        mapaFotos4.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos4);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades4;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades5
    {
        get
        {
            List<Propiedad__c> propiedades5 = new List<Propiedad__c>();
            try {
                propiedades5 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Durango' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades5) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos5 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos5.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos5.containsKey(id)) {
                        mapaFotos5.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos5);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades5;
        }
        set;
   }
   
    public List<Propiedad__c> propiedades6
    {
        get
        {
            List<Propiedad__c> propiedades6 = new List<Propiedad__c>();
            try {
                propiedades6 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Monterrey' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades6) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos6 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos6.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos6.containsKey(id)) {
                        mapaFotos6.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos6);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades6;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades7
    {
        get
        {
            List<Propiedad__c> propiedades7 = new List<Propiedad__c>();
            try {
                propiedades7 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Queretaro' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades7) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos7 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos7.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos7.containsKey(id)) {
                        mapaFotos7.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos7);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades7;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades8
    {
        get
        {
            List<Propiedad__c> propiedades8 = new List<Propiedad__c>();
            try {
                propiedades8 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'San Luis Potosi' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades8) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos8 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos8.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos8.containsKey(id)) {
                        mapaFotos8.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos8);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades8;
        }
        set;
   }
   
    public List<Propiedad__c> propiedades9
    {
        get
        {
            List<Propiedad__c> propiedades9 = new List<Propiedad__c>();
            try {
                propiedades9 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Hermosillo' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades9) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos9 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos9.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos9.containsKey(id)) {
                        mapaFotos9.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos9);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades9;
        }
        set;
   }
   
    public List<Propiedad__c> propiedades10
    {
        get
        {
            List<Propiedad__c> propiedades10 = new List<Propiedad__c>();
            try {
                propiedades10 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Nuevo Laredo' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades10) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos10 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos10.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos10.containsKey(id)) {
                        mapaFotos10.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos10);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades10;
        }
        set;
   }
   
    public List<Propiedad__c> propiedades11
    {
        get
        {
            List<Propiedad__c> propiedades11 = new List<Propiedad__c>();
            try {
                propiedades11 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Reynosa' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades11) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos11 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos11.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos11.containsKey(id)) {
                        mapaFotos11.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos11);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades11;
        }
        set;
   }
    public List<Propiedad__c> propiedades12
    {
        get
        {
            List<Propiedad__c> propiedades12 = new List<Propiedad__c>();
            try {
                propiedades12 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Distrito Federal' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades12) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos12 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos12.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos12.containsKey(id)) {
                        mapaFotos12.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos12);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades12;
        }
        set;
   }
   
     public List<Propiedad__c> propiedades13
    {
        get
        {
            List<Propiedad__c> propiedades13 = new List<Propiedad__c>();
            try {
                propiedades13 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Estado de Mexico' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades13) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos13 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos13.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos13.containsKey(id)) {
                        mapaFotos13.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos13);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades13;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades14
    {
        get
        {
            List<Propiedad__c> propiedades14 = new List<Propiedad__c>();
            try {
                propiedades14 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Guadalajara' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades14) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos14 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos14.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos14.containsKey(id)) {
                        mapaFotos14.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos14);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades14;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades15
    {
        get
        {
            List<Propiedad__c> propiedades15 = new List<Propiedad__c>();
            try {
                propiedades15 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Tlajomulco' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades15) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos15 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos15.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos15.containsKey(id)) {
                        mapaFotos15.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos15);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades15;
        }
        set;
   }
   
    public List<Propiedad__c> propiedades16
    {
        get
        {
            List<Propiedad__c> propiedades16 = new List<Propiedad__c>();
            try {
                propiedades16 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Tonala' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades16) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos16 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos16.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos16.containsKey(id)) {
                        mapaFotos16.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos16);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades16;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades17
    {
        get
        {
            List<Propiedad__c> propiedades17 = new List<Propiedad__c>();
            try {
                propiedades17 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Tabasco' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades17) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos17 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos17.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos17.containsKey(id)) {
                        mapaFotos17.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos17);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades17;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades18
    {
        get
        {
            List<Propiedad__c> propiedades18 = new List<Propiedad__c>();
            try {
                propiedades18 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Veracruz' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades18) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos18 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos18.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos18.containsKey(id)) {
                        mapaFotos18.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos18);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades18;
        }
        set;
   }
   
    public List<Propiedad__c> propiedades19
    {
        get
        {
            List<Propiedad__c> propiedades19 = new List<Propiedad__c>();
            try {
                propiedades19 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Ensenada' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades19) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos19 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos19.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos19.containsKey(id)) {
                        mapaFotos19.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos19);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades19;
        }
        set;
   }
   
    public List<Propiedad__c> propiedades20
    {
        get
        {
            List<Propiedad__c> propiedades20 = new List<Propiedad__c>();
            try {
                propiedades20 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Mexicali' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades20) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos20 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos20.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos20.containsKey(id)) {
                        mapaFotos20.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos20);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades20;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades21
    {
        get
        {
            List<Propiedad__c> propiedades21 = new List<Propiedad__c>();
            try {
                propiedades21 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Cancun' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades21) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos21 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos21.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos21.containsKey(id)) {
                        mapaFotos21.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos21);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades21;
        }
        set;
   }
    public List<Propiedad__c> propiedades22
    {
        get
        {
            List<Propiedad__c> propiedades22 = new List<Propiedad__c>();
            try {
                propiedades22 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Los Cabos' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades22) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos22 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos22.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos22.containsKey(id)) {
                        mapaFotos22.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos22);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades22;
        }
        set;
   }
   
     public List<Propiedad__c> propiedades23
    {
        get
        {
            List<Propiedad__c> propiedades23 = new List<Propiedad__c>();
            try {
                propiedades23 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Morelia' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades23) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos23 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos23.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos23.containsKey(id)) {
                        mapaFotos23.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos23);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades23;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades24
    {
        get
        {
            List<Propiedad__c> propiedades24 = new List<Propiedad__c>();
            try {
                propiedades24 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Tarimbaro' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades24) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos24 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos24.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos24.containsKey(id)) {
                        mapaFotos24.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos24);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades24;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades25
    {
        get
        {
            List<Propiedad__c> propiedades25 = new List<Propiedad__c>();
            try {
                propiedades25 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Vallarta' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades25) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos25 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos25.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos25.containsKey(id)) {
                        mapaFotos25.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos25);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades25;
        }
        set;
   }
   
    public List<Propiedad__c> propiedades26
    {
        get
        {
            List<Propiedad__c> propiedades26 = new List<Propiedad__c>();
            try {
                propiedades26 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Ahome' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades26) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos26 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos26.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos26.containsKey(id)) {
                        mapaFotos26.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos26);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades26;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades27
    {
        get
        {
            List<Propiedad__c> propiedades27 = new List<Propiedad__c>();
            try {
                propiedades27 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Chihuahua' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades27) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos27 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos27.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos27.containsKey(id)) {
                        mapaFotos27.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos27);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades27;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades28
    {
        get
        {
            List<Propiedad__c> propiedades28 = new List<Propiedad__c>();
            try {
                propiedades28 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Ciudad Juarez' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades28) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos28 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos28.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos28.containsKey(id)) {
                        mapaFotos28.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos28);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades28;
        }
        set;
   }
   
    public List<Propiedad__c> propiedades29
    {
        get
        {
            List<Propiedad__c> propiedades29 = new List<Propiedad__c>();
            try {
                propiedades29 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Culiacan' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades29) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos29 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos29.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos29.containsKey(id)) {
                        mapaFotos29.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos29);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades29;
        }
        set;
   }
   
    public List<Propiedad__c> propiedades30
    {
        get
        {
            List<Propiedad__c> propiedades30 = new List<Propiedad__c>();
            try {
                propiedades30 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Los Mochis' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades30) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos30 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos30.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos30.containsKey(id)) {
                        mapaFotos30.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos30);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades30;
        }
        set;
   }
   
    public List<Propiedad__c> propiedades31
    {
        get
        {
            List<Propiedad__c> propiedades31 = new List<Propiedad__c>();
            try {
                propiedades31 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Mazatlan' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades31) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos31 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos31.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos31.containsKey(id)) {
                        mapaFotos31.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos31);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades31;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades32
    {
        get
        {
            List<Propiedad__c> propiedades32 = new List<Propiedad__c>();
            try {
                propiedades32 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Sinaloa' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades32) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos32 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos32.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos32.containsKey(id)) {
                        mapaFotos32.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos32);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades32;
        }
        set;
   }
   
   public List<Propiedad__c> propiedades33
    {
        get
        {
            List<Propiedad__c> propiedades33 = new List<Propiedad__c>();
            try {
                propiedades33 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Gomez Palacio' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades33) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos33 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos33.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos33.containsKey(id)) {
                        mapaFotos33.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos33);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades33;
        }
        set;
   }
   
    public List<Propiedad__c> propiedades34
    {
        get
        {
            List<Propiedad__c> propiedades34 = new List<Propiedad__c>();
            try {
                propiedades34 = [SELECT FolioLlave__c,Plaza__c,Publicada_en_redes__c,Views__c FROM Propiedad__c WHERE Plaza__c = 'Tijuana' AND Publicada_en_redes__c != false ORDER BY Views__c DESC LIMIT 2];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades34) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos34 = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos34.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos34.containsKey(id)) {
                        mapaFotos34.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos34);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades34;
        }
        set;
   }
   
   
    }