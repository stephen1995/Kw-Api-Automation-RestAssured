@SmokeTestFeature
Feature: API System Metas Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing1
    Scenario: Successful login
      Given request body from static file "sourceModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
 @GET @testing1
    Scenario: Get all source information
      When the client performs GET request on "{(basePath)}/system-metas"
      And content type is "application/json"
      Then status code is 200
      And response is not empty
      
 @Positive @testing1
Scenario: Create, update, list and delete source

    Given request body from static file "systemMetasModulePage/requests/createSystemMetas.json" 
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/system-metas"
    Then status code is 201
    And response is not empty
    And let variable "systemMetaId" equal to property "data.id" value
    
    Given request body from static file "systemMetasModulePage/requests/updateSystemMetas.json" 
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/system-metas/{(systemMetaId)}"
    Then status code is 200
    And response is not empty
    
    When the client performs GET request on "{(basePath)}/system-metas/{(systemMetaId)}" 
	Then status code is 200
	
	When the client performs DELETE request on "{(basePath)}/system-metas/{(systemMetaId)}" 
	Then status code is 204	
 	
  