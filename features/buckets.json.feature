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
Feature: Buckets via JSON
  In order to manage buckets for the web applications,
  As a client
  I want to be able to read Bucket objects and adjustments by buckets via JSON.
  
  Background:
    Given the following buckets:
      | id | name     | created_at          | updated_at          |
      | 1  | Animals  | 2009-10-01 12:00:00 | 2009-10-01 12:00:00 | 
      | 2  | Plants   | 2009-10-02 12:00:00 | 2009-10-02 12:00:00 | 
    And I have a user with attributes permalink "bob" and id "1"

  Scenario: Read a list of buckets
    When I GET "/buckets.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      [{
        bucket: {
          id: 1,
          name: Animals,
          created_at: "2009-10-01T12:00:00Z",
          updated_at: "2009-10-01T12:00:00Z"
        }},
        {bucket: {
          id: 2,
          name: Plants,
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
          name: Plants,
          created_at: "2009-10-02T12:00:00Z",
          updated_at: "2009-10-02T12:00:00Z"
        }
      }
    """
     
  Scenario: Request a new bucket
    When I GET "/buckets/new.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        "bucket":{
          "name":null,
          "updated_at":null,
          "created_at":null
        }
      }
    """
  
  Scenario: Create a new bucket via put
    When I PUT "/buckets/dinosaurs.json"
    Then I should get a 204 Created response
    And I should get a blank response body