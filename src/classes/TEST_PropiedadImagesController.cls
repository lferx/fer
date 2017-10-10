@isTest
private class TEST_PropiedadImagesController 
{

    @isTest static void test_method_one() 
    {
        Propiedad__c propiedad  = new Propiedad__c();
        propiedad.Name = 'test';
        insert propiedad;

        String bodyStr = String.valueOf(System.now());
   
        Attachment att = new Attachment();
        att.Body = Blob.valueOf(bodyStr);
        att.Name = 'Note_' + System.now().format('yyyy_MM_dd_hh_mm_ss') + '.txt';
        att.parentId=propiedad.Id;
        insert att;

        ApexPages.StandardController std = new ApexPages.StandardController(propiedad);
        PropiedadImagesController controller = new PropiedadImagesController(std);
    }

}