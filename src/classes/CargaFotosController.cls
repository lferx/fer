public with sharing class CargaFotosController {
   
    
    public Propiedad__c propiedad;
    public Propiedad__c Nombre;
    public Attachment archivo1 {get;set;}
    public List <Attachment> archivos {get;set;}
    public List <WrapperFoto> fotos{get;set;}
    
    public CargaFotosController(ApexPages.StandardController controller) {
        propiedad = (Propiedad__c) controller.getRecord();
        cargaInicialFotos();
    }
    
    public void cargaInicialFotos(){
                archivos = new List <Attachment>();
                
                for(Integer i=0; i<=4;i++){
                Attachment archivo = new Attachment();
                archivos.add(archivo);
        }

        set <string> idsfotosWeb= new set <string>();
        fotos = new List <WrapperFoto>();       
                for( FotoWeb__c foto : [Select Id, EstatusFoto__c, CreatedDate  From FotoWeb__c Where Propiedad__c =: propiedad.Id Order by CreatedDate desc ]){
                        WrapperFoto registro = new WrapperFoto();
            registro.fotoWeb= foto;
            fotos.add(registro);
            idsfotosWeb.add(foto.Id);
        }
                for(Attachment attach: [SELECT Id, Name, ParentId, CreatedDate, ContentType FROM Attachment WHERE ParentId IN:idsfotosWeb Order by CreatedDate desc ]){
                        for (WrapperFoto wrapper: fotos){
                                if(wrapper.fotoWeb.Id== attach.ParentId){ 
                                        wrapper.attach=attach;
                                        break;  
                                }                                                    
                        }
                }
        }
    
    public PageReference guarda() {
                try{
                        
                        for (Integer j=0;j<archivos.size();j++){ 
                                if (archivos[j].Name!=null){    
                                        FotoWeb__c fw =new FotoWeb__c();
                                        fw.EstatusFoto__c = 'Borrador';
                                        fw.Propiedad__c = propiedad.Id;
                                        if (archivos[j].ContentType!='image/jpeg'){
                                                ApexPages.Message alerta = new ApexPages.Message(ApexPages.Severity.ERROR, 'Tipo de imagen no válido');
                                                ApexPages.addMessage(alerta);   
                                        }
                                        if (archivos[j].BodyLength>256000){
                                                ApexPages.Message alerta = new ApexPages.Message(ApexPages.Severity.ERROR, 'Tamaño no permitido');
                                                ApexPages.addMessage(alerta);           
                                        }
                                        if (archivos[j].body!=null){                                                    
                                                insert fw;
                                                archivos[j].ParentId = fw.Id;
                                                insert archivos[j];                     
                                        }
                                }
                        }
                        cargaInicialFotos();
                }catch(Exception e){
                        system.debug(e);
                }
                return null;    
    }
    
    public PageReference Actualizar() {
     
        List<fotoWeb__c> actualizacion = new List <fotoWeb__c>();      
        List<Attachment> fotoActualizada = new List <Attachment>();
                for(WrapperFoto actualizafoto: fotos){
                        if (actualizafoto.attach!=null){
                                actualizacion.add(actualizafoto.fotoWeb);
                                fotoActualizada.add(actualizafoto.attach);  
             }
                }
                update actualizacion;
                update fotoActualizada;
                List <Attachment> attachPorBorrar = new List<Attachment>();
                List <fotoWeb__c> fotosWebPorBorrar = new List <fotoWeb__c>();        
                for(Integer i = 0;i<fotos.size();i++ ){    
                        if(fotos[i].borrar==true){
                                attachPorBorrar.add(fotos[i].attach);
                                fotosWebPorBorrar.add(fotos[i].fotoWeb);
                                fotos.remove(i);        
                                i--;    
                        }                
                }          
                delete attachPorBorrar;
                delete fotosWebPorBorrar;                                    
        return null;
    }
        
    public class WrapperFoto{
        public Attachment attach {get;set;}
        public FotoWeb__c fotoWeb {get;set;}
        public boolean borrar {get;set;}
        
        public WrapperFoto(Attachment att, FotoWeb__c foto){
            this.attach = att;
            this.fotoWeb = foto;
        }
        
        public WrapperFoto(){   
        }
    }
}