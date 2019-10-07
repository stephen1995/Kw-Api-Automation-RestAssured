@SmokeTestFeature
Feature: API Source Page

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
      When the client performs GET request on "{(basePath)}/sources"
      And content type is "application/json"
      Then status code is 200
      And response is not empty
      
 @Positive @testing1
Scenario: Create, update, list and delete source

    Given request body from static file "sourceModulePage/requests/createSource.json" 
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/sources"
    Then status code is 201
    And response is not empty
    And let variable "sourceId" equal to property "data.id" value
    
    Given request body from static file "sourceModulePage/requests/updateSource.json" 
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/sources/{(sourceId)}"
    Then status code is 200
    And response is not empty
    
    When the client performs GET request on "{(basePath)}/sources/{(sourceId)}" 
	Then status code is 200
	
	When the client performs DELETE request on "{(basePath)}/sources/{(sourceId)}" 
	Then status code is 204	
 	
  	@Positive @testing1
Scenario Outline: List and Delete multiple source

    Given request body from static file "sourceModulePage/requests/createSource.json" 
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/sources"
    Then status code is 201
    And response is not empty
    And let variable "sourceId1" equal to property "data.id" value
    
    Given request body from static file "sourceModulePage/requests/createSource.json" 
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/sources"
    Then status code is 201
    And response is not empty
    And let variable "sourceId2" equal to property "data.id" value
    
    Given request body from static file "sourceModulePage/requests/createSource.json" 
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/sources"
    Then status code is 201
    And response is not empty
    And let variable "sourceId3" equal to property "data.id" value
    
    Given request body from file "sourceModulePage/requests/listMultiSource.json" with values "<SourceId1>,<SourceId2>,<SourceId3>" 
    |"%idSourcesExtractor1%"|"%idSourcesExtractor2%"|"%idSourcesExtractor3%"|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    And header "x-api-sync" with value "1"
    When the client performs POST request on "{(basePath)}/sources/lists"
    Then status code is 200
    And response is not empty
    
	Given request body from file "sourceModulePage/requests/multiDeleteSource.json" with values "<SourceId1>,<SourceId2>,<SourceId3>"
	|"%idSourcesExtractor1%"|"%idSourcesExtractor2%"|"%idSourcesExtractor3%"|
	And content type is "application/json"
	And header "Accept" with value "application/vnd.api+json"
	When the client performs DELETE request on "{(basePath)}/sources" 
	Then status code is 200	
	
 	Examples:
 	| SourceId1	    | SourceId2	   | SourceId3   |
 	| {(sourceId1)} |{(sourceId2)} |{(sourceId3)}|
	
  	