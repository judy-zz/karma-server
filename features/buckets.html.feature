Feature: Buckets via HTML
  In order to manage buckets for the web applications,
  As an admin
  I want to be able to create, read, update, and delete Bucket objects via HTML.
  
  Background:
    Given I have a bucket with name "Animals" and id "1"
    And I have a bucket with name "Plants" and id "2"
    # And I have an adjustment with value "5" and bucket_id "1" and user_id "1"
  
  Scenario: Create a bucket
    Given I am on the new bucket page
    When I fill in "Name" with "Bugs"
    And I press "Create Bucket"
    And I should see "Bucket was successfully created."
    And I should see the "Bugs" bucket
    
    Scenario: Edit a bucket
      Given I am on the buckets page
      And I click "Edit" next to the "Animals" bucket
      When I fill in "Name" with "Animals1"
      And I press "Update Bucket"
      Then I should be on the "Animals1" bucket page
      And I should see "Bucket was successfully updated."
      And I should see the "Animals1" bucket
    
    Scenario: View list of buckets
      Given I am on the buckets page
      Then I should see the "Animals" bucket
      And I should see the "Plants" bucket
    
    Scenario: View a bucket
      Given I am on the buckets page
      When I press the "Animals" bucket
      Then I should be on the "Animals" bucket page
      And I should see the "Animals" bucket
    
    Scenario: Destroy a bucket
      Given I am on the buckets page
      When I press "Destroy" next to the "Animals" bucket
      Then I should be on the buckets page
      And I should see "Bucket was successfully destroyed."
      And I should not see the "Animals" bucket