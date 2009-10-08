Feature: Users via HTML
  In order manage the representation of users of the web applications,
  As an admin
  I want to be able to create, read, update, and delete User objects via HTML.
  
  Background:
    Given I have a user with attributes id "1" and permalink "joe"
    And I have a user with attributes id "2" and permalink "steve"
  
  Scenario: Get a list of users
    Given I am on the users page
    Then I should see "steve"
    And I should see "joe"
  
  Scenario: Get a list of users when there are none
    Given there are no users
    When I am on the users page
    Then I should see "There are no users"
  
  Scenario: Create a user
    Given I am on the new user page
    When I fill in "Permalink" with "bob"
    And I press "Create User"
    Then I should be on the "bob" user page
    And I should see "bob"
  
  Scenario: Attempt to Create a user with a blank permalink
    Given I am on the new user page
    When I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink can't be blank"
  
  # Scenario: Attempt to Create a user with a period in the permalink
  # Scenario: Attempt to Create a user with a backslash in the permalink
  # Scenario: Attempt to Create a user with a period and a slash
  # Scenario: Attempt to Create a user with "index" as the permalink
  # Scenario: Attempt to Create a user with "new" as the permalink
  # Scenario: Attempt to Create a user with "create" as the permalink
  # Scenario: Attempt to Create a user with "show" as the permalink
  # Scenario: Attempt to Create a user with "edit" as the permalink
  # Scenario: Attempt to Create a user with "update" as the permalink
  # Scenario: Get a non-existent user
  # Scenario: Update a user's permalink
  # Scenario: Attempt to Update a user with a period
  # Scenario: Attempt to Update a user with a slash
  # Scenario: Attempt to Update a user with a period and a slash
  # Scenario: Attempt to Update a user with "index" as the permalink
  # Scenario: Attempt to Update a user with "new" as the permalink
  # Scenario: Attempt to Update a user with "create" as the permalink
  # Scenario: Attempt to Update a user with "show" as the permalink
  # Scenario: Attempt to Update a user with "edit" as the permalink
  # Scenario: Attempt to Update a user with "update" as the permalink
  
  Scenario: Attempt to Create a user that already exists
    Given I am on the new user page
    When I fill in "Permalink" with "joe"
    And I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink has already been taken"
  
  Scenario: View a user
    Given I am on the "joe" user page
    Then I should see "joe"
    And I should not see "steve"
  
  # Scenario: Get a user's adjustments
  # Scenario: Get a non-existing user's adjustments
  # Scenario: Get a user's karma
  # Scenario: Get a non-existing user's karma
  
  Scenario: Edit a user
    Given I am on the edit "joe" user page
    When I fill in "Permalink" with "shmoe"
    And I press "Update User"
    Then I should be on the "shmoe" user page
    And I should see "User was successfully updated."
  
  # Scenario: Attempt to Destroy a non-existent user
  
  Scenario: Destroy a user
    Given I am on the users page
    When I follow "Destroy joe User"
    Then I should be on the users page
    And I should see "User was successfully destroyed."
    And I should not see "joe"
  