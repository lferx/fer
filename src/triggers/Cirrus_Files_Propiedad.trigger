/**
 * Auto Generated and Deployed by Cirrus Files
 **/
trigger Cirrus_Files_Propiedad on Propiedad__c(before insert, after insert, after undelete, after update) {
    if (UserInfo.isCurrentUserLicensed('igd')) IGD.SyncBatcher.syncFiles();
}