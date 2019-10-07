@SmokeTestFeature
Feature: API Interaction Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing1
    Scenario: Successful login
      Given request body from static file "interactionModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
 @GET @testing1
    Scenario: Get all interaction information
      When the client performs GET request on "{(basePath)}/interactions"
      And content type is "application/json"
      Then status code is 200
      And response is not empty
      
 @Positive @testing1
Scenario Outline: Create, update, list and delete interaction

	Given request body from static file "interactionModulePage/requests/createContact.json"
    And content type is "application/json"
    And header "x-api-sync" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactId" equal to property "data.id" value
    
    Given request body from file "interactionModulePage/requests/createInteraction.json" with values "<InteractionType>,<ContactId>" 
    |%idInteractionType%|%idContactExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/interactions"
    Then status code is 201
    And response is not empty
    And let variable "interactionId" equal to property "data.id" value
    
    Given request body from file "interactionModulePage/requests/updateInteraction.json" with values "<InteractionType>,<ContactId>" 
    |%idInteractionType%|%idContactExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/interactions/<InteractionId>"
    Then status code is 200
    And response is not empty
    
    When the client performs GET request on "{(basePath)}/interactions/<InteractionId>" 
	Then status code is 200
	
	When the client performs DELETE request on "{(basePath)}/interactions/<InteractionId>" 
	Then status code is 204	
	
	When the client performs DELETE request on "{(basePath)}/<ContactId>" 
	Then status code is 204
	
 	Examples:
 	|InteractionType | ContactId	  | InteractionId	 |
 	|2               | {(contactId)}  |{(interactionId)} |
  	|16              | {(contactId)}  |{(interactionId)} |
  	|17              | {(contactId)}  |{(interactionId)} |
  	|19              | {(contactId)}  |{(interactionId)} |
  	|20              | {(contactId)}  |{(interactionId)} |
  	|21              | {(contactId)}  |{(interactionId)} | 	 		

  	
  	
  	
  	@Positive @testing1
Scenario Outline: Delete multiple interaction

	Given request body from static file "interactionModulePage/requests/createContact.json"
    And content type is "application/json"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactId" equal to property "data.id" value
    
    Given request body from file "interactionModulePage/requests/createInteraction.json" with values "<InteractionType>,<ContactId>" 
    |%idInteractionType%|%idContactExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/interactions"
    Then status code is 201
    And response is not empty
    And let variable "interactionId1" equal to property "data.id" value
    
    Given request body from file "interactionModulePage/requests/createInteraction.json" with values "<InteractionType>,<ContactId>" 
    |%idInteractionType%|%idContactExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/interactions"
    Then status code is 201
    And response is not empty
    And let variable "interactionId2" equal to property "data.id" value
    
    Given request body from file "interactionModulePage/requests/createInteraction.json" with values "<InteractionType>,<ContactId>" 
    |%idInteractionType%|%idContactExtractor%|
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/interactions"
    Then status code is 201
    And response is not empty
    And let variable "interactionId3" equal to property "data.id" value
    
	Given request body from file "interactionModulePage/requests/multiDeleteInteraction.json" with values "<InteractionId1>,<InteractionId2>,<InteractionId3>"
	|%idInteractionExtractor1%|%idInteractionExtractor2%|%idInteractionExtractor3%|
	And content type is "application/json"
	And header "Accept" with value "application/vnd.api+json"
	When the client performs DELETE request on "{(basePath)}/interactions" 
	Then status code is 204	
	
	When the client performs DELETE request on "{(basePath)}/<ContactId>" 
	Then status code is 204
	
 	Examples:
 	|InteractionType | ContactId	 | InteractionId1	 | InteractionId2	| InteractionId3   |
 	|2               | {(contactId)} |{(interactionId1)} |{(interactionId2)}|{(interactionId3)}|
	
  	