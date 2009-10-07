Feature: Users via JSON
  In order to manage the representation of users of the web applications,
  As a client
  I want to be able to create, read, update, and delete User objects via JSON.
  
  Scenario: Create a user
    When I PUT "/users/bob.json" with body ""
    Then I should get a 201 Created response
  
  Scenario: Attempt to create a user with a blank permalink
    When I PUT "/users/bob.json" with body "user[permalink]="
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be blank"]
      ]
    """
  
  Scenario: Attempt to create a user with a period in the permalink
    When I PUT "/users/bob.json" with body "user[permalink]='matt.simpson'"
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"]
      ]
    """
  
  Scenario: Attempt to create a user with a backslash in the permalink
    When I PUT "/users/bob.json" with body "user[permalink]=matt/simpson"
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Recreate a user
    Given a user "bob"
    When I PUT "/users/bob.json" with body ""
    Then I should get a 200 OK response
  
  Scenario: Read a user
    Given the following users:
      | id | permalink | created_at          | updated_at          |
      | 1  | bob       | 2009-10-01 12:00:00 | 2009-10-01 12:00:00 | 
      | 2  | harry     | 2009-10-01 12:00:00 | 2009-10-01 12:00:00 | 
    When I GET "/users/bob.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        user: {
          permalink: bob,
          path: /users/bob.json,
          created_at: "2009-10-01T12:00:00Z",
          updated_at: "2009-10-01T12:00:00Z"
        }
      }
    """
  
  Scenario: Get a non-existent user
    Given a user "bob"
    When I GET "/users/not-there.json"
    Then I should get a 404 Not Found response
  
  Scenario: Get a user's adjustments
    Given the following users:
      | id  | permalink      | created_at              | updated_at              |
      | 1   | bob            | 2009-09-10 19:55:35 UTC | 2009-09-10 19:55:35 UTC |
    And the following buckets:
      | id | permalink  | created_at              | updated_at              |
      | 1  | plants     | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
      | 2  | animals    | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
    And the following adjustments:
      | id | user_id | bucket_id | value | created_at              | updated_at              |
      | 1  | 1       | 1         | 1     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
      | 2  | 1       | 1         | 2     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
      | 3  | 1       | 2         | 3     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
    When I GET "/users/bob/adjustments.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """    
      [
        {
          adjustment: {
            value: 1,
            path: "/users/bob/buckets/plants/adjustments/1.json",
            user_permalink: bob,
            id: 1,
            bucket_permalink: plants,
            created_at: "2009-09-10T15:06:25Z",
            updated_at: "2009-09-10T15:06:25Z"
          }
        },
        {
          adjustment: {
            value: 3,
            path: "/users/bob/buckets/animals/adjustments/3.json",
            user_permalink: bob,
            id: 3,
            bucket_permalink: animals,
            created_at: "2009-09-10T15:06:25Z",
            updated_at: "2009-09-10T15:06:25Z"
          }
        },
        {
          adjustment: {
            value: 2,
            path: "/users/bob/buckets/plants/adjustments/2.json",
            user_permalink: bob,
            id: 2,
            bucket_permalink: plants,
            created_at: "2009-09-10T15:06:32Z",
            updated_at: "2009-09-10T15:06:32Z"
          }
        }
      ]
    """
  
  Scenario: Get a user's karma
    Given a user "bob"
    And a bucket "plants"
    And a bucket "animals"
    When I GET "/users/bob/karma.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        user: bob,
        user_path: /users/bob.json,
        total: 0,
        buckets: {
          plants: {
            total: 0,
            bucket_path: /buckets/plants.json,
            adjustments_path: /users/bob/buckets/plants/adjustments.json
          },
          animals: {
            total: 0,
            bucket_path: /buckets/animals.json,
            adjustments_path: /users/bob/buckets/animals/adjustments.json
          }
        }
      }
    """
  

  # Scenario: Attempt to Create a user via POST
  # Scenario: Attempt to Create a user with a period and a slash
  # Scenario: Attempt to Create a user with "index" as the permalink
  # Scenario: Attempt to Create a user with "new" as the permalink
  # Scenario: Attempt to Create a user with "create" as the permalink
  # Scenario: Attempt to Create a user with "show" as the permalink
  # Scenario: Attempt to Create a user with "edit" as the permalink
  # Scenario: Get a non-existing user's adjustments
  # Scenario: Get a non-existing user's karma
  # Scenario: Update a user's permalink
  # Scenario: Update a non-existing user's permalink
  # Scenario: Attempt to Update a user with a a period and a slash
  # Scenario: Attempt to Update a user with "index" as the permalink
  # Scenario: Attempt to Update a user with "new" as the permalink
  # Scenario: Attempt to Update a user with "create" as the permalink
  # Scenario: Attempt to Update a user with "show" as the permalink
  # Scenario: Attempt to Update a user with "edit" as the permalink
  # Scenario: Attempt to Edit a user
  # Scenario: Get a new user
  # Scenario: Get a list of users
  # Scenario: Get a list of users when there are none
  # Scenario: Destroy a user
  # Scenario: Attempt to Destroy a non-existent user