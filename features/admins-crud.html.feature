Feature: Admin CRUD via HTML
  In order to designate administrative privileges
  As a superuser
  I want to manage admins

    Background:
      Given I have an admin with attributes id "1" and name "Jim"
      And I have an admin with attributes id "2" and name "Bob"

    Scenario: Create an admin
      Given I am on the new admin page
      When I fill in "Name" with "Jack"
      And I press "Create Admin"
      Then I should be on the "Jack" admin page
      And I should see "Admin was successfully created."

    Scenario: Edit an admin
      Given I am on the edit "Jim" admin page
      When I fill in "Name" with "Jimmo"
      And I press "Update Admin"
      Then I should be on the "Jimmo" admin page
      And I should see "Admin was successfully saved."

    Scenario: Attempt to Edit an admin with a blank name
      Given I am on the edit "Jim" admin page
      When I fill in "Name" with ""
      And I press "Update Admin"
      Then I should see "Edit Admin"
      And I should see an error message
      And I should see "Name can't be blank"

    Scenario: View list of admins
      Given I am on the admins page
      Then I should see "Jim"
      And I should see "Bob"

    Scenario: View an admin
      Given I am on the "Jim" admin page
      Then I should see "Jim"
      And I should not see "Bob"

    Scenario: Destroy an admin
      Given I am on the admins page
      When I follow "Destroy Jim"
      Then I should be on the admins page
      And I should see "Jim was successfully destroyed."
      And I should not see "Animals"
