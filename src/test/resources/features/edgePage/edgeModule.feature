@SmokeTestFeature
Feature: API Edge v2

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing1
    Scenario: Successful login
      Given request body from static file "edgePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200

@POST @testing1
    Scenario: Connection Edge
      Given request body from static file "edgePage/requests/connectEdge.json"
      And content type is "application/json"
      When the client performs POST request on "{(basePath)}/connect/eedge"
      Then status code is 200

@POST @testing1
    Scenario: Status Edge
      Given request body from static file "edgePage/requests/statusEdge.json"
      And content type is "application/json"
      When the client performs POST request on "{(basePath)}/status/eedge"
      Then status code is 200 
      
@POST @testing1
    Scenario: Status Edge
      Given request body from static file "edgePage/requests/disconnectEdge.json"
      And content type is "application/json"
      When the client performs POST request on "{(basePath)}/disconnect/eedge"
      Then status code is 200 