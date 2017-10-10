public with sharing class Utils {
	public static string getCreatableFieldsSOQL(String objectName, String whereClause, Boolean allFields){
		String selects = '';
		if (whereClause == null || whereClause == ''){ return null; }

		//Get a map of field name and field token
		Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
		list<string> selectFields = new list<string>();
		
		if (fMap != null){
			for (Schema.SObjectField ft : fMap.values()){ // loop through all field tokens (ft)
				Schema.DescribeFieldResult fd = ft.getDescribe(); // describe each field (fd)
				if (fd.isCreateable() || allFields){ // field is creatable
					selectFields.add(fd.getName());
				}
			}
		}
		
		if (!selectFields.isEmpty()){
			for (string s:selectFields){ 
				selects += s + ',';
			}
			if (selects.endsWith(',')){selects = selects.substring(0,selects.lastIndexOf(','));}
		}
		return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;
	}
	
	public static Map<String, EmailTemplate> MAP_EMAILTEMPLATES{
		get{
			if(MAP_EMAILTEMPLATES == null){
				MAP_EMAILTEMPLATES = new Map<String, EmailTemplate>();
				for(EmailTemplate temp : [Select Id, DeveloperName From EmailTemplate]){
					MAP_EMAILTEMPLATES.put(temp.DeveloperName, temp);
				}
			}
			return MAP_EMAILTEMPLATES;
		}set;
	}
	
	//Pass the resource name  
    public static String getResourceURL(String resourceName)  
    {  
        //Fetching the resource  
        list<StaticResource> resourceList = [SELECT Name, NamespacePrefix, SystemModStamp FROM StaticResource WHERE Name = :resourceName];  
                              
        //Checking if the result is returned or not  
        if(resourceList.size() == 1)  
        {  
           //Getting namespace  
           String namespace = resourceList[0].NamespacePrefix;  
           //Resource URL  
           return '/resource/' + resourceList[0].SystemModStamp.getTime() + '/' + (namespace != null && namespace != '' ? namespace + '__' : '') + resourceName;   
        }  
        else return '';  
    } 
}