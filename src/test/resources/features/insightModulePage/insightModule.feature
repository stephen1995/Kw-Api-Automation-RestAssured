@SmokeTestFeature
Feature: API Insight Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing1
    Scenario: Successful login
      Given request body from static file "insightModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
 @GET @testing1
    Scenario: Get all insights information
      When the client performs GET request on "{(basePath)}/insights"
      And content type is "application/json"
      Then status code is 200
      And response is not empty
      
 @Positive @testing1
Scenario Outline: Create, update, list and delete insights
	Given request body from static file "insightModulePage/requests/createContact.json"
    And content type is "application/json"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactId" equal to property "data.id" value
    
    Given request body from file "insightModulePage/requests/createInsight.json" with values "<ContactId>" 
    |%idContactExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/insights"
    Then status code is 201
    And response is not empty
    And let variable "insightId" equal to property "data.id" value
    
    Given request body from file "insightModulePage/requests/updateInsight.json" with values "<ContactId>" 
    |%idContactExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/insights/<InsightId>"
    Then status code is 200
    And response is not empty
    
    When the client performs GET request on "{(basePath)}/insights/<InsightId>" 
	Then status code is 200
	
	When the client performs DELETE request on "{(basePath)}/insights/<InsightId>" 
	Then status code is 204	
	
	When the client performs DELETE request on "{(basePath)}/<ContactId>" 
	Then status code is 204
	
 	Examples:
 	| ContactId	    | InsightId	    |
 	| {(contactId)} | {(insightId)} |
 	
