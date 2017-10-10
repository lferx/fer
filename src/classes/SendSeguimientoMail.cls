global class SendSeguimientoMail implements Schedulable {
	global void execute(SchedulableContext sc) {
        MailerController mc = new MailerController();
		mc.sendSeguimientoEmail();
	}
}