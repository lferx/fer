@isTest

    public with sharing class Panel_Inversionistas_ControllerTest {

        static testMethod void testMethod1()

        {
        	Panel_Inversionistas_Controller obj = new Panel_Inversionistas_Controller();
        	
            Test.startTest();
                
                obj.cobertura();

            Test.stopTest();
        }
    }