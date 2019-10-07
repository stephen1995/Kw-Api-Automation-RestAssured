@SmokeTestFeature
Feature: API Lead - lead routing Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing1
    Scenario: Successful login
      Given request body from static file "leadModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
 @Positive @testing1
Scenario Outline: Create, update, add actions and delete lead

	Given request body from static file "leadModulePage/requests/createSource.json"
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/sources"
    Then status code is 201
    And response is not empty
    And let variable "sourceId" equal to property "data.id" value
    
    Given request body from file "leadModulePage/requests/createLead.json" with values "<Email>,<SourceId>" 
    |%emailExtractor%|%idSourcesExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    And header "x-Api-Override-Email" with value "1"
    And header "x-api-sync" with value "1"
    When the client performs POST request on "lead-routing/leads"
    Then status code is 201
    And response is not empty
    And let variable "leadId" equal to property "data.id" value
    
    Given request body from file "leadModulePage/requests/updateLead.json" 
	And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "lead-routing/leads/<LeadId>"
    Then status code is 200
    And response is not empty
    
    Given request body from file "leadModulePage/requests/addAction.json" 
	And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "lead-routing/leads/<LeadId>/actions" 
	Then status code is 200
	
	When the client performs DELETE request on "lead-routing/leads/<LeadId>" 
	Then status code is 204	
	
	When the client performs DELETE request on "{(basePath)}/sources/<SourceId>" 
	Then status code is 204	
	
 	Examples:
 	|Email               | SourceId	   |LeadId    |
 	|testlead2@gmail.com |{(sourceId)} |{(leadId)}|

  	
  	
  