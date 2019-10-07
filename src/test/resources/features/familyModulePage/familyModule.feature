@SmokeTestFeature
Feature: API Family Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing1
    Scenario: Successful login
      Given request body from static file "emailModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
 @GET @testing1
    Scenario: Get all family information
      When the client performs GET request on "{(basePath)}/family"
      And content type is "application/json"
      Then status code is 200
      And response is not empty
      
 @Positive @testing1
Scenario Outline: Create, update, list and delete family
	Given request body from static file "familyModulePage/requests/createContact.json"
    And content type is "application/json"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactId1" equal to property "data.id" value
    
    Given request body from static file "familyModulePage/requests/createContact.json"
    And content type is "application/json"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactId2" equal to property "data.id" value
    	
    Given request body from file "familyModulePage/requests/createFamily.json" with values "<ContactId1>,<ContactId2>" 
    |%idContactExtractor1%|%idContactExtractor2%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/family"
    Then status code is 201
    And response is not empty
    And let variable "familyId" equal to property "data.id" value
    
    Given request body from file "familyModulePage/requests/updateFamily.json" with values "<ContactId1>,<ContactId2>" 
    |%idContactExtractor1%|%idContactExtractor2%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/family/<FamilyId>"
    Then status code is 200
    And response is not empty
    
    When the client performs GET request on "{(basePath)}/family/<FamilyId>" 
	Then status code is 200
	
	When the client performs DELETE request on "{(basePath)}/family/<FamilyId>" 
	Then status code is 204	
	
	When the client performs DELETE request on "{(basePath)}/<ContactId1>" 
	Then status code is 204

	When the client performs DELETE request on "{(basePath)}/<ContactId2>" 
	Then status code is 204
	
 	Examples:
 	| ContactId1	 |ContactId2     | FamilyId	    |
 	| {(contactId1)} |{(contactId2)} | {(familyId)} |
 	
