public class TaskSearchController {

  String userId {get; set;}
  String prefijo;
  String baseURL;
  String wholeUrl;
  public String qry;
  public String qryAdvance;
  public String total_qry;
  public String busqueda {get; set;}
  public Date   fechaBusqueda {get; set;}
  public List<TareaWrp> tareas {get; set;}
  Map<Id, String> nombreMap{get;set;}
  private Integer counter=0;
  public Integer list_size {get;set;}
  public  Integer total_size;
  public List<Task>qResult =new List<Task>();
  public List<Task>qResult2 =new List<Task>();
  public Task dataTask {get; set;}
  public List<String> filtroLista {get; set;}

  public TaskSearchController(){
    dataTask=new Task();
    dataTask.Fecha__c=null;
    busqueda=null;
    list_size=10;
    userId = UserInfo.getUserId();
    prefijo = '001';
    tareas = new List<TareaWrp>();
    System.debug('Usuario: ' + userId);
    Inicio();
    System.debug('Fecha inicial::: ' + dataTask.Fecha__c);
  }

  public void countTask(){
    total_qry='SELECT Count() FROM Task WHERE Status = \'No iniciada\'  AND OwnerId =\''+userId+'\'';
    filtroLista= new List<String>();

    if(dataTask.Fecha__c!=null) {
      total_qry+=' AND ';
      total_qry+= '(Fecha__c = '+String.valueOf(dataTask.Fecha__c)+' OR ActivityDate='+String.valueOf(dataTask.Fecha__c)+')';
    }else{
      total_qry+=' AND ';
      total_qry+= 'Fecha__c >2017-06-28 ';
    }

    if(busqueda!=null&&busqueda.length()>1){

      List<List<sObject>> searchList = [FIND :busqueda IN ALL FIELDS 
      RETURNING Account(Id,Name),Task(Id,Description, Comentarios__c,Subject,Asunto2__c WHERE OwnerId =:userId)];//,Contact(Id,FirstName,LastName,Department)
      Account[] searchAccounts = (Account[])searchList[0];
        //Contact[] searchContacts = (Contact[])searchList[2];
      Task[] searchTask = (Task[])searchList[1];

      System.debug('Account::');
      for (Account a : searchAccounts) {
        System.debug(':::'+a.Name+a.Id);
        filtroLista.add(a.Id);
      }

      System.debug('Task::');
      for (Task t : searchTask) {
        System.debug(':::'+t.Id+' '+t.Comentarios__c+' '+t.Subject+' '+t.Asunto2__c);
        filtroLista.add(t.Id);
      }

      qryAdvance = '';
      if(filtroLista.size()>0){

        qryAdvance=' AND (Id = \''+filtroLista[0]+'\'';
        for(Integer i=1;i<filtroLista.size();i++){
            qryAdvance+=' OR Id = \''+filtroLista[i]+'\'';
        }
      
        qryAdvance+='OR whatId = \''+filtroLista[0]+'\'';
        for(Integer j=1;j<filtroLista.size();j++){
          qryAdvance+=' OR whatId = \''+filtroLista[j]+'\'';
        }
        qryAdvance+=')';
      }

      total_qry+=qryAdvance;
      System.debug('QueryT::: ' + total_qry);
    }
    
    total_size= Database.countquery(total_qry); 
  }

  public void getTasks(){
    countTask();

    qry='SELECT Id, Description, OwnerId, Comentarios__c, Status,Hora_de_vencimiento__c,Fecha__c,ActivityDate FROM Task ';
    qry+='WHERE Status = \'No iniciada\' ';  
    qry+='AND OwnerId = \''+userId+'\' ';
    
    if(dataTask.Fecha__c!=null) {//date.valueOf('2017-06-28')
      qry+=' AND ';
      qry += '(Fecha__c = '+String.valueOf(dataTask.Fecha__c)+' OR ActivityDate='+String.valueOf(dataTask.Fecha__c)+')';              
    }else{
      qry+=' AND ';
      qry += 'Fecha__c >2017-06-28 ';
    }

    if(busqueda!=null&&busqueda.length()>1){
      qry+=qryAdvance;
    }

    qry+=' ORDER BY Hora_de_vencimiento__c   limit '+list_size +' offset '+counter;       
    System.debug('Query::: ' + qry);
    
    Integer i=counter;
    tareas = new List<TareaWrp>();
    nombreMap = new Map<Id, String>();
    
    for(Task objTarea: qResult = Database.query(qry)){
        //[SELECT Id, Description, OwnerId, Comentarios__c, Status,Hora_de_vencimiento__c,Fecha__c FROM Task WHERE (Status = 'No iniciada') AND (OwnerId =:UserInfo.getUserId()) and Fecha__c>2017-06-28 ORDER BY Hora_de_vencimiento__c ASC,Fecha__c desc limit :list_size offset :counter]
      String taskId = objTarea.Id;
      i++;

      if(objTarea.Description != null && objTarea.Description.contains('|')){
        List<String> splitDescripcion = objTarea.Description.split('\\Q|\\E');
 
        if(splitDescripcion.size() >= 3){
          System.debug(splitDescripcion);
          tareas.add(new TareaWrp(objTarea, i ,splitDescripcion.get(0), splitDescripcion.get(1), splitDescripcion.get(2)));
          nombreMap.put(splitDescripcion.get(2),null);
          System.debug('idTarea: ' + taskId);
        }
 
      }

    }
     getNames();
  }

  public PageReference Inicio(){
    counter=0;
    getTasks();
    return null;
  }

  public PageReference Previo(){
    counter -= list_size;
    getTasks();
    return null;
  }

  public PageReference Siguiente(){
    counter += list_size;
    getTasks();
    return null;
  }    

  public PageReference Fin(){
    counter = total_size - math.mod(total_size, list_size);
    getTasks();
    return null;
  }    

  public Boolean getanularPrevio(){
    if(counter>0)
      return false;
    else
     return true;
  }

  public Boolean getanularSiguiente(){
    System.debug('contador:::'+counter+' TamañoLista'+list_size+' TamañoTotal'+total_size);
    if(counter+list_size<total_size)
      return false;
    else
      return true;
  }

  public Integer getTotalSize(){
    return total_size;
  }

  public Integer getPageNumber(){
    return  counter/list_size+1;
  }

  public Integer getTotalPages(){
  
    if(math.mod(total_size,list_size)>0){
      return total_size/list_size+1;
    }else{
      return (total_size/list_size+1);
    }

  }

  public void getNames(){

    for(Account objLead : [SELECT Id, Name FROM Account WHERE Id=: nombreMap.keySet()]){
      nombreMap.put(objLead.Id,objLead.Name);
    }
    for(TareaWrp objTw: tareas){
      objTw.leadName = nombreMap.get(objTw.leadId);
    }
  }

  public class TareaWrp{

    public Task tarea {get;set;}
    public Integer numero {get;set;}
    public String link {get;set;}
    public String descripcion {get;set;}
    public String leadId {get; set;}
    public String leadName {get; set;}
    public String vfName{get; set;}
    public String baseURL{get; set;}

    public TareaWrp(Task tarea, Integer numero, String descripcion, String vfName, String leadId){
      this.descripcion = descripcion;
      this.leadId = leadId;
      this.vfName = vfName;
      this.tarea = tarea;
      this.numero = numero;
      this.baseURL = URL.getSalesforceBaseUrl().toExternalForm();
      List<Account> cuenta;

      if(vfName == 'AutorizacionLead'){
          this.link = baseURL + '/apex/' + vfName + '?idAccount=' + leadId + '&idTask=' + tarea.id;
      }else{
        this.link = baseURL + '/apex/' + vfName + '?id=' + leadId + '&idTask=' + tarea.id;
      }
      System.debug(this.vfName);
    }
  }
}