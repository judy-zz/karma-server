Feature: Buckets via JSON
  In order to query and manage buckets,
  As a client
  I want to be able to read and modify bucket resources via JSON.
  
  Background:
    Given a client with hostname "jimjim" and api key "123456789ABCDEFG"
    And I log in as "" with password "123456789ABCDEFG"
    And the following buckets:
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
          "path":null,
          "updated_at":null,
          "created_at":null
        }
      }
    """
  
  Scenario: Create a bucket
    When I PUT "/buckets/dinosaurs.json" with body ""
    Then I should get a 201 Created response
  
  Scenario: Attempt to create a bucket with a blank permalink
    When I PUT "/buckets/doesnt-exist.json" with body "bucket[permalink]="
    Then I should get a 422 Unprocessible Entity response
  
  Scenario: Attempt to Create a bucket with a period in the permalink
    When I PUT "/buckets/animals.json" with body "bucket[permalink]='matt.simpson'"
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"]
      ]
    """
  
  Scenario: Attempt to Create a bucket with a backslash in the permalink
    When I PUT "/buckets/animals.json" with body "bucket[permalink]='matt/simpson'"
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Attempt to Create a bucket with a period and a slash
    When I PUT "/buckets/animals.json" with body "bucket[permalink]='matt.simp/son'"
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"],
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Attempt to Create a bucket with "index" as the permalink
    When I PUT "/buckets/index.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a bucket with "new" as the permalink
    When I PUT "/buckets/new.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a bucket with "create" as the permalink
    When I PUT "/buckets/create.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a bucket with "show" as the permalink
    When I PUT "/buckets/show.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a bucket with "edit" as the permalink
    When I PUT "/buckets/edit.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a bucket with "update" as the permalink
    When I PUT "/buckets/update.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Update a bucket
    When I PUT "/buckets/Animals.json" with body "bucket[permalink]=Nice Animals"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        bucket:{
          permalink: "Nice Animals",
          path: "/buckets/Nice%20Animals.json",
          created_at: "2009-10-01T12:00:00Z",
          updated_at: "2009-09-09T12:00:00Z"
        }
      }
    """
  
  Scenario: Attempt to Update a bucket with a period
    Given a bucket "animals"
    When I PUT "/buckets/animals.json" with body "bucket[permalink]=animals.insects"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"]
      ]
    """
  
  Scenario: Attempt to Update a bucket with a slash
    Given a bucket "animals"
    When I PUT "/buckets/animals.json" with body "bucket[permalink]=animals/tigers/bears/ohmy"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Attempt to Update a bucket with a period and a slash
    Given a bucket "animals"
    When I PUT "/buckets/animals.json" with body "bucket[permalink]=animals.inse/cts"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"],
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Attempt to Update a bucket with "index" as the permalink
    Given a bucket "animals"
    When I PUT "/buckets/animals.json" with body "bucket[permalink]=index"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a bucket with "new" as the permalink
    Given a bucket "animals"
    When I PUT "/buckets/animals.json" with body "bucket[permalink]=new"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a bucket with "create" as the permalink
    Given a bucket "animals"
    When I PUT "/buckets/animals.json" with body "bucket[permalink]=create"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a bucket with "show" as the permalink
    Given a bucket "animals"
    When I PUT "/buckets/animals.json" with body "bucket[permalink]=show"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a bucket with "edit" as the permalink
    Given a bucket "animals"
    When I PUT "/buckets/animals.json" with body "bucket[permalink]=edit"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a bucket with "update" as the permalink
    Given a bucket "animals"
    When I PUT "/buckets/animals.json" with body "bucket[permalink]=update"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
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
  