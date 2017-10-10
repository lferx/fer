@isTest
private class TEST_PropiedadImagesControllerOferta 
{

    @isTest static void test_method_one() 
    {
        Oferta__c propiedad  = new Oferta__c();
        propiedad.Name = 'test';
        insert propiedad;

        String bodyStr = String.valueOf(System.now());
   
        Attachment att = new Attachment();
        att.Body = Blob.valueOf(bodyStr);
        att.Name = 'Note_' + System.now().format('yyyy_MM_dd_hh_mm_ss') + '.txt';
        att.parentId=propiedad.Id;
        insert att;

        ApexPages.StandardController std = new ApexPages.StandardController(propiedad);
        PropiedadImagesControllerOferta  controller = new PropiedadImagesControllerOferta (std);
    }

}