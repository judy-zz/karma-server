Feature: Buckets via JSON
  In order to manage buckets for the web applications,
  As a client
  I want to be able to read Bucket objects and adjustments by buckets via JSON.
  
  Background:
    Given I have a bucket with attributes name "Animals" and id "1"
    And I have a bucket with attributes name "Plants" and id "2"
    And I have a user with attributes permalink "bob" and id "1"
    # And I have an adjustment with value "5" and bucket_id "1" and user_id "1"

  Scenario: Get a list of buckets
    When I GET "/buckets.json"
    Then I should get a 200 OK response

  # TODO: Cannot implement until after adjustments are implemented
  # Scenario: Retrieve buckets for user
  #   Given I have a user with permalink "bob" and id "1"
  #   And I have an adjustment with value "10" and bucket_id "1" and user_id "1"
  #   When I GET from "/users/bob/buckets"
  #   Then I should get a 200 OK response
  #   And I should see "Animals"
  #   And I should not see "Plants"
  #   
  # TODO: Cannot implement until after adjustments are implemented
  # Scenario: Retrieve buckets for non existing user
  #   When I GET from "/users/mark/buckets"
  #   Then I should get a 404 Not Found response
  # 
  # Scenario: Get total for a bucket for a user
  #   When I GET from "/users/bob/buckets/animals.json"
  # 
  # Scenario: Get total for all buckets for a user
  #   When I GET from "/users/bob/buckets.json"