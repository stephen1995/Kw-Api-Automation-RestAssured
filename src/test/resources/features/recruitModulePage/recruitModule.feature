@SmokeTestFeature
Feature: Tag API Testing

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    And overwrite header Authorization with value "Bearer {(token)}"

@POST @testing
    Scenario: Successful login
      Given request body from static file "recruitModulePage/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      And status code is 200
  
 @GET @testing
    Scenario: Get all recruits information
          Given content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    And header "x-kwcommand-group-members" with value "556396;556397;556398"
    And header "x-consumer-username" with value "mcGateway"
    And header "x-consumer-token-user-email" with value "name=kelle1 kelle1;email=kelle1@kw.com"
    And header "x-consumer-token-user-id" with value "556396"
    And header "x-consumer-aid" with value "mcGateway"
    And header "x-kwcommand-group" with value "mc=2683"
    When the client performs GET request on "{(basePath)}/pipeline/recruits"
    Then status code is 200
     And response is not empty
      
 @PATCH @testing
Scenario Outline: Create, update, show, delete, recruits
	Given request body from static file "recruitModulePage/requests/createRecruit.json"
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    And header "x-kwcommand-group-members" with value "556396;556397;556398"
    And header "x-consumer-username" with value "mcGateway"
    And header "x-consumer-token-user-email" with value "name=kelle1 kelle1;email=kelle1@kw.com"
    And header "x-consumer-token-user-id" with value "556396"
    And header "x-consumer-aid" with value "mcGateway"
    And header "x-kwcommand-group" with value "mc=2683"
    
    When the client performs POST request on "{(basePath)}/pipeline/recruits"
    Then status code is 201
    And response is not empty
    And let variable "recruitID" equal to property "data.id" value
    	
    When the client performs GET request on "{(basePath)}/pipeline/recruits/<RecruitId>"
    Then status code is 200
    And response is not empty	
    
    When the client performs GET request on "{(basePath)}/pipeline/stats"
    Then status code is 200
    And response is not empty	
    
    When the client performs GET request on "{(basePath)}/pipeline/recruits/<RecruitId>/join-kw"
    Then status code is 200
    And response is not empty

    When the client performs GET request on "{(basePath)}/pipeline/recruits/appointments/stats"
    Then status code is 200
    And response is not empty	

    Given request body from static file "recruitModulePage/requests/updateRecruit.json"
    And content type is "application/json"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs PATCH request on "{(basePath)}/pipeline/recruits/<RecruitId>"
    Then status code is 200
    And response is not empty

    When the client performs DELETE request on "{(basePath)}/pipeline/recruits/<RecruitId>"
    Then status code is 204

    Examples:
 	|RecruitId	  |
 	|{(recruitID)}|
 	
