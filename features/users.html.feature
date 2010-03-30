Feature: Users via HTML
  In order manage the representation of users of the web applications,
  As an admin
  I want to be able to create, read, update, and delete User objects via HTML.
  
  Background:
    Given a typical set of adjustments, tags, and users
    And an admin "jimjim" with password "jimjim"
    And I log in as "jimjim" with password "jimjim"
  
  Scenario: Get a list of users
    Given I am on the users page
    Then I should see "bob"
    And I should see "harry"
  
  Scenario: Get a list of users when there are none
    Given there are no users
    When I am on the users page
    Then I should see "There are no users"
  
  # TODO: Fix features which use the "should be on the '' user page" step
  Scenario: Create a user
    Given I am on the new user page
    When I fill in "Permalink" with "steve"
    And I press "Create User"
    # Then I should be on the "steve" user page
    And I should see "steve"
  
  Scenario: Attempt to Create a user with a blank permalink
    Given I am on the new user page
    When I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink can't be blank"
  
  Scenario: Attempt to Create a user with a period in the permalink
    Given I am on the new user page
    When I fill in "Permalink" with "joe.smith"
    And I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink can't have a period"
  
  Scenario: Attempt to Create a user with a backslash in the permalink
    Given I am on the new user page
    When I fill in "Permalink" with "joe/smith"
    And I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink can't have a slash"
  
  Scenario: Attempt to Create a user with a period and a slash
    Given I am on the new user page
    When I fill in "Permalink" with "joe/smi.th"
    And I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink can't have a slash"
    And I should see "Permalink can't have a period"
  
  Scenario: Attempt to Create a user with "index" as the permalink
    Given I am on the new user page
    When I fill in "Permalink" with "index"
    And I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Create a user with "new" as the permalink
    Given I am on the new user page
    When I fill in "Permalink" with "new"
    And I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Create a user with "create" as the permalink
    Given I am on the new user page
    When I fill in "Permalink" with "create"
    And I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Create a user with "edit" as the permalink
    Given I am on the new user page
    When I fill in "Permalink" with "edit"
    And I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Create a user with "update" as the permalink
    Given I am on the new user page
    When I fill in "Permalink" with "update"
    And I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Create a user with "show" as the permalink
    Given I am on the new user page
    When I fill in "Permalink" with "show"
    And I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Create a user that already exists
    Given I am on the new user page
    When I fill in "Permalink" with "bob"
    And I press "Create User"
    Then I should see "New User"
    And I should see an error message
    And I should see "Permalink has already been taken"
  
  Scenario: View a user
    When I am on the "bob" user page
    Then I should see "bob"
    And I should not see "harry"
    And I should see "animals" in "tr[id=animals] > th"
    And I should see "2" in "tr[id=animals] > td"
    And I should see "plants" in "tr[id=plants] > th"
    And I should see "1" in "tr[id=plants] > td"
    And I should see "Total:" in "tr[id=total] > th"
    And I should see "3" in "tr[id=total] > td"
  
  Scenario: View a user when there are no tags
    Given there are no tags
    When I am on the "bob" user page
    Then I should see "bob"
    And I should not see "harry"
    And I should not see "animals"
    And I should see "Total:" in "tr[id=total] > th"
    And I should see "0" in "tr[id=total] > td"
  
  Scenario: View a user when there are no adjustments
    Given there are no adjustments
    When I am on the "bob" user page
    Then I should see "bob"
    And I should not see "harry"
    And I should see "animals" in "tr[id=animals] > th"
    And I should see "0" in "tr[id=animals] > td"
    And I should see "plants" in "tr[id=plants] > th"
    And I should see "0" in "tr[id=plants] > td"
    And I should see "Total:" in "tr[id=total] > th"
    And I should see "0" in "tr[id=total] > td"
  
  Scenario: Edit a user
    Given I am on the edit "bob" user page
    When I fill in "Permalink" with "steve"
    And I press "Update User"
    Then I should be on the "steve" user page
    And I should see "User was successfully updated."
  
  Scenario: Attempt to Edit a user with a blank permalink
    Given I am on the edit "bob" user page
    When I fill in "Permalink" with ""
    And I press "Update User"
    Then I should see "Edit User"
    And I should see an error message
    And I should see "Permalink can't be blank"
  
  Scenario: Attempt to Edit a user with a period in the permalink
    Given I am on the edit "bob" user page
    When I fill in "Permalink" with "joe.smith"
    And I press "Update User"
    Then I should see "Edit User"
    And I should see an error message
    And I should see "Permalink can't have a period"
  
  Scenario: Attempt to Edit a user with a backslash in the permalink
    Given I am on the edit "bob" user page
    When I fill in "Permalink" with "joe/smith"
    And I press "Update User"
    Then I should see "Edit User"
    And I should see an error message
    And I should see "Permalink can't have a slash"
  
  Scenario: Attempt to Edit a user with a period and a slash
    Given I am on the edit "bob" user page
    When I fill in "Permalink" with "joe/smi.th"
    And I press "Update User"
    Then I should see "Edit User"
    And I should see an error message
    And I should see "Permalink can't have a slash"
    And I should see "Permalink can't have a period"
  
  Scenario: Attempt to Edit a user with "index" as the permalink
    Given I am on the edit "bob" user page
    When I fill in "Permalink" with "index"
    And I press "Update User"
    Then I should see "Edit User"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Edit a user with "new" as the permalink
    Given I am on the edit "bob" user page
    When I fill in "Permalink" with "new"
    And I press "Update User"
    Then I should see "Edit User"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Edit a user with "create" as the permalink
    Given I am on the edit "bob" user page
    When I fill in "Permalink" with "create"
    And I press "Update User"
    Then I should see "Edit User"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Edit a user with "edit" as the permalink
    Given I am on the edit "bob" user page
    When I fill in "Permalink" with "edit"
    And I press "Update User"
    Then I should see "Edit User"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Edit a user with "update" as the permalink
    Given I am on the edit "bob" user page
    When I fill in "Permalink" with "update"
    And I press "Update User"
    Then I should see "Edit User"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Edit a user with "show" as the permalink
    Given I am on the edit "bob" user page
    When I fill in "Permalink" with "show"
    And I press "Update User"
    Then I should see "Edit User"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Destroy a user
    Given I am on the users page
    And I should see "bob"
    When I follow "Destroy bob User"
    Then I should be on the users page
    And I should see "User was successfully destroyed."
    And I should not see "bob"
  