@SmokeTestFeature
Feature: API Share Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing
    Scenario: Successful login
      Given request body from static file "contactsModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200

 @Positive @testing
Scenario Outline: Create, update and delete Batch Contact
	Given request body from static file "shareModulePage/requests/createBatchContact.json"
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/multiple-store"
    Then status code is 201
    And response is not empty
    And let variable "contactId1" equal to property "data[0].id" value
    And let variable "contactId2" equal to property "data[1].id" value
    And let variable "contactId3" equal to property "data[2].id" value
    And let variable "contactId4" equal to property "data[3].id" value
    
    Given request body from file "shareModulePage/requests/shareResource.json" with values "<ContactId1>"
		| %contactIDExtractor1% |
	And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/share"
    Then status code is 200
    And response is not empty
   
    Given request body from file "shareModulePage/requests/shareMultipleResource.json" with values "<ContactId2>,<ContactId3>,<ContactId4>"
		| %contactIDExtractor2% | %contactIDExtractor3% | %contactIDExtractor4% |
	And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/share/_bulk"
    Then status code is 200
    And response is not empty
    
    When the client performs GET request on "{(basePath)}/share/contacts/<ContactId2>" 
	Then status code is 200
    
    Given request body from file "shareModulePage/requests/deleteBatchContact.json" with values "<ContactId1>,<ContactId2>,<ContactId3>,<ContactId4>"
		| %contactIDExtractor1% | %contactIDExtractor2% | %contactIDExtractor3% | %contactIDExtractor4% |
	And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs DELETE request on "{(basePath)}"
    Then status code is 200
    And response is not empty
       Examples: 
		| ContactId1		|ContactId2 	|ContactId3 	|ContactId4 	|
		| {(contactId1)}  	|{(contactId2)}	|{(contactId3)}	|{(contactId4)}	|
    
