@SmokeTestFeature
Feature: API Timeline Page

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @testing
    Scenario: Successful login
      Given request body from static file "timelineModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      Then status code is 200
  
 @Positive @testing
Scenario: Get timelines

	Given request body from static file "timelineModulePage/requests/createContact.json"
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactId" equal to property "data.id" value
    
	When the client performs GET request on "{(basePath)}/{(contactId)}/timeline?filter[timeline_type][is]=4" 
	Then status code is 200
	
	When the client performs GET request on "{(basePath)}/{(contactId)}/timeline?filter[timeline_type][is]=9" 
	Then status code is 200
	
	When the client performs GET request on "{(basePath)}/{(contactId)}/timeline?filter[timeline_type][is]=13" 
	Then status code is 200
	
	When the client performs GET request on "{(basePath)}/{(contactId)}/timeline?filter[timeline_type][is]=1" 
	Then status code is 200

	When the client performs GET request on "{(basePath)}/{(contactId)}/timeline?filter[timeline_type][is]=8" 
	Then status code is 200
	
	When the client performs GET request on "{(basePath)}/{(contactId)}/timeline?filter[timeline_type][is]=5" 
	Then status code is 200
	
	When the client performs GET request on "{(basePath)}/{(contactId)}/timeline?filter[timeline_type][is]=14" 
	Then status code is 200
		
	When the client performs DELETE request on "{(basePath)}/{(contactId)}" 
	Then status code is 204	


  	
  	
  