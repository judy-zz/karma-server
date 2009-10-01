Feature: Buckets via HTML
  In order to manage buckets for the web applications,
  As an admin
  I want to be able to create, read, update, and delete Bucket objects via HTML.
  
  Background:
    Given I have a bucket with attributes id "1" and permalink "Animals"
    And I have a bucket with attributes id "2" and permalink "Plants"
    # And I have an adjustment with value "5" and bucket_id "1" and user_id "1"
  
  Scenario: Create a bucket
    Given I am on the new bucket page
    When I fill in "Permalink" with "Bugs"
    And I press "Create Bucket"
    Then I should be on the "Bugs" bucket page
    And I should see "Bucket was successfully created."
    
  Scenario: Attempt to Create a bucket via PUT with an invalid permalink
    When I PUT "/buckets/doesnt-exist" with body "bucket[permalink]="
    And I should see "Bucket wasn't successfully created."
  
  Scenario: Attempt to Create a bucket with a period
    Given I am on the new bucket page
    When I fill in "Permalink" with "Bugs.Bar"
    And I press "Create Bucket"
    Then I should see "New Bucket"
    And I should see "Bucket couldn't be created."
    And I should see "Permalink can't contain a period or a slash"
  
  Scenario: Attempt to Create a bucket with a slash
    Given I am on the new bucket page
    When I fill in "Permalink" with "Bugs/foo"
    And I press "Create Bucket"
    Then I should see "New Bucket"
    And I should see "Bucket couldn't be created."
    And I should see "Permalink can't contain a period or a slash"
  
  Scenario: Attempt to Create a bucket with a slash and a period
    Given I am on the new bucket page
    When I fill in "Permalink" with "Bugs/foo.bar"
    And I press "Create Bucket"
    Then I should see "New Bucket"
    And I should see "Bucket couldn't be created."
    And I should see "Permalink can't contain a period or a slash"
    
  Scenario: Edit a bucket
    Given I am on the edit "Animals" bucket page
    When I fill in "Permalink" with "Animals1"
    And I press "Update Bucket"
    Then I should be on the "Animals1" bucket page
    And I should see "Bucket was successfully updated."
    
  Scenario: Attempt to edit a bucket without a Permalink
    Given I am on the edit "Animals" bucket page
    When I fill in "Permalink" with ""
    And I press "Update Bucket"
    Then I should see "Editing Bucket"
    And I should see "Animals"
    And I should see "Bucket wasn't successfully updated."
    And I should see "Permalink can't be blank"
    
  Scenario: Attempt to edit a bucket without a valid Permalink twice
    Given I am on the edit "Animals" bucket page
    When I fill in "Permalink" with ""
    And I press "Update Bucket"
    Then I should see "Editing Bucket"
    When I fill in "Permalink" with "adjustments/2"
    And I press "Update Bucket"
    Then I should see "Editing Bucket"
    And I should see "Animals"
    And I should see "Bucket wasn't successfully updated."
    And I should see "Permalink can't contain a period or a slash"
  
  Scenario: View list of buckets
    Given I am on the buckets page
    Then I should see "Animals"
    And I should see "Plants"
  
  Scenario: View a bucket
    Given I am on the "Animals" bucket page
    Then I should see "Animals"
    And I should not see "Plants"
  
  Scenario: Destroy a bucket
    Given I am on the buckets page
    When I follow "Destroy Animals Bucket"
    Then I should be on the buckets page
    And I should see "Bucket was successfully destroyed."
    And I should not see "Animals"