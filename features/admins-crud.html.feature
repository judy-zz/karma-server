Feature: Admin CRUD via HTML
  In order to designate administrative privileges
  As a superuser
  I want to manage admins

    Background:
      Given I have an admin with attributes id "1" and name "Animals"
      And I have an admin with attributes id "2" and name "Plants"

    Scenario: Create an admin
      Given I am on the new admin page
      When I fill in "Name" with "Bugs"
      And I press "Create Admin"
      Then I should be on the "Bugs" admin page
      And I should see "Admin was successfully created."

    Scenario: Attempt to Create an admin via PUT with an invalid name
      When I PUT "/admins/doesnt-exist" with body "admin[name]="
      And I should see "Admin couldn't be created."

    Scenario: Attempt to Create an admin with a period
      Given I am on the new admin page
      When I fill in "Name" with "Bugs.Bar"
      And I press "Create Admin"
      Then I should see "New Admin"
      And I should see "Admin couldn't be created."
      And I should see "Name can't have a period"

    Scenario: Attempt to Create an admin with a slash
      Given I am on the new admin page
      When I fill in "Name" with "Bugs/foo"
      And I press "Create Admin"
      Then I should see "New Admin"
      And I should see "Admin couldn't be created."
      And I should see "Name can't have a slash"

    Scenario: Attempt to Create an admin with a slash and a period
      Given I am on the new admin page
      When I fill in "Name" with "Bugs/foo.bar"
      And I press "Create Admin"
      Then I should see "New Admin"
      And I should see "Admin couldn't be created."
      And I should see "Name can't have a slash"
      And I should see "Name can't have a period"

    Scenario: Attempt to Create an admin with "index" as the name
      Given I am on the new admin page
      When I fill in "Name" with "index"
      And I press "Create Admin"
      Then I should see "New Admin"
      And I should see an error message
      And I should see "Name can't be index, new, create, edit, update or show"

    Scenario: Attempt to Create an admin with "new" as the name
      Given I am on the new admin page
      When I fill in "Name" with "new"
      And I press "Create Admin"
      Then I should see "New Admin"
      And I should see an error message
      And I should see "Name can't be index, new, create, edit, update or show"

    Scenario: Attempt to Create an admin with "create" as the name
      Given I am on the new admin page
      When I fill in "Name" with "create"
      And I press "Create Admin"
      Then I should see "New Admin"
      And I should see an error message
      And I should see "Name can't be index, new, create, edit, update or show"

    Scenario: Attempt to Create an admin with "edit" as the name
      Given I am on the new admin page
      When I fill in "Name" with "edit"
      And I press "Create Admin"
      Then I should see "New Admin"
      And I should see an error message
      And I should see "Name can't be index, new, create, edit, update or show"

    Scenario: Attempt to Create an admin with "update" as the name
      Given I am on the new admin page
      When I fill in "Name" with "update"
      And I press "Create Admin"
      Then I should see "New Admin"
      And I should see an error message
      And I should see "Name can't be index, new, create, edit, update or show"

    Scenario: Attempt to Create an admin with "show" as the name
      Given I am on the new admin page
      When I fill in "Name" with "show"
      And I press "Create Admin"
      Then I should see "New Admin"
      And I should see an error message
      And I should see "Name can't be index, new, create, edit, update or show"

    Scenario: Edit an admin
      Given I am on the edit "Animals" admin page
      When I fill in "Name" with "Animals1"
      And I press "Update Admin"
      Then I should be on the "Animals1" admin page
      And I should see "Admin was successfully updated."

    Scenario: Attempt to edit an admin without a valid Name twice
      Given I am on the edit "Animals" admin page
      When I fill in "Name" with ""
      And I press "Update Admin"
      Then I should see "Edit Admin"
      When I fill in "Name" with "adjustments/2"
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see "Animals"
      And I should see "Admin couldn't be updated."
      And I should see "Name can't have a slash"

    Scenario: Attempt to Edit an admin with a blank name
      Given I am on the edit "Animals" admin page
      When I fill in "Name" with ""
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see an error message
      And I should see "Name can't be blank"

    Scenario: Attempt to Edit an admin with a period in the name
      Given I am on the edit "Animals" admin page
      When I fill in "Name" with "ani.mals"
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see an error message
      And I should see "Name can't have a period"

    Scenario: Attempt to Edit an admin with a backslash in the name
      Given I am on the edit "Animals" admin page
      When I fill in "Name" with "lions/tigers/bears"
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see an error message
      And I should see "Name can't have a slash"

    Scenario: Attempt to Edit an admin with a period and a slash
      Given I am on the edit "Animals" admin page
      When I fill in "Name" with "in.sec.t/sAnimals"
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see an error message
      And I should see "Name can't have a slash"
      And I should see "Name can't have a period"

    Scenario: Attempt to Edit an admin with "index" as the name
      Given I am on the edit "Animals" admin page
      When I fill in "Name" with "index"
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see an error message
      And I should see "Name can't be index, new, create, edit, update or show"

    Scenario: Attempt to Edit an admin with "new" as the name
      Given I am on the edit "Animals" admin page
      When I fill in "Name" with "new"
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see an error message
      And I should see "Name can't be index, new, create, edit, update or show"

    Scenario: Attempt to Edit an admin with "create" as the name
      Given I am on the edit "Animals" admin page
      When I fill in "Name" with "create"
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see an error message
      And I should see "Name can't be index, new, create, edit, update or show"

    Scenario: Attempt to Edit an admin with "edit" as the name
      Given I am on the edit "Animals" admin page
      When I fill in "Name" with "edit"
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see an error message
      And I should see "Name can't be index, new, create, edit, update or show"

    Scenario: Attempt to Edit an admin with "update" as the name
      Given I am on the edit "Animals" admin page
      When I fill in "Name" with "update"
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see an error message
      And I should see "Name can't be index, new, create, edit, update or show"

    Scenario: Attempt to Edit an admin with "show" as the name
      Given I am on the edit "Animals" admin page
      When I fill in "Name" with "show"
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see an error message
      And I should see "Name can't be index, new, create, edit, update or show"

    Scenario: View list of admins
      Given I am on the admins page
      Then I should see "Animals"
      And I should see "Plants"

    Scenario: View an admin
      Given I am on the "Animals" admin page
      Then I should see "Animals"
      And I should not see "Plants"

    Scenario: Destroy an admin
      Given I am on the admins page
      When I follow "Destroy Animals Admin"
      Then I should be on the admins page
      And I should see "Admin was successfully destroyed."
      And I should not see "Animals"
