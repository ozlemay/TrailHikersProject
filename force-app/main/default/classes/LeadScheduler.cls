public class LeadScheduler implements Schedulable {
    // Method executed by the scheduled job
    public void execute(SchedulableContext context) {
        LeadBatch leadBatch = new LeadBatch();
        Database.executeBatch(leadBatch);
    }

    // Method to schedule the LeadBatch job
    public static void scheduleLeadBatch() {
        String jobName = 'LeadBatchJob';
        String cronExpression = '0 0 23 * * ?'; // Scheduled to run every day at 23:00
 
       
      
    }
}