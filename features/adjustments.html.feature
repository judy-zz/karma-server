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
    And I should see "4"
    
  
  
  


