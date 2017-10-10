public class PropiedadWrapper {

    public Boolean checked{ get; set; }
    public Propiedad__c prop { get; set;}
    public Attachment foto { get; set;}
    


    public PropiedadWrapper(){
        prop = new Propiedad__c();
        checked = false;
        foto = new Attachment ();
    }
                                                                                                                                              
    public PropiedadWrapper(Propiedad__c p){
        prop = p;
        checked = false;
        List<Attachment> adjuntos = [SELECT Id FROM Attachment WHERE ParentId =: p.Id];
        if (!adjuntos.isEmpty()){
            foto= adjuntos.get(0);
        }

    }

}