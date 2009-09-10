Feature: Users via HTML
  In order manage the representation of users of the web applications,
  As an admin
  I want to be able to create, read, update, and delete User objects via HTML.
  
  Scenario: Create a user
    Given I am on the new user page
    When I fill in "Permalink" with "bob"
    And I press "Create User"
    Then I should see "bob"

  Scenario: Attempt to create a user without a permalink
    Given I am on the new user page
    When I press "Create User"
    Then I should see an error explanation
    And I should see "Permalink can't be blank"