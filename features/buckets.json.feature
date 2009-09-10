# View list of buckets (:action => :index)
#   Method: GET
#   Action: index               
#     /buckets                              Not Implemented
#     /buckets.json
#     /buckets.xml                          Not Implemented
#
# View the "plants" bucket
#   Method: GET      
#   Action: show       
#     /buckets/plants                       Not Implemented
#     /buckets/plants.json                  Pending
#     /buckets/plants.xml                   Not Implemented
#
# New bucket           
#   Method: GET      
#   Action: new        
#     /buckets/new                          Not Implemented
#     /buckets/new.json                     Not Implemented
#     /buckets/new.xml                      Not Implemented
#
# Create or Update the "plants" bucket
#   Method: PUT             
#   Action: update          
#     /buckets/plants                       Not Implemented
#     /buckets/plants.json                  Not Implemented
#     /buckets/plants.xml                   Not Implemented
#
# Edit the "plants" bucket  
#   Method: GET             
#   Action: edit            
#     /buckets/plants/edit                  Not Implemented
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
    When I GET from "/buckets.json"
    Then I should get a 200 OK response
    
  Scenario: View the "Plants" bucket
    When I GET from "/buckets/Plants.json"
    Then I should get a 200 OK response
    And I should get a json object with the following:
     | name | Plants  |
     | id   | 2       |
     
  #   
  # Scenario: Create a new bucket
  #   When I PUT to "/buckets/plants.json" with body ""
  #   Then I should get a 201 Created response

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