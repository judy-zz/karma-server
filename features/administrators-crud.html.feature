Feature: Administrator CRUD via HTML
  In order to designate administrative privileges
  As a superuser
  I want to manage admins

    Background:
      Given I have an administrator with attributes id "1" and permalink "Animals"
      And I have an administrator with attributes id "2" and permalink "Plants"

    Scenario: Create an administrator
      Given I am on the new administrator page
      When I fill in "Permalink" with "Bugs"
      And I press "Create Administrator"
      Then I should be on the "Bugs" administrator page
      And I should see "Administrator was successfully created."

    Scenario: Attempt to Create an administrator via PUT with an invalid permalink
      When I PUT "/administrators/doesnt-exist" with body "administrator[permalink]="
      And I should see "Administrator couldn't be created."

    Scenario: Attempt to Create an administrator with a period
      Given I am on the new administrator page
      When I fill in "Permalink" with "Bugs.Bar"
      And I press "Create Administrator"
      Then I should see "New Administrator"
      And I should see "Administrator couldn't be created."
      And I should see "Permalink can't have a period"

    Scenario: Attempt to Create an administrator with a slash
      Given I am on the new administrator page
      When I fill in "Permalink" with "Bugs/foo"
      And I press "Create Administrator"
      Then I should see "New Administrator"
      And I should see "Administrator couldn't be created."
      And I should see "Permalink can't have a slash"

    Scenario: Attempt to Create an administrator with a slash and a period
      Given I am on the new administrator page
      When I fill in "Permalink" with "Bugs/foo.bar"
      And I press "Create Administrator"
      Then I should see "New Administrator"
      And I should see "Administrator couldn't be created."
      And I should see "Permalink can't have a slash"
      And I should see "Permalink can't have a period"

    Scenario: Attempt to Create an administrator with "index" as the permalink
      Given I am on the new administrator page
      When I fill in "Permalink" with "index"
      And I press "Create Administrator"
      Then I should see "New Administrator"
      And I should see an error message
      And I should see "Permalink can't be index, new, create, edit, update or show"

    Scenario: Attempt to Create an administrator with "new" as the permalink
      Given I am on the new administrator page
      When I fill in "Permalink" with "new"
      And I press "Create Administrator"
      Then I should see "New Administrator"
      And I should see an error message
      And I should see "Permalink can't be index, new, create, edit, update or show"

    Scenario: Attempt to Create an administrator with "create" as the permalink
      Given I am on the new administrator page
      When I fill in "Permalink" with "create"
      And I press "Create Administrator"
      Then I should see "New Administrator"
      And I should see an error message
      And I should see "Permalink can't be index, new, create, edit, update or show"

    Scenario: Attempt to Create an administrator with "edit" as the permalink
      Given I am on the new administrator page
      When I fill in "Permalink" with "edit"
      And I press "Create Administrator"
      Then I should see "New Administrator"
      And I should see an error message
      And I should see "Permalink can't be index, new, create, edit, update or show"

    Scenario: Attempt to Create an administrator with "update" as the permalink
      Given I am on the new administrator page
      When I fill in "Permalink" with "update"
      And I press "Create Administrator"
      Then I should see "New Administrator"
      And I should see an error message
      And I should see "Permalink can't be index, new, create, edit, update or show"

    Scenario: Attempt to Create an administrator with "show" as the permalink
      Given I am on the new administrator page
      When I fill in "Permalink" with "show"
      And I press "Create Administrator"
      Then I should see "New Administrator"
      And I should see an error message
      And I should see "Permalink can't be index, new, create, edit, update or show"

    Scenario: Edit an administrator
      Given I am on the edit "Animals" administrator page
      When I fill in "Permalink" with "Animals1"
      And I press "Update Administrator"
      Then I should be on the "Animals1" administrator page
      And I should see "Administrator was successfully updated."

    Scenario: Attempt to edit an administrator without a valid Permalink twice
      Given I am on the edit "Animals" administrator page
      When I fill in "Permalink" with ""
      And I press "Update Administrator"
      Then I should see "Edit Administrator"
      When I fill in "Permalink" with "adjustments/2"
      And I press "Update Administrator"
      Then I should see "Edit Administrator"
      And I should see "Animals"
      And I should see "Administrator couldn't be updated."
      And I should see "Permalink can't have a slash"

    Scenario: Attempt to Edit an administrator with a blank permalink
      Given I am on the edit "Animals" administrator page
      When I fill in "Permalink" with ""
      And I press "Update Administrator"
      Then I should see "Edit Administrator"
      And I should see an error message
      And I should see "Permalink can't be blank"

    Scenario: Attempt to Edit an administrator with a period in the permalink
      Given I am on the edit "Animals" administrator page
      When I fill in "Permalink" with "ani.mals"
      And I press "Update Administrator"
      Then I should see "Edit Administrator"
      And I should see an error message
      And I should see "Permalink can't have a period"

    Scenario: Attempt to Edit an administrator with a backslash in the permalink
      Given I am on the edit "Animals" administrator page
      When I fill in "Permalink" with "lions/tigers/bears"
      And I press "Update Administrator"
      Then I should see "Edit Administrator"
      And I should see an error message
      And I should see "Permalink can't have a slash"

    Scenario: Attempt to Edit an administrator with a period and a slash
      Given I am on the edit "Animals" administrator page
      When I fill in "Permalink" with "in.sec.t/sAnimals"
      And I press "Update Administrator"
      Then I should see "Edit Administrator"
      And I should see an error message
      And I should see "Permalink can't have a slash"
      And I should see "Permalink can't have a period"

    Scenario: Attempt to Edit an administrator with "index" as the permalink
      Given I am on the edit "Animals" administrator page
      When I fill in "Permalink" with "index"
      And I press "Update Administrator"
      Then I should see "Edit Administrator"
      And I should see an error message
      And I should see "Permalink can't be index, new, create, edit, update or show"

    Scenario: Attempt to Edit an administrator with "new" as the permalink
      Given I am on the edit "Animals" administrator page
      When I fill in "Permalink" with "new"
      And I press "Update Administrator"
      Then I should see "Edit Administrator"
      And I should see an error message
      And I should see "Permalink can't be index, new, create, edit, update or show"

    Scenario: Attempt to Edit an administrator with "create" as the permalink
      Given I am on the edit "Animals" administrator page
      When I fill in "Permalink" with "create"
      And I press "Update Administrator"
      Then I should see "Edit Administrator"
      And I should see an error message
      And I should see "Permalink can't be index, new, create, edit, update or show"

    Scenario: Attempt to Edit an administrator with "edit" as the permalink
      Given I am on the edit "Animals" administrator page
      When I fill in "Permalink" with "edit"
      And I press "Update Administrator"
      Then I should see "Edit Administrator"
      And I should see an error message
      And I should see "Permalink can't be index, new, create, edit, update or show"

    Scenario: Attempt to Edit an administrator with "update" as the permalink
      Given I am on the edit "Animals" administrator page
      When I fill in "Permalink" with "update"
      And I press "Update Administrator"
      Then I should see "Edit Administrator"
      And I should see an error message
      And I should see "Permalink can't be index, new, create, edit, update or show"

    Scenario: Attempt to Edit an administrator with "show" as the permalink
      Given I am on the edit "Animals" administrator page
      When I fill in "Permalink" with "show"
      And I press "Update Administrator"
      Then I should see "Edit Administrator"
      And I should see an error message
      And I should see "Permalink can't be index, new, create, edit, update or show"

    Scenario: View list of administrators
      Given I am on the administrators page
      Then I should see "Animals"
      And I should see "Plants"

    Scenario: View an administrator
      Given I am on the "Animals" administrator page
      Then I should see "Animals"
      And I should not see "Plants"

    Scenario: Destroy an administrator
      Given I am on the administrators page
      When I follow "Destroy Animals Administrator"
      Then I should be on the administrators page
      And I should see "Administrator was successfully destroyed."
      And I should not see "Animals"
