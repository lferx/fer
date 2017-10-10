public class AccountBotelosTrigger 
{
    public void createBoleto(Account[] accs)
    {
        Sorteo__c sorteo = [SELECT Id, Name FROM Sorteo__c WHERE Fecha_de_inicio__c <=: System.today() AND Fecha_de_fin__c >=: System.today() limit 1];
        List<Boleto__c> lstBoletos = new List<Boleto__c>();
        for(Account acc:accs){
            if (acc.Registrado__c == false) {
                Boleto__c boleto = new Boleto__c();
                boleto.Sorteo__c = sorteo.Id;
                boleto.Cliente__c = acc.Id;
                boleto.Estado__c = 'Activo';
                lstBoletos.add( boleto );
            }
        }
        insert lstBoletos;
    }
}