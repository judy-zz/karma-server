Feature: Tags via JSON
  In order to query and manage tags,
  As a client
  I want to be able to read and modify tag resources via JSON.
  
  Background:
    Given a client with hostname "jimjim" and api key "123456789ABCDEFG"
    And I log in as "" with password "123456789ABCDEFG"
    And the following tags:
      | id | permalink | website_id | created_at          | updated_at          |
      | 1  | Animals   | 1          | 2009-10-01 12:00:00 | 2009-10-01 12:00:00 | 
      | 2  | Plants    | 1          | 2009-10-02 12:00:00 | 2009-10-02 12:00:00 | 
    And I have a user with attributes permalink "bob" and id "1"
    And a website "plants"
  
  Scenario: Read list of tags
    When I GET "/tags.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      [{
        tag: {
          permalink: Animals,
          path: "/tags/Animals.json",
          created_at: "2009-10-01T12:00:00Z",
          updated_at: "2009-10-01T12:00:00Z"
        }},
        {tag: {
          permalink: Plants,
          path: "/tags/Plants.json",
          created_at: "2009-10-02T12:00:00Z",
          updated_at: "2009-10-02T12:00:00Z"
        }
      }]
    """
  
  Scenario: Read list of tags when there are no tags
    Given there are no tags
    When I GET "/tags.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      []
    """
  
  Scenario: Read a tag
    When I GET "/tags/Plants.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        tag: {
          permalink: Plants,
          path: "/tags/Plants.json",
          created_at: "2009-10-02T12:00:00Z",
          updated_at: "2009-10-02T12:00:00Z"
        }
      }
    """
  
  Scenario: Read a non-existing tag
    When I GET "/tags/not-there.json"
    Then I should get a 404 Not Found response
  
  Scenario: Request a new tag
    When I GET "/tags/new.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        "tag":{
          "permalink":"",
          "path":null,
          "updated_at":null,
          "created_at":null
        }
      }
    """
  
  Scenario: Create a tag
    When I PUT "/tags/dinosaurs.json" with body ""
    Then I should get a 201 Created response
  
  Scenario: Attempt to create a tag with a blank permalink
    When I PUT "/tags/doesnt-exist.json" with body "tag[permalink]="
    Then I should get a 422 Unprocessible Entity response
  
  Scenario: Attempt to Create a tag with a period in the permalink
    When I PUT "/tags/animals.json" with body "tag[permalink]='matt.simpson'"
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"]
      ]
    """
  
  Scenario: Attempt to Create a tag with a backslash in the permalink
    When I PUT "/tags/animals.json" with body "tag[permalink]='matt/simpson'"
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Attempt to Create a tag with a period and a slash
    When I PUT "/tags/animals.json" with body "tag[permalink]='matt.simp/son'"
    Then I should get a 422 Unprocessible Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"],
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Attempt to Create a tag with "index" as the permalink
    When I PUT "/tags/index.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a tag with "new" as the permalink
    When I PUT "/tags/new.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a tag with "create" as the permalink
    When I PUT "/tags/create.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a tag with "show" as the permalink
    When I PUT "/tags/show.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a tag with "edit" as the permalink
    When I PUT "/tags/edit.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Create a tag with "update" as the permalink
    When I PUT "/tags/update.json"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Update a tag
    When I PUT "/tags/Animals.json" with body "tag[permalink]=Nice Animals"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        tag:{
          permalink: "Nice Animals",
          path: "/tags/Nice%20Animals.json",
          created_at: "2009-10-01T12:00:00Z",
          updated_at: "2009-09-09T12:00:00Z"
        }
      }
    """
  
  Scenario: Attempt to Update a tag with a period
    Given a tag "animals"
    When I PUT "/tags/animals.json" with body "tag[permalink]=animals.insects"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"]
      ]
    """
  
  Scenario: Attempt to Update a tag with a slash
    Given a tag "animals"
    When I PUT "/tags/animals.json" with body "tag[permalink]=animals/tigers/bears/ohmy"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Attempt to Update a tag with a period and a slash
    Given a tag "animals"
    When I PUT "/tags/animals.json" with body "tag[permalink]=animals.inse/cts"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't have a period"],
        ["permalink","can't have a slash"]
      ]
    """
  
  Scenario: Attempt to Update a tag with "index" as the permalink
    Given a tag "animals"
    When I PUT "/tags/animals.json" with body "tag[permalink]=index"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a tag with "new" as the permalink
    Given a tag "animals"
    When I PUT "/tags/animals.json" with body "tag[permalink]=new"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a tag with "create" as the permalink
    Given a tag "animals"
    When I PUT "/tags/animals.json" with body "tag[permalink]=create"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a tag with "show" as the permalink
    Given a tag "animals"
    When I PUT "/tags/animals.json" with body "tag[permalink]=show"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a tag with "edit" as the permalink
    Given a tag "animals"
    When I PUT "/tags/animals.json" with body "tag[permalink]=edit"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Attempt to Update a tag with "update" as the permalink
    Given a tag "animals"
    When I PUT "/tags/animals.json" with body "tag[permalink]=update"
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["permalink","can't be index, new, create, edit, update or show"]
      ]
    """
  
  Scenario: Destroy a tag
    When I DELETE "/tags/Animals.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      tag: {
        permalink: Animals,
        path: "/tags/Animals.json",
        created_at: "2009-10-01T12:00:00Z",
        updated_at: "2009-10-01T12:00:00Z"
      }
    """
  