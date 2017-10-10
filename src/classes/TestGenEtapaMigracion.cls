@isTest(SeeAllData=true)
private class TestGenEtapaMigracion {

    static testMethod void EtMigTest() {
        GenEtapaMigracion gd = new GenEtapaMigracion();
        gd.iNumEtapa = 9;
        gd.ofta = 'Test1';
        gd.procesa();
        gd.cierraproceso();
        gd.abredes();
        gd.EtapasInv();
        gd.CheckBoxI();
        gd.CreaPasos();
    }
}