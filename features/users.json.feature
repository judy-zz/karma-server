Feature: Users via JSON
  In order manage the representation of users of the web applications,
  As a client
  I want to be able to create, read, update, and delete User objects via JSON.
  
  Scenario: Create a user
    When I POST '{"user": {"token": "bob"}}' to '/users'
    Then I should get a 201 Created response
    And the Location header should be 'http://localhost:3000/users/bob'

  