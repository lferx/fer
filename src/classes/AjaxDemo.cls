public class AjaxDemo {

    private String currTime;
    public String getCurrTime()
    {
        return currTime;
    }
    public void setCurrTime()
    {
        currTime = System.now().format('EEEE, MMMM d, yyyy - hh:mm:ss');
    }
}