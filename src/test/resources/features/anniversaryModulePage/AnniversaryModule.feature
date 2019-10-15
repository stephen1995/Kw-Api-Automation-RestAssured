@SmokeTestFeature
Feature: API Anniversary Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@testing
    Scenario: Successful login
      Given request body from static file "anniversaryModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
@testing
    Scenario: Get all anniversary information
      When the client performs GET request on "{(basePath)}/anniversaries"
      And content type is "application/json"
      Then status code is 200
      And response is not empty

      
@testing
Scenario Outline: Create, update and delete Anniversary
	Given request body from static file "anniversaryModulePage/requests/createContact.json"
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactId" equal to property "data.id" value
    	
    Given request body from file "anniversaryModulePage/requests/createAddress.json" with values "<ContactId>" 
    |%contactID%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/addresses"
    Then status code is 201
    And response is not empty
    And let variable "addressId" equal to property "data.id" value
    
    Given request body from file "anniversaryModulePage/requests/createAnniversary.json" with values "<ContactId>,<AddressId>" 
     | %contactID% | %addressID% |
    And content type is "application/json"
    And header "X-API-FORCED" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/anniversaries"
    Then status code is 201
    And response is not empty
    And let variable "anniversaryId" equal to property "data.id" value
    
    Given request body from file "anniversaryModulePage/requests/updateAnniversary.json" with values "<ContactId>,<AddressId>" 
    | %contactID% | %addressID% |
    And content type is "application/json"
    And header "X-API-FORCED" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/anniversaries/{(anniversaryId)}"
    Then status code is 200
    And response is not empty
    And let variable "addressID" equal to property "data.id" value
    
    When the client performs GET request on "{(basePath)}/anniversaries/{(anniversaryId)}" 
	Then status code is 200
    
    When the client performs DELETE request on "{(basePath)}/anniversaries/{(anniversaryId)}" 
	Then status code is 204
	
	When the client performs DELETE request on "{(basePath)}/addresses/<AddressId>" 
	Then status code is 204	
	
	When the client performs DELETE request on "{(basePath)}/<ContactId>" 
	Then status code is 204

 	Examples:
 	| ContactId	    | AddressId	    |
 	| {(contactId)} | {(addressId)} |