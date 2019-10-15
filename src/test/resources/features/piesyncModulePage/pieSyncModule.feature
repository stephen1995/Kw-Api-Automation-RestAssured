@SmokeTestFeature
Feature: API PieSync Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing
    Scenario: Successful login
      Given request body from static file "pieSyncModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
 @GET @testing
    Scenario: Generate pieSync access information
      When the client performs POST request on "{(basePath)}/access-token/piesync"
      And content type is "application/json"
      Then status code is 200
      And response is not empty
      
 @GET @testing
    Scenario: Get piesync connection
      When the client performs GET request on "{(basePath)}/piesync/connections"
      And content type is "application/json"
      Then status code is 200
      And response is not empty
      
@POST @testing
    Scenario: Resume connection 
      Given request body from static file "pieSyncModulePage/requests/pieSyncStatus.json"
      And content type is "application/json"
      When the client performs POST request on "{(basePath)}/piesync/connections/resume"
      Then status code is 200
      
 @POST @testing
    Scenario: Pause connection 
      Given request body from static file "pieSyncModulePage/requests/pieSyncStatus.json"
      And content type is "application/json"
      When the client performs POST request on "{(basePath)}/piesync/connections/pause"
      Then status code is 200
      
 @POST @testing
    Scenario: Delete connection 
      Given request body from static file "pieSyncModulePage/requests/pieSyncStatus.json"
      And content type is "application/json"
      When the client performs DELETE request on "{(basePath)}/piesync/connections"
      Then status code is 200
      
 @POST @testing
    Scenario: Delete connection 
      Given request body from static file "pieSyncModulePage/requests/pieSyncStatus.json"
      And content type is "application/json"
      When the client performs POST request on "{(basePath)}/piesync/connections/sync"
      Then status code is 200