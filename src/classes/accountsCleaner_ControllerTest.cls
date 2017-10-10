@isTest

    public with sharing class accountsCleaner_ControllerTest {

        static testMethod void testMethod1()

        {
        	accountsCleaner_Controller objeto = new accountsCleaner_Controller();

            Test.startTest();
                objeto.cobertura();
            Test.stopTest();
        }
    }