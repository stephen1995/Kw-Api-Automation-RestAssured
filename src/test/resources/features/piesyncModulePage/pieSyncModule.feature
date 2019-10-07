@SmokeTestFeature
Feature: API PieSync Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing1
    Scenario: Successful login
      Given request body from static file "pieSyncModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
 @GET @testing1
    Scenario: Generate pieSync access information
      When the client performs POST request on "{(basePath)}/access-token/piesync"
      And content type is "application/json"
      Then status code is 200
      And response is not empty
      
 @GET @testing1
    Scenario: Get piesync connection
      When the client performs GET request on "{(basePath)}/piesync/connections"
      And content type is "application/json"
      Then status code is 200
      And response is not empty