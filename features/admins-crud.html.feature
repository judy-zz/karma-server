Feature: Admin CRUD via HTML
  In order to designate administrative privileges
  As a superuser
  I want to manage admins

    Background:
      Given an admin "jimjim" with password "jimjim"
      And an admin "bobbob" with password "bobbob"
      And I log in as "jimjim" with password "jimjim"

    Scenario: Create an admin
      Given I am on the new admin page
      When I fill in "Name" with "Jack"
      And I fill in "Login" with "jackjack"
      And I fill in "Password" with "jackjack"
      And I fill in "Password Confirmation" with "jackjack"
      And I press "Create Admin"
      Then I should be on the "Jack" admin page
      And I should see "Admin was successfully created."

    Scenario: Edit an admin
      Given I am on the edit "jimjim" admin page
      When I fill in "Name" with "Jimmo"
      And I press "Update Admin"
      Then I should be on the "Jimmo" admin page
      And I should see "Admin was successfully saved."

    Scenario: Attempt to Edit an admin with a blank name
      Given I am on the edit "jimjim" admin page
      When I fill in "Name" with ""
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see an error message
      And I should see "Name can't be blank"

    Scenario: View list of admins
      Given I am on the admins page
      Then I should see "jimjim"
      And I should see "bobbob"

    Scenario: View an admin
      Given I am on the "jimjim" admin page
      Then I should see "jimjim"
      And I should not see "bobbob"

    Scenario: Destroy an admin
      Given I am on the admins page
      When I follow "Destroy bobbob"
      Then I should be on the admins page
      And I should see "bobbob was successfully destroyed."
