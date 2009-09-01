Feature: Users via JSON
  In order manage the representation of users of the web applications,
  As a client
  I want to be able to create, read, update, and delete User objects via JSON.
  
  Scenario: Create a user
    When I PUT to '/users/bob'
    Then I should get a 201 Created response

  Scenario: Recreate a user
    Given an existing user '/users/bob'
    When I PUT to '/users/bob'
    Then I should get a 200 OK response

  Scenario: Read a user
    Given an existing user '/users/bob'
    When I GET from '/users/bob'
    Then I should get a 200 OK response

  Scenario: Get a non-existent user
    Given an existing user '/users/bob'
    When I GET '/users/not-there'
    Then I should get a 404 Not Found response
