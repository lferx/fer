global class ImageController {
	public Set<String> imagenes {get;set;}
	private integer counter = 0;
	private integer list_size = 20;
	public integer total_size; 
	public ImageController() {
		List<String> lista = new List<String>();
		List<Documento__c> ldocs = [Select Id From Documento__c Where DocumentoEtapa__r.Tipo__c = 'Fotografia'];
		imagenes = new Set<String>();
		for(Attachment att : [Select Id, Name From Attachment Where ParentId IN: ldocs order by CreatedDate desc]){
			if(!String.valueOf(att.Name).contains('docx')){
				lista.add(att.Id); 
			}
		}
		total_size = lista.size(); //set the total size in the constructor
	}
	
	public List<String> getNumbers(){
		try {
			List<String> lista = new List<String>();
			List<Documento__c> ldocs = [Select Id From Documento__c Where DocumentoEtapa__r.Tipo__c = 'Fotografia'];
			imagenes = new Set<String>();
			for(Attachment att : [Select Id, Name From Attachment Where ParentId IN: ldocs order by CreatedDate desc 
                                limit :list_size 
                                offset :counter]){
				if(!String.valueOf(att.Name).contains('docx')){
					lista.add(att.Id);
				}
			}
        return lista;
      } catch (QueryException e) {
         ApexPages.addMessages(e);   
         return null;
      }
   }
 
   public PageReference Beginning() { //user clicked beginning
      counter = 0;
      return null;
   }
 
   public PageReference Previous() { //user clicked previous button
      counter -= list_size;
      return null;
   }
 
   public PageReference Next() { //user clicked next button
      counter += list_size;
      return null;
   }
 
   public PageReference End() { //user clicked end
      counter = total_size - math.mod(total_size, list_size);
      return null;
   }
 
   public Boolean getDisablePrevious() { 
      //this will disable the previous and beginning buttons
      if (counter>0) return false; else return true;
   }
 
   public Boolean getDisableNext() { //this will disable the next and end buttons
      if (counter + list_size < total_size) return false; else return true;
   }
 
   public Integer getTotal_size() {
      return total_size;
   }
 
   public Integer getPageNumber() {
      return counter/list_size + 1;
   }
 
   public Integer getTotalPages() {
      if (math.mod(total_size, list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
   }
}