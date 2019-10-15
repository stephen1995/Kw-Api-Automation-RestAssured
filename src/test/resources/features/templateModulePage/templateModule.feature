@SmokeTestFeature
Feature: Template API Testing

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    And overwrite header Authorization with value "Bearer {(token)}"

@POST @testing
    Scenario: Successful login
      Given request body from static file "tagModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      And status code is 200
  
 @GET @testing
    Scenario: Get all templates information
      When the client performs GET request on "{(basePath)}/templates"
      Then status code is 200
      And response is not empty
      
 @PATCH @testing
Scenario: Create, update, show, delete templates

   	Given request body from static file "templateModulePage/requests/createTemplate.json"
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/templates"
    Then status code is 201
    And response is not empty
    And let variable "templateID" equal to property "data.id" value
    	
    When the client performs GET request on "{(basePath)}/templates/{(templateID)}"
    Then status code is 200
    And response is not empty	
   
    Given request body from static file "templateModulePage/requests/updateTemplate.json"
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/templates/{(templateID)}"
    Then status code is 200
    And response is not empty

    When the client performs DELETE request on "{(basePath)}/templates/{(templateID)}"
    Then status code is 204

