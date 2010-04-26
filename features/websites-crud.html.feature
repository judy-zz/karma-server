Feature: Websites CRUD via HTML
  In order to control which sites can submit karma adjustments
  As a admin
  I want to manage websites

    Background:
      Given I have an website with attributes id "1", name "West Arete Computing", and url "http://www.westarete.com"
      And a tag "animal" for "West Arete Computing"
      And I have an website with attributes id "2", name "Yahoo", and url "http://www.yahoo.com"
      And an admin "jimjim" with password "jimjim"
      And an admin "bobbob" with password "bobbob"
      And I log in as "jimjim" with password "jimjim"

    Scenario: Create a website
      Given I am on the new website page
      When I fill in "Name" with "Reddit"
      And I fill in "URL" with "http://www.reddit.com"
      And I press "Create Website"
      Then I should be on the "Reddit" website page
      And I should see "Website was successfully created."

    Scenario: Edit a website
      Given I am on the edit "West Arete Computing" website page
      When I fill in "Name" with "West Arete Pizza Delivery"
      And I press "Update Website"
      Then I should be on the "West Arete Pizza Delivery" website page
      And I should see "Website was successfully saved."

    Scenario: Attempt to Edit an website with a blank name
      Given I am on the edit "West Arete Computing" website page
      When I fill in "Name" with ""
      And I press "Update Website"
      Then I should see "Edit Website"
      And I should see an error message
      And I should see "Name can't be blank"
      
    Scenario: Attempt to Edit an website with a blank url
      Given I am on the edit "West Arete Computing" website page
      When I fill in "URL" with ""
      And I press "Update Website"
      Then I should see "Edit Website"
      And I should see an error message
      And I should see "Url can't be blank"

    Scenario: View list of websites
      Given I am on the websites page
      Then I should see "West Arete Computing"
      And I should see "Yahoo"

    Scenario: View an website
      Given I am on the "West Arete Computing" website page
      Then I should see "http://www.westarete.com"
      And I should not see "Yahoo"

    Scenario: Destroy an website
      Given I am on the websites page
      When I click "Destroy West Arete Computing website"
      Then I should be on the websites page
      And I should see "Website was successfully destroyed."
      And I should not see "West Arete Computing"
    
    Scenario: Create a tag for a website
      Given I am on the "West Arete Computing" website page
      When I fill in "tag_permalink" with "animals"
      And I press "Add a Tag"
      Then I should be on the "West Arete Computing" website page
      And I should see "Tag was successfully created."
      And I should see "animals"
      
    Scenario: Edit a website's tag
      Given I am on the "West Arete Computing" website page
      Then I should see "animal"
      When I click "Edit"
      Then I should be on the edit tag page for "West Arete Computing" "animal" tag
      When I fill in "tag_permalink" with "animalia"
      And I press "Update Tag"
      Then I should be on the "West Arete Computing" website page
      And I should see "Tag was successfully updated."
      And I should see "animalia"
      
    Scenario: Delete a website's tag
      Given I am on the "West Arete Computing" website page
      And I should see "animal"
      When I click "Destroy"
      Then I should be on the "West Arete Computing" website page
      And I should see "Tag was successfully destroyed."
      And I should not see "animal"
      
      
    
    
    
    
    
    