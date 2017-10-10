global class ScheduleEnvios implements Schedulable{
   global void execute(SchedulableContext SC) {
      BatchEmail b = new BatchEmail(); 
      database.executebatch(b);
   }
}