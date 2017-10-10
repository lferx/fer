@isTest

    public with sharing class Informe_Inversionistas_Controller_Test {

        static testMethod void testMethod1()

        {
        	Informe_Inversionistas_Controller obj = new Informe_Inversionistas_Controller();
        	
            Test.startTest();
                
                obj.cobertura();

            Test.stopTest();
        }
    }