Feature: Users via JSON
  In order manage the representation of users of the web applications,
  As a client
  I want to be able to create, read, update, and delete User objects via JSON.
  
  Scenario: Create a user
    When I PUT to '/users/bob.json' with body ''
    Then I should get a 201 Created response

  Scenario: Recreate a user
    Given I have a user with permalink "bob"
    When I PUT to '/users/bob.json' with body ''
    Then I should get a 200 OK response

  Scenario: Read a user
    Given I have a user with permalink "bob"
    When I GET from '/users/bob.json'
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        user: {
          permalink: bob, 
          positive_points: 12, 
          negative_points: 3, 
          total_points: 36
        }
      }
    """

  Scenario: Get a non-existent user
    Given I have a user with permalink "bob"
    When I GET from '/users/not-there.json'
    Then I should get a 404 Not Found response
