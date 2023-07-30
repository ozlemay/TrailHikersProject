public class AccountOppHandler {
    public static void accWithoutOpp(List<Account> newAcc) {
        List<Opportunity> oppToCreate = new List<Opportunity>();
        
        for (Account acc : newAcc) {
            if (acc.Opportunities.size() == 0) {
                Opportunity newOpportunity = new Opportunity(
                    Name = acc.Name + 'Opportunity',
                    StageName = 'Prospecting',
                    CloseDate = Date.today().addMonths(1),
                    AccountId = acc.Id
                );
                oppToCreate.add(newOpportunity);
            }
        }
        
        if (oppToCreate.size() > 0) {
            insert oppToCreate;
        }
        
    }
}