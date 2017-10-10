trigger AccountWebTirgger on Account (after update) 
{
    if (Trigger.isAfter && Trigger.isUpdate ) {
        AccountBotelosTrigger clase = new AccountBotelosTrigger();
        clase.createBoleto(Trigger.new);
    }
}