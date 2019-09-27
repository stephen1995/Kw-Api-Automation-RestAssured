@SmokeTestFeature
Feature: API companies v2 

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
      When the client performs GET request on "{(basePath)}/companies"
      And content type is "application/json"
      Then status code is 200
      And response is not empty

 