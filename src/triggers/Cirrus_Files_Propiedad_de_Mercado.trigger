/**
 * Auto Generated and Deployed by Cirrus Files
 **/
trigger Cirrus_Files_Propiedad_de_Mercado on Propiedad_de_Mercado__c(before insert, after insert, after undelete, after update) {
    if (UserInfo.isCurrentUserLicensed('igd')) IGD.SyncBatcher.syncFiles();
}