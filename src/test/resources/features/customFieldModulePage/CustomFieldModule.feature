@SmokeTestFeature
Feature: API custom field v2 

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing1
    Scenario: Successful login
      Given request body from static file "companiesModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
 @GET @testing1
    Scenario: Get all companies information
      When the client performs GET request on "{(basePath)}/custom-fields"
      And content type is "application/json"
      Then status code is 200
      And response is not empty

 
 @Positive @testing1
Scenario Outline: Create, update and delete custom Field
	Given request body from file "customFieldModulePage/requests/createCustomField.json" with values "<customField>"  
		|%nameCustomField%|
    And content type is "application/json"
    And header "x-api-sync" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/custom-fields"
    Then status code is 201
    And response is not empty
    And let variable "customFieldID" equal to property "data.id" value
    Given request body from static file "customFieldModulePage/requests/updateCustomfield.json"
    And content type is "application/json"
    And header "x-api-sync" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/{(customFieldID)}"
    Then status code is 200
    And response is not empty
    When the client performs GET request on "{(basePath)}/{(customFieldID)}"
	Then status code is 200
    And response is not empty
    And let variable "customFieldID" equal to property "data.id" value
    When the client performs DELETE request on "{(basePath)}/{(customFieldID)}" 
	Then status code is 204
	    Examples: 
		| customField		|
		| CustomFieldEma2  	|
