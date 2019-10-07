@SmokeTestFeature
Feature: API social account Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing1
    Scenario: Successful login
      Given request body from static file "socialAccountModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
 @GET @testing1
    Scenario: Get all social account information
      When the client performs GET request on "{(basePath)}/social-accounts"
      And content type is "application/json"
      Then status code is 200
      And response is not empty

      
 @Positive @testing1
Scenario Outline: Create, update and delete social account
	Given request body from static file "socialAccountModulePage/requests/createContact.json"
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactId" equal to property "data.id" value
    	
    Given request body from file "socialAccountModulePage/requests/createSocialAccount.json" with values "<ContactId>" 
    |%idContactExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/social-accounts"
    Then status code is 201
    And response is not empty
    And let variable "socialAccountId" equal to property "data.id" value
    
    Given request body from file "socialAccountModulePage/requests/updateSocialAccount.json" with values "<ContactId>" 
    | %idContactExtractor% |
    And content type is "application/json"
    And header "X-API-FORCED" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/social-accounts/{(socialAccountId)}"
    Then status code is 200
    And response is not empty
    And let variable "addressID" equal to property "data.id" value
    
    When the client performs GET request on "{(basePath)}/social-accounts/{(socialAccountId)}" 
	Then status code is 200
    
    When the client performs DELETE request on "{(basePath)}/social-accounts/{(socialAccountId)}" 
	Then status code is 204

	When the client performs DELETE request on "{(basePath)}/<ContactId>" 
	Then status code is 204

 	Examples:
 	| ContactId	    | 
 	| {(contactId)} | 