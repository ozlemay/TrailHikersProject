@isTest
public class AccountOppTriggerTest {
    @isTest
    static void testAccWithoutOpp() {
        // Test data setup
        Account testAccount1 = new Account(Name = 'Test Account 1');
        Account testAccount2 = new Account(Name = 'Test Account 2');
        insert new List<Account>{testAccount1, testAccount2};

        // Verify no opportunities initially
        List<Opportunity> initialOpportunities = [SELECT Id FROM Opportunity];
        System.assertEquals(0, initialOpportunities.size(), 'No initial opportunities should exist');

        // Update Account to create an Opportunity
        testAccount1.Name = 'Updated Account 1';
        update testAccount1;

        // Verify created Opportunity
        List<Opportunity> createdOpportunities = [SELECT Id FROM Opportunity];
        System.assertEquals(1, createdOpportunities.size(), 'One opportunity should be created');

        // Update Account without creating an Opportunity
        testAccount2.Name = 'Updated Account 2';
        update testAccount2;

        // Verify no additional Opportunity created
        List<Opportunity> updatedOpportunities = [SELECT Id FROM Opportunity];
        System.assertEquals(1, updatedOpportunities.size(), 'No additional opportunities should be created');
    }
}