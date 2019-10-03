@SmokeTestFeature
Feature: Neighborhood API Testing

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    And overwrite header Authorization with value "Bearer {(token)}"

@POST @NBHTesting
    Scenario: Successful login
      Given request body from static file "emailModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      And status code is 200
  
 @GET @NBHTesting
    Scenario: Get all neighborhoods information
      When the client performs GET request on "/v1/boundaries/bounding_box?top_left[lat]=51&top_left[lon]=-132&bottom_right[lat]=24&bottom_right[lon]=-63&filter[boundary_type]=neighborhood&page[limit]=100"
      Then status code is 200
      And response is not empty

      
 @PATCH @NBHTesting
Scenario Outline: Create a contact and subscribe neighborhood
	Given request body from static file "neighborhoodModule/requests/createContact.json"
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactID" equal to property "data.id" value
    	
    Given request body from file "neighborhoodModule/requests/subscribe.json" with values "<ContactId>" 
    |%contactId%|
    And content type is "application/json"
    When the client performs PATCH request on "{(basePath)}/neighborhoods/subscribe"
    Then status code is 200
    And response is not empty
    And response contains "subscribed"
    Examples:
 	|ContactId	  |
 	|{(contactID)}|
 	
 	
  @PATCH @NBHTesting
Scenario Outline: Create a contact and Unsubscribe neighborhood
	Given request body from static file "neighborhoodModule/requests/createContact.json"
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactID" equal to property "data.id" value
    	
    Given request body from file "neighborhoodModule/requests/subscribe.json" with values "<ContactId>" 
    |%contactId%|
    And content type is "application/json"
    When the client performs PATCH request on "{(basePath)}/neighborhoods/unsubscribe"
    Then status code is 200
    And response is not empty
    And response contains "unsubscribed"
    Examples:
 	|ContactId	  |
 	|{(contactID)}|
 
 	
 
  