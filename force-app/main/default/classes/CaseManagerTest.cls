@isTest
private class CaseManagerTest {
    @isTest
    static void testGetCaseById() {
        // Test data setup
        Case testCase = new Case(Subject = 'Test Case', Status = 'New', Origin = 'Email', Priority = 'High');
        insert testCase;
        
        // Test HTTP GET request
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = '/Cases/' + testCase.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        // Call the REST service method
        Case responseCase = CaseManager.getCaseById();
        
        // Assert the results
        System.assertEquals(testCase.Subject, responseCase.Subject);
        System.assertEquals(testCase.Status, responseCase.Status);
        System.assertEquals(testCase.Origin, responseCase.Origin);
        System.assertEquals(testCase.Priority, responseCase.Priority);
    }
    
    @isTest
    static void testCreateCase() {
        // Test HTTP POST request
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = '/Cases/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf('{"subject": "New Case", "status": "New", "origin": "Phone", "priority": "Low"}');
        RestContext.request = request;
        
        // Call the REST service method
        String caseId = CaseManager.createCase('New Case', 'New', 'Phone', 'Low');
        
        // Retrieve the created case
        Case newCase = [SELECT Id, Subject, Status, Origin, Priority FROM Case WHERE Id = :caseId];
        
        // Assert the results
        System.assertEquals('New Case', newCase.Subject);
        System.assertEquals('New', newCase.Status);
        System.assertEquals('Phone', newCase.Origin);
        System.assertEquals('Low', newCase.Priority);
    }
    
    @isTest
    static void testDeleteCase() {
        // Test data setup
        Case testCase = new Case(Subject = 'Test Case', Status = 'New', Origin = 'Email', Priority = 'High');
        insert testCase;
        
        // Test HTTP DELETE request
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = '/Cases/' + testCase.Id;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        
        // Call the REST service method
        CaseManager.deleteCase();
        
        // Try to retrieve the deleted case
        Case deletedCase = [SELECT Id FROM Case WHERE Id = :testCase.Id];
        
        // Assert the results (case should not exist after deletion)
        System.assertEquals(null, deletedCase);
    }
    
    @isTest
    static void testUpsertCase() {
        // Test data setup
        Case testCase = new Case(Subject = 'Test Case', Status = 'New', Origin = 'Email', Priority = 'High');
        insert testCase;
        
        // Test HTTP PUT request
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri = '/Cases/' + testCase.Id;
        request.httpMethod = 'PUT';
        request.requestBody = Blob.valueOf('{"subject": "Updated Case", "status": "In Progress", "origin": "Chat", "priority": "Medium"}');
        RestContext.request = request;
        
        // Call the REST service method
        String caseId = CaseManager.upsertCase('Updated Case', 'In Progress', 'Chat', 'Medium', testCase.Id);
        
        // Retrieve the updated case
        Case updatedCase = [SELECT Id, Subject, Status, Origin, Priority FROM Case WHERE Id = :caseId];
        
        // Assert the results
        System.assertEquals('Updated Case', updatedCase.Subject);
        System.assertEquals('In Progress', updatedCase.Status);
        System.assertEquals('Chat', updatedCase.Origin);
        System.assertEquals('Medium', updatedCase.Priority);
    }
}