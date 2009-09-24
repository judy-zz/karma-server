# View list of buckets (:action => :index)
#   Method: GET
#   Action: index               
#     /buckets.json                         Green
#
# View the "plants" bucket
#   Method: GET      
#   Action: show       
#     /buckets/plants.json                  Green
#
# New bucket           
#   Method: GET      
#   Action: new        
#     /buckets/new.json                     Green
#
# Create or Update the "plants" bucket
#   Method: PUT             
#   Action: update          
#     /buckets/plants.json                  Not Implemented
#   Method: POST
#   Action: create                          Not Implemented
#
Feature: Buckets via JSON
  In order to query and manage buckets,
  As a client
  I want to be able to read and modify bucket resources via JSON.
  
  Background:
    Given the following buckets:
      | id | permalink | created_at          | updated_at          |
      | 1  | Animals   | 2009-10-01 12:00:00 | 2009-10-01 12:00:00 | 
      | 2  | Plants    | 2009-10-02 12:00:00 | 2009-10-02 12:00:00 | 
    And I have a user with attributes permalink "bob" and id "1"

  Scenario: Read list of buckets
    When I GET "/buckets.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      [{
        bucket: {
          id: 1,
          permalink: Animals,
          created_at: "2009-10-01T12:00:00Z",
          updated_at: "2009-10-01T12:00:00Z"
        }},
        {bucket: {
          id: 2,
          permalink: Plants,
          created_at: "2009-10-02T12:00:00Z",
          updated_at: "2009-10-02T12:00:00Z"
        }
      }]
    """
    
  Scenario: Read a bucket
    When I GET "/buckets/Plants.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        bucket: {
          id: 2,
          permalink: Plants,
          created_at: "2009-10-02T12:00:00Z",
          updated_at: "2009-10-02T12:00:00Z"
        }
      }
    """
    
  Scenario: Read a non-existing bucket
    When I GET "/buckets/bugs.json"
    Then I should get a 500 Internal Server Error response
    And I should get a blank response body
     
  Scenario: Request a new bucket
    When I GET "/buckets/new.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        "bucket":{
          "permalink":null,
          "updated_at":null,
          "created_at":null
        }
      }
    """
  
  Scenario: Create a bucket
    When I PUT "/buckets/dinosaurs.json"
    Then I should get a 201 Created response
    And I should get a blank response body
  
  Scenario: Update a bucket
    When I PUT "/buckets/Animals.json" with body "bucket[permalink]=Nice Animals"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        bucket:{
          id: 1,
          permalink: "Nice Animals",
          created_at: "2009-10-01T12:00:00Z",
          updated_at: "2009-09-09T12:00:00Z"
        }
      }
    """