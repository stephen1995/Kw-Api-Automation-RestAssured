@SmokeTestFeature
Feature: API Email Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing
    Scenario: Successful login
      Given request body from static file "emailModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
 @GET @testing1
    Scenario: Get all emails information
      When the client performs GET request on "{(basePath)}/emails"
      And content type is "application/json"
      Then status code is 200
      And response is not empty

      
 @Positive @testing1
Scenario Outline: Create, update, list and delete emails
	Given request body from static file "emailModulePage/requests/createContact.json"
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactId" equal to property "data.id" value
    	
    Given request body from file "emailModulePage/requests/createEmail.json" with values "<Email1>,<ContactId>" 
    |%email1%|%idContactExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/emails"
    Then status code is 201
    And response is not empty
    And let variable "emailId" equal to property "data.id" value
    
    Given request body from file "emailModulePage/requests/updateEmail.json" with values "<Email2>,<ContactId>" 
    |%email2%|%idContactExtractor%|
    And content type is "application/json"
    And header "X-API-FORCED" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/emails/<EmailId>"
    Then status code is 200
    And response is not empty
    
    When the client performs GET request on "{(basePath)}/emails/<EmailId>" 
	Then status code is 200
	
	When the client performs DELETE request on "{(basePath)}/emails/<EmailId>" 
	Then status code is 204	
	
	When the client performs DELETE request on "{(basePath)}/<ContactId>" 
	Then status code is 204

 	Examples:
 	| ContactId	    | EmailId	  | Email1  			| Email2			 |
 	| {(contactId)} | {(emailId)} | ema1test@gmail.com	| ema2test@gmail.com |
 	
 
  @Positive @testing
Scenario Outline: multi delete emails
	Given request body from static file "emailModulePage/requests/createContact.json"
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactId" equal to property "data.id" value
    
    Given request body from file "emailModulePage/requests/createOverrideEmail.json" with values "{(contactId)}" 
    |%idContactExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    And header "x-Api-Override-Email" with value "1"
    When the client performs POST request on "{(basePath)}/emails"
    Then status code is 201
    And response is not empty
    And let variable "emailId1" equal to property "data.id" value
    
    Given request body from file "emailModulePage/requests/createOverrideEmail.json" with values "{(contactId)}" 
    |%idContactExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    And header "x-Api-Override-Email" with value "1"
    When the client performs POST request on "{(basePath)}/emails"
    Then status code is 201
    And response is not empty
    And let variable "emailId2" equal to property "data.id" value
    
    Given request body from file "emailModulePage/requests/createOverrideEmail.json" with values "{(contactId)}" 
    |%idContactExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    And header "x-Api-Override-Email" with value "1"
    When the client performs POST request on "{(basePath)}/emails"
    Then status code is 201
    And response is not empty
    And let variable "emailId3" equal to property "data.id" value
    
    Given request body from file "emailModulePage/requests/multiDeleteEmail.json" with values "<Email1>,<Email2>,<Email3>" 
    |%emails1%|%emails2%|%emails3%|
    And content type is "application/json"
    And header "X-API-FORCED" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs DELETE request on "{(basePath)}/emails"
    Then status code is 200
    And response is not empty
    
    Examples:
 	| Email1	   | Email2	  	  | Email3  		|
 	| {(emailId1)} | {(emailId2)} | {(emailId3)}	|