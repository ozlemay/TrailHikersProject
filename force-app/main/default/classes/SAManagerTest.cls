@isTest
public class SAManagerTest {
	@isTest
    static void testMethods (){
       Contact supervisor = new Contact(lastname='testSUpervisor'); 
       insert supervisor;
       SA_Detail__c sa = new SA_Detail__c (Experience__c = 3, Name__c='TestSA', Supervisor__c = supervisor.Id);
       insert sa;
       List<SA_Detail__c> saList = SAManager.getAllSA();
       System.assert(saList.size()>0);

       List<SA_Detail__c> saList2 = SAManager.searchSas('Test');
       System.assert(saList2.size()>0);
               
    }
}