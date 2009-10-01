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
          permalink: Animals,
          path: "/buckets/Animals.json",
          created_at: "2009-10-01T12:00:00Z",
          updated_at: "2009-10-01T12:00:00Z"
        }},
        {bucket: {
          permalink: Plants,
          path: "/buckets/Plants.json",
          created_at: "2009-10-02T12:00:00Z",
          updated_at: "2009-10-02T12:00:00Z"
        }
      }]
    """
    
  Scenario: Read list of buckets when there are no buckets
    Given there are no buckets
    When I GET "/buckets.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      []
    """
    
  Scenario: Read a bucket
    When I GET "/buckets/Plants.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        bucket: {
          permalink: Plants,
          path: "/buckets/Plants.json",
          created_at: "2009-10-02T12:00:00Z",
          updated_at: "2009-10-02T12:00:00Z"
        }
      }
    """
    
  Scenario: Read a non-existing bucket
    When I GET "/buckets/not-there.json"
    Then I should get a 404 Not Found response
     
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
    When I PUT "/buckets/dinosaurs.json" with body ""
    Then I should get a 201 Created response
  
  Scenario: Update a bucket
    When I PUT "/buckets/Animals.json" with body "bucket[permalink]=Nice Animals"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        bucket:{
          permalink: "Nice Animals",
          path: "/buckets/Animals.json",
          created_at: "2009-10-01T12:00:00Z",
          updated_at: "2009-09-09T12:00:00Z"
        }
      }
    """
  
  Scenario: Destroy a bucket
    When I DELETE "/buckets/Animals.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      bucket: {
        permalink: Animals,
        path: "/buckets/Animals.json",
        created_at: "2009-10-01T12:00:00Z",
        updated_at: "2009-10-01T12:00:00Z"
      }
    """