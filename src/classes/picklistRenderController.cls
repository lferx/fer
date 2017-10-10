public with sharing class picklistRenderController {

	public List<selectoption> display { get; set; }
  public String selectId { get; set; }

	public picklistRenderController() {
		display =new List<selectoption>();
     display.add(new selectoption('none','-select-'));
     display.add(new selectoption('show','show'));
     display.add(new selectoption('hide','hide'));
		
	}

	public PageReference buttonB(){
		return null;
	}


	public PageReference buttonA(){
		return null;
	}


	public PageReference displayButton(){
		return null;
	}
}