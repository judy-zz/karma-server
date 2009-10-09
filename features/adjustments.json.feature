Feature: Adjustments via JSON
  In order to modify and report on karma
  As a client
  I want to be able to read and manipulate user's karma via the JSON API

  # This is the typical set of adjustments, buckets, and users that is 
  # referenced in some scenarios below:
  #
  # Given the following users:
  #   | id  | permalink      | created_at              | updated_at              |
  #   | 1   | bob            | 2009-09-10 19:55:35 UTC | 2009-09-10 19:55:35 UTC |
  #   | 2   | harry          | 2009-09-10 13:57:01 UTC | 2009-09-10 13:57:01 UTC |
  # And the following buckets:
  #   | id | permalink  | created_at              | updated_at              |
  #   | 1  | plants     | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
  #   | 2  | animals    | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
  # And the following adjustments:
  #   | id | user_id | bucket_id | value | created_at              | updated_at              |
  #   | 1  | 1       | 1         | 1     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
  #   | 2  | 1       | 2         | 2     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
  #   | 3  | 2       | 1         | 3     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
  #   | 4  | 2       | 2         | 4     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
  #   | 5  | 2       | 2         | -1    | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |

  Scenario: Read list of adjustments
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/animals/adjustments.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """    
      [
        {
          adjustment: {
            id: 4,
            value: 4,
            path: "/users/harry/buckets/animals/adjustments/4.json",
            user_permalink: harry,
            bucket_permalink: animals,
            created_at: "2009-09-10T15:06:32Z",
            updated_at: "2009-09-10T15:06:32Z"
          }
        },
        {
          adjustment: {
            id: 5,
            value: -1,
            path: "/users/harry/buckets/animals/adjustments/5.json",
            user_permalink: harry,
            bucket_permalink: animals,
            created_at: "2009-09-10T15:06:32Z",
            updated_at: "2009-09-10T15:06:32Z"
          }
        }
      ]
    """
  
  Scenario: Read list of adjustments when there are none
    Given a typical set of adjustments, buckets, and users
    And there are no adjustments
    When I GET "/users/harry/buckets/animals/adjustments.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      []
    """
  
  Scenario: Read adjustment
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/animals/adjustments/4.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      adjustment: {
        id: 4,
        value: 4,
        path: "/users/harry/buckets/animals/adjustments/4.json",
        user_permalink: harry,
        bucket_permalink: animals,
        created_at: "2009-09-10T15:06:32Z",
        updated_at: "2009-09-10T15:06:32Z"
      }
    """
  
  Scenario: Read a non-existent adjustment
    When I GET "/users/harry/buckets/animals/adjustments/500.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read a non-existing adjustment
    When I GET "/users/harry/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read an adjustment with a non-existing bucket
    When I GET "/users/harry/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read an adjustment with a non-existing user
    When I GET "/users/doesnt-exist/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read an adjustment with a non-existing user and bucket
    When I GET "/users/doesnt-exist/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Request a new adjustment
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/animals/adjustments/new.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        "adjustment":{
          id: null,
          value: null,
          path: null,
          user_permalink: harry,
          bucket_permalink: animals,
          created_at: null,
          updated_at: null
        }
      }
    """
  
  Scenario: Request a new adjustment with a non-existing bucket
    When I GET "/users/harry/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Request a new adjustment with a non-existing user
    When I GET "/users/doesnt-exist/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Request a new adjustment with a non-existing user and bucket
    When I GET "/users/doesnt-exist/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Create an adjustment
    Given a typical set of adjustments, buckets, and users
    When I POST "/users/harry/buckets/animals/adjustments.json" with body "adjustment[value]=2"
    Then pending: I should get a 201 Created response
    And pending: I should get a JSON response body like:
    """
      "adjustment": {
        id: 6,
        value: 2,
        path: "/users/harry/buckets/animals/adjustments/6.json",
        user_permalink: harry,
        bucket_permalink: animals,
        created_at: "2009-09-09T12:00:00Z",
        updated_at: "2009-09-09T12:00:00Z"
      }
    """
  
  Scenario: Attempt to create an adjustment with no value
    Given a typical set of adjustments, buckets, and users
    When I POST "/users/harry/buckets/animals/adjustments.json" with body ""
    Then I should get a 422 Unprocessable Entity response
    And pending: I should get a JSON response body like:
    """
      [
        ["value","can't be blank"]
      ]
    """
  
  Scenario: Destroy an adjustment
    Given a typical set of adjustments, buckets, and users
    When I DELETE "/users/harry/buckets/animals/adjustments/4.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      "adjustment": {
        id: 4,
        value: 4,
        path: "/users/harry/buckets/animals/adjustments/4.json",
        user_permalink: harry,
        bucket_permalink: animals,
        created_at: "2009-09-10T15:06:32Z",
        updated_at: "2009-09-10T15:06:32Z"
      }
    """
  
  Scenario: Attempt to destroy a non-existing adjustment
    When I DELETE "/users/harry/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
  
  Scenario: Attempt to destroy an adjustment with a non-existing bucket
    When I DELETE "/users/harry/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
  
  Scenario: Attempt to destroy an adjustment with a non-existing user
    When I DELETE "/users/doesnt-exist/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
  
  Scenario: Attempt to destroy an adjustment with a non-existing user and bucket
    When I DELETE "/users/doesnt-exist/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
  