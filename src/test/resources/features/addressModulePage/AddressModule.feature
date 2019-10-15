@SmokeTestFeature
Feature: API Address Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@testing
    Scenario: Successful login
      Given request body from static file "addressModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
@testing
    Scenario: Get all address information
      When the client performs GET request on "{(basePath)}/addresses"
      And content type is "application/json"
      Then status code is 200
      And response is not empty
      
@testing
    Scenario: Search address by bounding information
      When the client performs GET request on "{(basePath)}/?filter[coordinates][is]=49.7232725556,21.8305051327/49.7232725556,24.7232568264/50.5752657049,24.7232568264/50.5752657049,21.8305051327/49.7232725556,21.8305051327"
      And content type is "application/json"
      Then status code is 200
      And response is not empty

@testing
    Scenario: Search address by radius information
      When the client performs GET request on "{(basePath)}/?filter[radius][is]=2000/49.814616,23.961182"
      And content type is "application/json"
      Then status code is 200
      And response is not empty
      
@testing
    Scenario: Search get geocode
      When the client performs GET request on "{(basePath)}/addresses/geocode"
      And content type is "application/json"
      Then status code is 200
      And response is not empty

@testing
Scenario Outline: Create, update, show and delete Address
	Given request body from static file "addressModulePage/requests/createContact.json"
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactID" equal to property "data.id" value
    	
    Given request body from file "addressModulePage/requests/createAddress.json" with values "<ContactId>" 
    |%contactId%|
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/addresses"
    Then status code is 201
    And response is not empty
    And let variable "addressId" equal to property "data.id" value
    
    Given request body from file "addressModulePage/requests/updateAddress.json" with values "<contactId>" 
    |%contactId%|
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/addresses/{(addressId)}"
    Then status code is 200
    And response is not empty
    And let variable "addressId" equal to property "data.id" value
    
    When the client performs GET request on "{(basePath)}/addresses/{(addressId)}" 
	Then status code is 200
    
    When the client performs DELETE request on "{(basePath)}/addresses/{(addressId)}" 
	Then status code is 204
	
	    When the client performs DELETE request on "{(basePath)}/<ContactId>" 
	Then status code is 204

 	Examples:
 	|ContactId	  |
 	|{(contactID)}|