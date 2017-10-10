public class TriggerAccountHandler extends TriggerHandler{
	private Map<Id, Account> newMap;
	private Map<Id, Account> oldMap;
	private List<Account> newList;
	private List<Account> oldList;
 
	public TriggerAccountHandler() {
		this.newMap = (Map<Id, Account>) trigger.newMap;
		this.oldMap = (Map<Id, Account>) trigger.oldMap;
		this.newList = (List<Account>) trigger.new;
		this.oldList = (List<Account>) trigger.old;
	}
	
	public override void beforeInsert(){
		asignaValoresDefault();
	}
	
	public override void beforeUpdate(){
		asignaValoresDefault();
	}
	
	private void asignaValoresDefault(){
		for(Account acc : newList){
			if(acc.TipoProveedorFF__c == null){
				acc.TipoProveedorFF__c = acc.TipoProveedorDefault__c;
			}
			if(acc.c2g__CODAAccountsPayableControl__c == null){
				if(acc.TipoProveedorFF__c == 'Acreedor' && mapCuentasContables.containsKey('202')){
					acc.c2g__CODAAccountsPayableControl__c = mapCuentasContables.get('202').Id;
				}
				if(acc.TipoProveedorFF__c == 'Proveedor' &&  mapCuentasContables.containsKey('201')){
					acc.c2g__CODAAccountsPayableControl__c = mapCuentasContables.get('201').Id;
				}
			}
			if(acc.c2g__CODATaxCalculationMethod__c == null){
				acc.c2g__CODATaxCalculationMethod__c = 'Gross';
			}
			if(acc.c2g__CODAOutputVATCode__c == null && mapTaxCodes.containsKey('IVA 16%')){
				acc.c2g__CODAOutputVATCode__c = mapTaxCodes.get('IVA 16%').Id;
			}
			if(acc.c2g__CODAInputVATCode__c == null && mapTaxCodes.containsKey('IVA 16%')){
				acc.c2g__CODAInputVATCode__c = mapTaxCodes.get('IVA 16%').Id;
			}
			if(acc.c2g__CODASalesTaxStatus__c == null){
				acc.c2g__CODASalesTaxStatus__c = 'Taxable';
			}
			if(acc.c2g__CODATaxCode1__c == null &&  mapTaxCodes.containsKey('IVA 16%')){
				acc.c2g__CODATaxCode1__c = mapTaxCodes.get('IVA 16%').Id;
			}
			if(acc.c2g__CODATaxCode2__c == null && mapTaxCodes.containsKey('IVA 11%')){
				acc.c2g__CODATaxCode2__c = mapTaxCodes.get('IVA 11%').Id;
			}
			if(acc.c2g__CODATaxCode3__c == null &&  mapTaxCodes.containsKey('IVA 0%')){
				acc.c2g__CODATaxCode3__c = mapTaxCodes.get('IVA 0%').Id;
			}
			if(acc.c2g__CODAAccountTradingCurrency__c == null){
				acc.c2g__CODAAccountTradingCurrency__c = 'MXN';
			}
			if(acc.c2g__CODABaseDate1__c == null){
				acc.c2g__CODABaseDate1__c = 'Invoice Date';
			}
			if(acc.c2g__CODADaysOffset1__c == null){
				acc.c2g__CODADaysOffset1__c = 0;
			}
			if(acc.c2g__CODADescription1__c == null){
				acc.c2g__CODADescription1__c = 'COD';
			}
			if(acc.c2g__CODADiscount1__c == null){
				acc.c2g__CODADiscount1__c = 0;
			}
			if(acc.c2g__CODABillingMethod__c == null){
				acc.c2g__CODABillingMethod__c = 'Electronic';
			}
			if(acc.c2g__CODACreditStatus__c == null){
				acc.c2g__CODACreditStatus__c = 'Credit Allowed';
			}
			if(acc.c2g__CODABankAccountName__c == null && acc.Beneficiario__c != null){
				acc.c2g__CODABankAccountName__c = acc.Beneficiario__c;
			}
			if(acc.c2g__CODABankAccountNumber__c == null && acc.Cuenta_bancaria__c != null){
				acc.c2g__CODABankAccountNumber__c = acc.Cuenta_bancaria__c;
			}
			if(acc.c2g__CODABankAccountReference__c == null && acc.CLABE__c != null){
				acc.c2g__CODABankAccountReference__c = acc.CLABE__c;
			}
			if(acc.c2g__CODABankIBANNumber__c == null && acc.CLABE__c != null){
				acc.c2g__CODABankIBANNumber__c = acc.CLABE__c;
			}
			if(acc.c2g__CODABankSWIFTNumber__c == null && acc.CLABE__c != null){
				acc.c2g__CODABankSWIFTNumber__c = acc.CLABE__c;
			}
			if(acc.c2g__CODABankName__c == null && acc.Banco__c != null){
				acc.c2g__CODABankName__c = acc.Banco__c;
			}
			if(acc.c2g__CODAVATStatus__c == null){
				acc.c2g__CODAVATStatus__c = 'Home';
			}
			if(acc.c2g__CODAECCountryCode__c == null){
				acc.c2g__CODAECCountryCode__c = 'MX';
			}
			
		}
	}
	
	private Map<String, c2g__codaGeneralLedgerAccount__c> mapCuentasContables {
		get{
			if(mapCuentasContables == null){
				mapCuentasContables = new Map<String, c2g__codaGeneralLedgerAccount__c>();
				for(c2g__codaGeneralLedgerAccount__c gla : [Select Id, c2g__ReportingCode__c From c2g__codaGeneralLedgerAccount__c]){
					mapCuentasContables.put(gla.c2g__ReportingCode__c, gla);
				}
			}
			return mapCuentasContables;
		}set;
	}
	private Map<String, c2g__codaTaxCode__c> mapTaxCodes {
		get{
			if(mapTaxCodes == null){
				mapTaxCodes = new Map<String, c2g__codaTaxCode__c>();
				for(c2g__codaTaxCode__c item : [Select Id, Name From c2g__codaTaxCode__c]){
					mapTaxCodes.put(item.Name, item);
				}
			}
			return mapTaxCodes;
		}set;
	}
}