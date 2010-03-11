Feature: Admin Authentication
  I want to be authenticated
  As an administrator
  So no one else can abuse the karma server
  
  Scenario: Logging in
    Given an admin "jimjim" with password "jimjim"
    When I log in as "jimjim" with password "jimjim"
    And I go to the websites page
    Then I should see "Websites"
  
  
  

  
