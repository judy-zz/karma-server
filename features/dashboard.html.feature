Feature: Dashboard via HTML
  In order to navigate the Karma database
  As an admin
  I want to be able to access these features
  
  Background:
    Given an admin "jimjim" with password "jimjim"
    When I log in as "jimjim" with password "jimjim"
  
  Scenario: Access the Home page
    When I go to the home page
    Then I should see "Users"
    And I should see "Tags"
  
  Scenario: Access a bad url
    When I GET "/bad_path"
    Then I should get a 404 Not Found response
    And I should see "The page you were looking for doesn't exist."
  