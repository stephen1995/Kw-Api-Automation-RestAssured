@SmokeTestFeature
Feature: Notes API Testing

  Background:
    Given let variable "basePath" equal to "/v2/contacts"
    Given overwrite header Authorization with value "Bearer {(token)}"

@POST @NotesTesting
    Scenario: Successful login
      Given request body from static file "NotesModule/requests/login.json"
      And content type is "application/json"
      When the client performs POST request on "login"
      Then let variable "token" equal to property "access_token" value
      And status code is 200
  
 @GET @NotesTesting
    Scenario: Get all Phones information
      When the client performs GET request on "v2/contacts/notes"
      Then status code is 200
      And response is not empty
      And response contains "note"

      
 @Positive @NotesTesting
Scenario Outline: Create a contact and create/update/delete a note
	Given request body from static file "NotesModule/requests/CreateContact.json"
    And content type is "application/json"
    And header "X-Api-Override-Phone" with value "1"
    And header "x-Api-Override-Email" with value "1"
    And header "X-Partial-Record-Validation" with value "1"
    And header "Accept" with value "application/vnd.api+json"
    When the client performs POST request on "{(basePath)}"
    Then status code is 201
    And response is not empty
    And let variable "contactID" equal to property "data.id" value
 
 
    Given request body from file "NotesModule/requests/CreateNote.json" with values "<ContactId>"
		| %contactId% | 		
	And content type is "application/vnd.api+json"
    When the client performs POST request on "contacts/notes"
   	Then status code is 201
    And response is not empty
    And let variable "noteID" equal to property "data[0].id" value
    
    
    Given request body from static file "NotesModule/requests/UpdateNote.json" 
    And content type is "application/json"   
    When the client performs PATCH request on "contacts/notes/{(noteID)}"
   	Then status code is 200
    And response is not empty
    
    
    Given the client performs DELETE request on "contacts/notes/{(noteID)}"
    And content type is "application/json"
   	Then status code is 204

    
		
	
    Examples:
 	|ContactId	  |      noteID|
 	|{(contactID)}|  {(noteID)}  |
 
 	
 
  