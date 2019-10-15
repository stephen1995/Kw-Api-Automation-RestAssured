@SmokeTestFeature
Feature: API Account v2

  Background:
    Given let variable "basePath" equal to "communications/accounts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@testing
    Scenario: Successful login
      Given request body from static file "accountModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200

@testing
Scenario: Create, update and delete Account
	Given request body from static file "accountModulePage/requests/createAccount.json"
    And content type is "application/json"
    And header "x-api-sync" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "accountID" equal to property "data.id" value
    When the client performs GET request on "{(basePath)}"
    Then status code is 200
    And response is not empty
    When the client performs DELETE request on "{(basePath)}/{(accountID)}" 
	Then status code is 204

 