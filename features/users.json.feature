Feature: Users via JSON
  In order to manage the representation of users of the web applications,
  As a client
  I want to be able to create, read, update, and delete User objects via JSON.

  Scenario: Get a list of users
    Given the following users:
      | id | permalink | created_at          | updated_at          |
      | 1  | bob       | 2009-09-09 12:00:00 | 2009-09-09 12:00:00 | 
      | 2  | harry     | 2009-09-09 12:00:00 | 2009-09-09 12:00:00 | 
    When I GET "/users.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      [{
        user: {
          permalink: bob,
          path: /users/bob.json,
          created_at: "2009-09-09T12:00:00Z",
          updated_at: "2009-09-09T12:00:00Z"
        }},
        {user: {
          permalink: harry,
          path: /users/harry.json,
          created_at: "2009-09-09T12:00:00Z",
          updated_at: "2009-09-09T12:00:00Z"
        }
      }]    
    """
  
  Scenario: Get a list of users when there are none
    When I GET "/users.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      []
    """
  
  Scenario: Get a new user
    When I GET "/users/new.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        "user":{
          "permalink":null,
          "updated_at":null,
          "path":null,
          "created_at":null
        }
      }
    """
  
  Scenario: Create a user
    When I PUT "/users/bob.json" with body ""
    Then I should get a 201 Created response
    And I should get a JSON response body like:
    """
      {
        user: {
          permalink: bob,
          path: /users/bob.json,
          created_at: "2009-09-09T12:00:00Z",
          updated_at: "2009-09-09T12:00:00Z"
        }
      }
    """
  
  Scenario: Recreate a user
    Given a user "bob"
    When I PUT "/users/bob.json" with body ""
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        user: {
          permalink: bob,
          path: /users/bob.json,
          created_at: "2009-09-09T12:00:00Z",
          updated_at: "2009-09-09T12:00:00Z"
        }
      }
    """
  
  Scenario: Attempt to Create a user via POST
    When I POST "/users.json" with body "user[permalink]=joebilly"
    Then I should get a 404 Not Found response
    And I should get a blank response body
  
  Scenario: Attempt to Create a user with a blank permalink
    When I PUT "/users/bob.json" with body "user[permalink]="
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be blank"]
      ]
    """
  
  Scenario: Attempt to Create a user with a period in the permalink
    When I PUT "/users/bob.json" with body "user[permalink]='matt.simpson'"
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"]
      ]
    """
  
  Scenario: Attempt to Create a user with a backslash in the permalink
    When I PUT "/users/bob.json" with body "user[permalink]='matt/simpson'"
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Attempt to Create a user with a period and a slash
    When I PUT "/users/bob.json" with body "user[permalink]='matt.simp/son'"
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"],
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Attempt to Create a user with "index" as the permalink
    When I PUT "/users/index.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a user with "new" as the permalink
    When I PUT "/users/new.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a user with "create" as the permalink
    When I PUT "/users/create.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a user with "show" as the permalink
    When I PUT "/users/show.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a user with "edit" as the permalink
    When I PUT "/users/edit.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a user with "update" as the permalink
    When I PUT "/users/update.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
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
    And I should get a blank response body
  
  Scenario: Attempt to get the edit template for a user
    Given a user "bob"
    When I GET "/users/bob/edit.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Update a user's permalink
    Given a user "bob"
    When I PUT "/users/bob.json" with body "user[permalink]=joe"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        user: {
          permalink: joe,
          path: /users/joe.json,
          created_at: "2009-09-09T12:00:00Z",
          updated_at: "2009-09-09T12:00:00Z"
        }
      }
    """
  
  Scenario: Attempt to Update a user with a period
    Given a user "joe"
    When I PUT "/users/joe.json" with body "user[permalink]=joe.shmoe"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"]
      ]
    """
  
  Scenario: Attempt to Update a user with a slash
    Given a user "joe"
    When I PUT "/users/joe.json" with body "user[permalink]=joe/shmoe"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Attempt to Update a user with a period and a slash
    Given a user "joe"
    When I PUT "/users/joe.json" with body "user[permalink]=joe.shm/oe"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"],
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Attempt to Update a user with "index" as the permalink
    Given a user "joe"
    When I PUT "/users/joe.json" with body "user[permalink]=index"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a user with "new" as the permalink
    Given a user "joe"
    When I PUT "/users/joe.json" with body "user[permalink]=new"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a user with "create" as the permalink
    Given a user "joe"
    When I PUT "/users/joe.json" with body "user[permalink]=create"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a user with "show" as the permalink
    Given a user "joe"
    When I PUT "/users/joe.json" with body "user[permalink]=show"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a user with "edit" as the permalink
    Given a user "joe"
    When I PUT "/users/joe.json" with body "user[permalink]=edit"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a user with "update" as the permalink
    Given a user "joe"
    When I PUT "/users/joe.json" with body "user[permalink]=update"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
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
  
  Scenario: Get a non-existing user's adjustments
    When I GET "/users/maximus/adjustments.json"
    Then I should get a 404 Not Found response
    And I should get a blank response body
  
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
  
  Scenario: Get a non-existing user's karma
    When I GET "/users/maximus/karma.json"
    Then I should get a 404 Not Found response
    And I should get a blank response body
  
  Scenario: Destroy a user
    Given a user "bob"
    When I DELETE "/users/bob.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        user: {
          permalink: bob,
          path: /users/bob.json,
          created_at: "2009-09-09T12:00:00Z",
          updated_at: "2009-09-09T12:00:00Z"
        }
      }
    """
    When I GET "/users/bob.json"
    Then I should get a 404 Not Found response
    And I should get a blank response body
  
  Scenario: Attempt to Destroy a non-existent user
    When I DELETE "/users/bob.json"
    Then I should get a 404 Not Found response
    And I should get a blank response body
  