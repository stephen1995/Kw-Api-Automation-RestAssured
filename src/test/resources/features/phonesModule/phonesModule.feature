@SmokeTestFeature
Feature: Phones API Testing

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing
    Scenario: Successful login
      Given request body from static file "phonesModule/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      And status code is 200
  
 @GET @testing
    Scenario: Get all Phones information
      When the client performs GET request on "{(basePath)}/phones"
      Then status code is 200
      And response is not empty

      
 @Positive @testing
Scenario Outline: Create multiple contacts then delete their phones
	Given request body from static file "phonesModule/requests/CreateBatchContact.json"
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
#    And response contains "is_deleted"
    And response contains "true"
 
    When the client performs GET request on "{(basePath)}/{(contactId1)}/?include=phones"   
    Then status code is 200
    And response is not empty
    And let variable "phoneId1" equal to property "data.relationships.phones.data[0].id" value
    
    When the client performs GET request on "{(basePath)}/{(contactId2)}/?include=phones"   
    Then status code is 200
    And response is not empty
    And let variable "phoneId2" equal to property "data.relationships.phones.data[0].id" value
    
    
    Given request body from file "phonesModule/requests/DeleteMultiplePhones.json" with values "<PhoneId1>,<PhoneId2>"
		| %phoneID1% | %phoneID2% |
		And content type is "application/json"
    And header "X-API-PERMANENT-DELETE" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs Delete request on "{(basePath)}/phones"
    Then status code is 200
    And response is not empty
    And response contains "true"

    Examples: 
		| PhoneId1		|PhoneId2 	|
		| {(phoneId1)}  |{(phoneId2)}	|
 	
 	
  @PATCH @testing
Scenario Outline: Create a contact and add/update/delete phone
	Given request body from static file "phonesModule/requests/CreateContact.json"
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactID" equal to property "data.id" value
    	    
    Given request body from static file "phonesModule/requests/AddPhone.json"
    And content type is "application/json"
    When the client performs PATCH request on "{(basePath)}/{(contactID)}"
    Then status code is 200
    And response is not empty
    
    Given request body from static file "phonesModule/requests/UpdatePhone.json"
    And content type is "application/json"
    When the client performs PATCH request on "{(basePath)}/{(contactID)}"
    Then status code is 200
    And response is not empty
    
    
    When the client performs GET request on "{(basePath)}/{(contactID)}/?include=phones"   
    Then status code is 200
    And response is not empty
    And let variable "phoneId1" equal to property "data.relationships.phones.data[0].id" value
       
    
    Given request body from file "phonesModule\requests\DeletePhone.json" with values "<PhoneId1>"
		| %phoneID1% |
		And content type is "application/json"
    And header "X-API-PERMANENT-DELETE" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs Delete request on "{(basePath)}/phones"
    Then status code is 200
    And response is not empty
    And response contains "is_deleted"
    
    Examples:
 	|ContactId	  |PhoneId1|
 	|{(contactID)}| {(phoneId1)}|
 
 	
 
  