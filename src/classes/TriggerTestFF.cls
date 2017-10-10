@isTest (SeeAllData=true)
private class TriggerTestFF {
		public static String empresaName = 'Recicladora de Propiedades y Viviendas Mexicanas SA de CV';
		                                   

    static testMethod void AccountTrigger() {
        Account acc = new Account();
        acc.Name = 'uno';
        insert acc;
    }

    static testMethod void ConceptoCatalogoTrigger() {
        ConceptoCatalogo__c acc = new ConceptoCatalogo__c();
        acc.Name = 'uno';
        insert acc;
    }

    static testMethod void GastoTrigger() {
        Gasto__c ga = new Gasto__c();
		ga.Tipo__c = 'Automático';
		ga.Oferta__c = [Select Id From Oferta__c limit 1].Id;
		ga.Concepto__c = [Select Id From ConceptoCatalogo__c limit 1].Id;
		ga.Account__c =  [Select Id From Account limit 1].Id;
		ga.Fecha__c = Date.today();
		ga.Comentario__c = 'uno';
		ga.GLA__c = [Select Id From c2g__codaGeneralLedgerAccount__c limit 1].Id;
		ga.Importe__c = 100;
        insert ga;
        SolicitudPago__c solicitud = new SolicitudPago__c();
        solicitud.Account__c =  [Select Id From Account limit 1].Id;
        insert solicitud;
    }

    static testMethod void financialForceTriggers() {
    	Test.startTest();
    	//List<UserPackageLicense> userLicenses = [select CreatedById, CreatedDate, Id, LastModifiedById, LastModifiedDate, PackageLicenseId, SystemModstamp, UserId, PackageLicense.NamespacePrefix from UserPackageLicense Where Userid =: Userinfo.getUserId() AND PackageLicense.NamespacePrefix = 'c2g'];
    	//if(userLicenses.size() > 0 ){
    		payableInvoiceTest();
    		creditNoteTest();
    		journalTest();
    		cashEntryTest();
				paymentTest();
    	//}
    	Test.stopTest();
    }

    public static void payableInvoiceTest() {
    	
    	
		
		 
		
		 Account acc = TriggerTestFF.generaCuentaFF('Uno');
		
		    
		
		 
		    	
        c2g__codaPurchaseInvoice__c parent = new c2g__codaPurchaseInvoice__c();
        parent.c2g__Account__c = acc.Id;
        parent.c2g__InvoiceDate__c = Date.today();
        parent.c2g__AccountInvoiceNumber__c = 'pruebaTest01';
        parent.ffap__DeriveDueDate__c = true;
        insert parent;
        
        c2g__codaPurchaseInvoiceExpenseLineItem__c lineItem = new c2g__codaPurchaseInvoiceExpenseLineItem__c();
        lineItem.c2g__PurchaseInvoice__c = parent.Id;
        lineItem.c2g__GeneralLedgerAccount__c = [Select Id From c2g__codaGeneralLedgerAccount__c limit 1].Id;
		lineItem.c2g__NetValue__c = 100;
		lineItem.ffap__SetGLAToDefault__c = false;
		insert lineItem;
		
		c2g__codaPurchaseInvoice__c testParentQuery = [SELECT Id, Name FROM c2g__codaPurchaseInvoice__c order by CreatedDate desc limit 1];
      	System.assertEquals(parent.Id, testParentQuery.Id);

		c2g.CODAAPICommon.Reference ref = new c2g.CODAAPICommon.Reference();
		ref.Id = parent.Id;
		c2g.CODAAPIPurchaseInvoice_9_0.PostPurchaseInvoice(null, ref);
    }

    public static void creditNoteTest() {
    	Account acc = TriggerTestFF.generaCuentaFF('Uno');
        c2g__codaPurchaseCreditNote__c parent = new c2g__codaPurchaseCreditNote__c();
        parent.c2g__Account__c = acc.Id;
        parent.c2g__CreditNoteDate__c = Date.today();
        parent.c2g__AccountCreditNoteNumber__c = 'pruebaTest01';
        parent.ffap__DeriveDueDate__c = true;
        insert parent;
        c2g__codaPurchaseCreditNoteExpLineItem__c lineItem = new c2g__codaPurchaseCreditNoteExpLineItem__c();
        lineItem.c2g__PurchaseCreditNote__c = parent.Id;
        lineItem.c2g__GeneralLedgerAccount__c = [Select Id From c2g__codaGeneralLedgerAccount__c limit 1].Id;
		lineItem.c2g__NetValue__c = 100;
		lineItem.ffap__SetGLAToDefault__c = false;
		insert lineItem;
		c2g__codaPurchaseCreditNote__c testParentQuery = [SELECT Id, Name FROM c2g__codaPurchaseCreditNote__c order by CreatedDate desc limit 1];
      	System.assertEquals(parent.Id, testParentQuery.Id);
    }

    public static void journalTest() {
        c2g__codaJournal__c parent = new c2g__codaJournal__c();
        parent.c2g__JournalDate__c = Date.today();
        parent.c2g__JournalCurrency__c = [Select Id From c2g__codaAccountingCurrency__c Where Name = 'MXN' AND c2g__OwnerCompany__r.Name =: TriggerTestFF.empresaName limit 1].Id;
        insert parent;
        c2g__codaJournalLineItem__c lineItem = new c2g__codaJournalLineItem__c();
        lineItem.c2g__Journal__c = parent.Id;
        lineItem.c2g__GeneralLedgerAccount__c = [Select Id From c2g__codaGeneralLedgerAccount__c limit 1].Id;
				lineItem.c2g__Value__c = 100;
				lineItem.c2g__LineType__c = 'General Ledger Account';
				lineItem.c2g__DebitCredit__c = 'Debit';
				lineItem.c2g__Dimension1__c = [Select Id From c2g__codaDimension1__c limit 1].Id;
				lineItem.c2g__Dimension2__c = [Select Id From c2g__codaDimension2__c limit 1].Id;
				insert lineItem;
		c2g__codaJournal__c testParentQuery = [SELECT Id, Name FROM c2g__codaJournal__c order by CreatedDate desc limit 1];
      	System.assertEquals(parent.Id, testParentQuery.Id);
    }

    public static void cashEntryTest() {
    	Account acc = TriggerTestFF.generaCuentaFF('Uno Cash');
        c2g__codaCashEntry__c parent = new c2g__codaCashEntry__c();
        parent.c2g__Type__c = 'Receipt';
        parent.c2g__BankAccount__c = [Select Id From c2g__codaBankAccount__c Where c2g__OwnerCompany__r.Name =:TriggerTestFF.empresaName limit 1].Id;
        parent.c2g__Date__c = Date.today();
        parent.c2g__Period__c = [select Id from c2g__codaPeriod__c Where c2g__EndDate__c >=: Date.today() AND c2g__StartDate__c <=: Date.today() AND  c2g__OwnerCompany__r.Name =: TriggerTestFF.empresaName limit 1].Id;
        parent.c2g__CashEntryCurrency__c = [Select Id From c2g__codaAccountingCurrency__c Where Name = 'MXN' AND c2g__OwnerCompany__r.Name =: TriggerTestFF.empresaName limit 1].Id;
        parent.c2g__PaymentMethod__c = 'Cash';
        insert parent;
        c2g__codaCashEntryLineItem__c lineItem = new c2g__codaCashEntryLineItem__c();
        lineItem.c2g__CashEntry__c = parent.Id;
        lineItem.c2g__Account__c = acc.Id;
				lineItem.c2g__CashEntryValue__c = 100;
				lineItem.c2g__AccountPaymentMethod__c = 'Cash';
				lineItem.c2g__AccountDimension1__c = [Select Id From c2g__codaDimension1__c limit 1].Id;
				lineItem.c2g__AccountDimension2__c = [Select Id From c2g__codaDimension2__c limit 1].Id;
				insert lineItem;
				c2g__codaCashEntry__c testParentQuery = [SELECT Id, Name FROM c2g__codaCashEntry__c order by CreatedDate desc limit 1];
      	System.assertEquals(parent.Id, testParentQuery.Id);
    }

		public static void paymentTest() {
	    	Account acc = TriggerTestFF.generaCuentaFF('Uno Cash');
				c2g__codaPayment__c parent = new c2g__codaPayment__c();
				parent.c2g__BankAccount__c = [Select Id From c2g__codaBankAccount__c Where c2g__OwnerCompany__r.Name =:TriggerTestFF.empresaName limit 1].Id;
				parent.c2g__DueDate__c = Date.today();
				parent.c2g__PaymentDate__c = Date.today();
				parent.c2g__Period__c = [select Id from c2g__codaPeriod__c Where c2g__EndDate__c >=: Date.today() AND c2g__StartDate__c <=: Date.today() AND  c2g__OwnerCompany__r.Name =: TriggerTestFF.empresaName limit 1].Id;
				parent.c2g__SettlementDiscountReceived__c = TriggerTestFF.mapCuentasContables.get('501-100').Id;
				parent.c2g__CurrencyWriteOff__c = TriggerTestFF.mapCuentasContables.get('501-100').Id;
				parent.c2g__PaymentCurrency__c = [Select Id From c2g__codaAccountingCurrency__c Where Name = 'MXN' AND c2g__OwnerCompany__r.Name =: TriggerTestFF.empresaName limit 1].Id;
        insert parent;

				update [Select Id From c2g__codaPaymentLineItem__c limit 1];

				c2g__codaPayment__c testParentQuery = [SELECT Id, Name FROM c2g__codaPayment__c order by CreatedDate desc limit 1];
				System.assertEquals(parent.Id, testParentQuery.Id);
	    }

    public static Account generaCuentaFF(String nombre){
    	Map<String, c2g__codaGeneralLedgerAccount__c> mapCuentasContables;
		if(mapCuentasContables == null){
			mapCuentasContables = new Map<String, c2g__codaGeneralLedgerAccount__c>();
			for(c2g__codaGeneralLedgerAccount__c gla : [Select Id, c2g__ReportingCode__c From c2g__codaGeneralLedgerAccount__c]){
				mapCuentasContables.put(gla.c2g__ReportingCode__c, gla);
			}
		}
		Map<String, c2g__codaTaxCode__c> mapTaxCodes;
		if(mapTaxCodes == null){
			mapTaxCodes = new Map<String, c2g__codaTaxCode__c>();
			for(c2g__codaTaxCode__c item : [Select Id, Name From c2g__codaTaxCode__c]){
				mapTaxCodes.put(item.Name, item);
			}
		}

    	Account acc = new Account();
        acc.Name = nombre;
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
		if(acc.c2g__CODAAccountsReceivableControl__c == null && mapCuentasContables.containsKey('202')){
			acc.c2g__CODAAccountsReceivableControl__c = mapCuentasContables.get('209').Id;
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
        insert acc;
        return acc;
    }

		public static Map<String, c2g__codaGeneralLedgerAccount__c> mapCuentasContables{
			get{
				if(mapCuentasContables == null){
					mapCuentasContables = new Map<String, c2g__codaGeneralLedgerAccount__c>();
					for(c2g__codaGeneralLedgerAccount__c gla : [Select Id, c2g__ReportingCode__c From c2g__codaGeneralLedgerAccount__c]){
						mapCuentasContables.put(gla.c2g__ReportingCode__c, gla);
					}
				}
				return mapCuentasContables;
			}
			set;
		}

}