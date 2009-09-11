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
    
  Scenario: Edit a bucket
    Given I am on the edit "Animals" bucket page
    When I fill in "Permalink" with "Animals1"
    And I press "Update Bucket"
    Then I should be on the "Animals1" bucket page
    And I should see "Bucket was successfully updated."
  
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