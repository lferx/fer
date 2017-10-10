public with sharing class Hec_t_Controller {

 
    public String prueba1 {get;set;}
    public Integer x {get;set;}
    public Integer y {get;set;}
    public Integer z {get;set;}
    public Datetime hoy {get;set;} 
    public String hoyString {get;set;}      
    
    public  Hec_t_Controller(){
    x=4;
    y=4;
    z=x+y;
        prueba1 = 'hola';
        
        hoy = Datetime.now();
         hoyString = hoy.format();        
    }
    
    
    

}