Feature: Tags via HTML
  In order to manage tags for the web applications,
  As an admin
  I want to be able to create, read, update, and delete Tag objects via HTML.
  
  Background:
    Given I have a tag with attributes id "1" and permalink "Animals"
    And I have a tag with attributes id "2" and permalink "Plants"
    And an admin "jimjim" with password "jimjim"
    And I log in as "jimjim" with password "jimjim"

# TODO: Fix features which use the "should be on the '' tag page" step
  Scenario: Create a tag
    Given I am on the new tag page
    When I fill in "Permalink" with "Bugs"
    And I press "Create Tag"
    #Then I should be on the "Bugs" tag page
    And I should see "Tag was successfully created."
  
  Scenario: Attempt to Create a tag with a period
    Given I am on the new tag page
    When I fill in "Permalink" with "Bugs.Bar"
    And I press "Create Tag"
    Then I should see "New Tag"
    And I should see "Tag couldn't be created."
    And I should see "Permalink can't have a period"
  
  Scenario: Attempt to Create a tag with a slash
    Given I am on the new tag page
    When I fill in "Permalink" with "Bugs/foo"
    And I press "Create Tag"
    Then I should see "New Tag"
    And I should see "Tag couldn't be created."
    And I should see "Permalink can't have a slash"
  
  Scenario: Attempt to Create a tag with a slash and a period
    Given I am on the new tag page
    When I fill in "Permalink" with "Bugs/foo.bar"
    And I press "Create Tag"
    Then I should see "New Tag"
    And I should see "Tag couldn't be created."
    And I should see "Permalink can't have a slash"
    And I should see "Permalink can't have a period"
  
  Scenario: Attempt to Create a tag with "index" as the permalink
    Given I am on the new tag page
    When I fill in "Permalink" with "index"
    And I press "Create Tag"
    Then I should see "New Tag"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Create a tag with "new" as the permalink
    Given I am on the new tag page
    When I fill in "Permalink" with "new"
    And I press "Create Tag"
    Then I should see "New Tag"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Create a tag with "create" as the permalink
    Given I am on the new tag page
    When I fill in "Permalink" with "create"
    And I press "Create Tag"
    Then I should see "New Tag"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Create a tag with "edit" as the permalink
    Given I am on the new tag page
    When I fill in "Permalink" with "edit"
    And I press "Create Tag"
    Then I should see "New Tag"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Create a tag with "update" as the permalink
    Given I am on the new tag page
    When I fill in "Permalink" with "update"
    And I press "Create Tag"
    Then I should see "New Tag"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Create a tag with "show" as the permalink
    Given I am on the new tag page
    When I fill in "Permalink" with "show"
    And I press "Create Tag"
    Then I should see "New Tag"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Edit a tag
    Given I am on the edit "Animals" tag page
    When I fill in "Permalink" with "Animals1"
    And I press "Update Tag"
    Then I should be on the "Animals1" tag page
    And I should see "Tag was successfully updated."
  
  Scenario: Attempt to edit a tag without a valid Permalink twice
    Given I am on the edit "Animals" tag page
    When I fill in "Permalink" with ""
    And I press "Update Tag"
    Then I should see "Edit Tag"
    When I fill in "Permalink" with "adjustments/2"
    And I press "Update Tag"
    Then I should see "Edit Tag"
    And I should see "Animals"
    And I should see "Tag couldn't be updated."
    And I should see "Permalink can't have a slash"
  
  Scenario: Attempt to Edit a tag with a blank permalink
    Given I am on the edit "Animals" tag page
    When I fill in "Permalink" with ""
    And I press "Update Tag"
    Then I should see "Edit Tag"
    And I should see an error message
    And I should see "Permalink can't be blank"
  
  Scenario: Attempt to Edit a tag with a period in the permalink
    Given I am on the edit "Animals" tag page
    When I fill in "Permalink" with "ani.mals"
    And I press "Update Tag"
    Then I should see "Edit Tag"
    And I should see an error message
    And I should see "Permalink can't have a period"
  
  Scenario: Attempt to Edit a tag with a backslash in the permalink
    Given I am on the edit "Animals" tag page
    When I fill in "Permalink" with "lions/tigers/bears"
    And I press "Update Tag"
    Then I should see "Edit Tag"
    And I should see an error message
    And I should see "Permalink can't have a slash"
  
  Scenario: Attempt to Edit a tag with a period and a slash
    Given I am on the edit "Animals" tag page
    When I fill in "Permalink" with "in.sec.t/sAnimals"
    And I press "Update Tag"
    Then I should see "Edit Tag"
    And I should see an error message
    And I should see "Permalink can't have a slash"
    And I should see "Permalink can't have a period"
  
  Scenario: Attempt to Edit a tag with "index" as the permalink
    Given I am on the edit "Animals" tag page
    When I fill in "Permalink" with "index"
    And I press "Update Tag"
    Then I should see "Edit Tag"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Edit a tag with "new" as the permalink
    Given I am on the edit "Animals" tag page
    When I fill in "Permalink" with "new"
    And I press "Update Tag"
    Then I should see "Edit Tag"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Edit a tag with "create" as the permalink
    Given I am on the edit "Animals" tag page
    When I fill in "Permalink" with "create"
    And I press "Update Tag"
    Then I should see "Edit Tag"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Edit a tag with "edit" as the permalink
    Given I am on the edit "Animals" tag page
    When I fill in "Permalink" with "edit"
    And I press "Update Tag"
    Then I should see "Edit Tag"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Edit a tag with "update" as the permalink
    Given I am on the edit "Animals" tag page
    When I fill in "Permalink" with "update"
    And I press "Update Tag"
    Then I should see "Edit Tag"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: Attempt to Edit a tag with "show" as the permalink
    Given I am on the edit "Animals" tag page
    When I fill in "Permalink" with "show"
    And I press "Update Tag"
    Then I should see "Edit Tag"
    And I should see an error message
    And I should see "Permalink can't be index, new, create, edit, update or show"
  
  Scenario: View list of tags
    Given I am on the tags page
    Then I should see "Animals"
    And I should see "Plants"
  
  Scenario: View a tag
    Given I am on the "Animals" tag page
    Then I should see "Animals"
    And I should not see "Plants"
  
  Scenario: Destroy a tag
    Given I am on the tags page
    When I follow "Destroy Animals Tag"
    Then I should be on the tags page
    And I should see "Tag was successfully destroyed."
    And I should not see "Animals"
  