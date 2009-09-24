Feature: Adjustments via HTML
  In order to tweak and report on changes to karma
  As an admin
  I want to be able to view and manipulate users' karma via my web browser

  Scenario: Create a new adjustment
    Given a user "bob"
    And a bucket "plants"
    When I go to the new adjustment page for bob's plants bucket
    And I fill in "value" with "5"
    And I press "Save"
    And I go to the new adjustment page for bob's plants bucket
    And I fill in "value" with "-1"
    And I press "Save"
    Then I should be on the adjustments page for bob's plants bucket
    And I should see "5"
    And I should see "-1"
    And there should be no errors

  Scenario: Create a new adjustment with blank value
    Given a user "bob"
    And a bucket "plants"
    When I go to the new adjustment page for bob's plants bucket
    And I press "Save"
    Then I should see "New Adjustment"
    And I should see an error message
    And I should see "Value can't be blank"
    
  Scenario: Create a new adjustment for user
    Given a user "bob"
    And a bucket "plants"
    When I go to the new adjustment page for user bob
    And I fill in "value" with "4"
    And I select "plants" from "Bucket"
    And I press "Save"
    Then I should be on the adjustments page for bob's plants bucket
    And I should see "4"
    And there should be no errors
    And I should see "Karma was successfully adjusted"
    
  Scenario: Create a new adjustment for user with blank value
    Given a user "bob"
    And a bucket "plants"
    When I go to the new adjustment page for user bob
    And I select "plants" from "Bucket"
    And I press "Save"
    Then I should see "New Adjustment"
    And I should see an error message
    And I should see "Value can't be blank"
    
  Scenario: Create a new adjustment for user with invalid value
    Given a user "bob"
    And a bucket "plants"
    When I go to the new adjustment page for user bob
    And I fill in "value" with "not-valid"
    And I press "Save"
    Then I should see "New Adjustment"
    And I should see an error message
    And I should see "Value is not a number"