public with sharing class c5 {
	List<Account> tetrahidrocannabinol;
	public c5() {
		
	}

	public List<Account> gettetrahidrocannabinol(){
		return tetrahidrocannabinol;
	}

	public PageReference cogollo(){
		tetrahidrocannabinol=[select Name,Type,Phone from Account where Type='Lead Cliente' limit 30];
		return null;
	}

	public PageReference hash(){
		tetrahidrocannabinol=[select Name,Type,Phone from Account where Type='Matriz' limit 30];
		return null;
	}
}