Feature: Users via JSON
  In order manage the representation of users of the web applications,
  As a client
  I want to be able to create, read, update, and delete User objects via JSON.
  
  Scenario: Create a user
    When I POST '{token: bob}' to '/users'
    Then I should get a 301 Created response
    And I should get redirected
  
  