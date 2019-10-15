@SmokeTestFeature
Feature: Tag API Testing

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
    Scenario: Get all tags information
      When the client performs GET request on "{(basePath)}/tags"
      Then status code is 200
      And response is not empty
      
 @PATCH @testing
Scenario Outline: Create, update, show, delete, attach, set, detach tag
	Given request body from static file "tagModulePage/requests/createContact.json"
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactID" equal to property "data.id" value
    	
   	Given request body from static file "tagModulePage/requests/createTag.json"
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/tags"
    Then status code is 201
    And response is not empty
    And let variable "tagID" equal to property "data.id" value
    	
    When the client performs GET request on "{(basePath)}/tags/<TagId>"
    Then status code is 200
    And response is not empty	
    	
    Given request body from file "tagModulePage/requests/setTag.json" with values "<ContactId>,<TagId>" 
    |%idContactExtractor%|%idTagExtractor%|
    And content type is "application/json"
    When the client performs POST request on "{(basePath)}/tags/set"
    Then status code is 200
    And response is not empty
    
    Given request body from file "tagModulePage/requests/detachTag.json" with values "<ContactId>,<TagId>" 
    |%idContactExtractor%|%idTagExtractor%|
    And content type is "application/json"
    When the client performs POST request on "{(basePath)}/tags/detach"
    Then status code is 200
    And response is not empty
    
    Given request body from file "tagModulePage/requests/attachTag.json" with values "<ContactId>,<TagId>" 
    |%idContactExtractor%|%idTagExtractor%|
    And content type is "application/json"
    When the client performs POST request on "{(basePath)}/tags/attach"
    Then status code is 200
    And response is not empty
    
    Given request body from static file "tagModulePage/requests/updateTag.json"
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/tags/<TagId>"
    Then status code is 200
    And response is not empty

    When the client performs DELETE request on "{(basePath)}/<ContactId>"
    Then status code is 204

    When the client performs DELETE request on "{(basePath)}/tags/<TagId>"
    Then status code is 204

    Examples:
 	|ContactId	  |  TagId   |
 	|{(contactID)}|{(tagID)} |
 	
@PATCH @testing
Scenario Outline: Delete multi tag
    	
   	Given request body from static file "tagModulePage/requests/createTag.json"
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/tags"
    Then status code is 201
    And response is not empty
    And let variable "tagID1" equal to property "data.id" value

   	Given request body from static file "tagModulePage/requests/createTag.json"
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/tags"
    Then status code is 201
    And response is not empty
    And let variable "tagID2" equal to property "data.id" value
    	
    Given request body from static file "tagModulePage/requests/createTag.json"
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}/tags"
    Then status code is 201
    And response is not empty
    And let variable "tagID3" equal to property "data.id" value
    
    Given request body from file "tagModulePage/requests/deleteMultiTag.json" with values "<TagId1>,<TagId2>,<TagId3>" 
    |%idContactExtractor1%|%idContactExtractor2%|%idContactExtractor3%|
    And content type is "application/json"
    When the client DELETE request on "{(basePath)}/tags"
    Then status code is 200
    And response is not empty
        
    Examples:
 	|TagId1	   |TagId2	   |TagId3	   |
 	|{(tagID1)}|{(tagID2)} |{(tagID3)} |
 
 	
 
  