Feature: Tags via XML
  In order to query and manage tags,
  As a client
  I want to be able to read and modify tag resources via XML.
  
  Background:
    Given the following websites:
      | id | name      | url                   | created_at          | updated_at          |
      | 1  | plants    | http://www.plants.com | 2009-10-01 12:00:00 | 2009-10-01 12:00:00 |
    And a client with hostname "jimjim", api key "123456789ABCDEFG", and website "plants"
    And I log in as "" with password "123456789ABCDEFG"
    And the following tags:
      | id | permalink | website_id | created_at          | updated_at          |
      | 1  | Animals   | 1          | 2009-10-01 12:00:00 | 2009-10-01 12:00:00 | 
      | 2  | Plants    | 1          | 2009-10-02 12:00:00 | 2009-10-02 12:00:00 | 
      | 3  | Comments  | nil        | 2009-10-02 12:00:00 | 2009-10-02 12:00:00 | 
    And I have a user with attributes permalink "bob" and id "1"

  Scenario: Read list of tags
    When I GET "/tags.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <tags type="array">
        <tag>
          <created-at type="datetime">2009-10-01T12:00:00Z</created-at>
          <path>/tags/Animals.xml</path>
          <permalink>Animals</permalink>
          <updated-at type="datetime">2009-10-01T12:00:00Z</updated-at>
        </tag>
        <tag>
          <created-at type="datetime">2009-10-02T12:00:00Z</created-at>
          <path>/tags/karma:Comments.xml</path>
          <permalink>karma:Comments</permalink>
          <updated-at type="datetime">2009-10-02T12:00:00Z</updated-at>
        </tag>
        <tag>
          <created-at type="datetime">2009-10-02T12:00:00Z</created-at>
          <path>/tags/Plants.xml</path>
          <permalink>Plants</permalink>
          <updated-at type="datetime">2009-10-02T12:00:00Z</updated-at>
        </tag>
      </tags>
    """
  
  Scenario: Read list of tags when there are no tags
    Given there are no tags
    When I GET "/tags.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <tags type="array"/>
    """
  
  Scenario: Read a tag
    When I GET "/tags/Plants.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <tag>
        <created-at type="datetime">2009-10-02T12:00:00Z</created-at>
        <path>/tags/Plants.xml</path>
        <permalink>Plants</permalink>
        <updated-at type="datetime">2009-10-02T12:00:00Z</updated-at>
      </tag>
    """
  
  Scenario: Read a non-existing tag
    When I GET "/tags/not-there.xml"
    Then I should get a 404 Not Found response
  
  Scenario: Request a new tag
    When I GET "/tags/new.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <tag>
        <created-at type="datetime" nil="true"></created-at>
        <path nil="true"></path>
        <permalink nil="true"></permalink>
        <updated-at type="datetime" nil="true"></updated-at>
      </tag>
    """
  
  Scenario: Create a tag
    When I PUT "/tags/dinosaurs.xml" with body ""
    Then I should get a 201 Created response
  
  Scenario: Attempt to create a tag with an invalid permalink
    When I PUT "/tags/doesnt-exist.xml" with body "tag[permalink]="
    Then I should get a 422 Unprocessable Entity response
  
  
  
  Scenario: Attempt to Create a tag with a period in the permalink
    When I PUT "/tags/animals.xml" with body "tag[permalink]=jo.e"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't have a period</error>
      </errors>
    """
  
  Scenario: Attempt to Create a tag with a backslash in the permalink
    When I PUT "/tags/animals.xml" with body "tag[permalink]=jo/e"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't have a slash</error>
      </errors>
    """
  
  Scenario: Attempt to Create a tag with a period and a slash
    When I PUT "/tags/animals.xml" with body "tag[permalink]=j.o/e"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't have a period</error>
        <error>Permalink can't have a slash</error>
      </errors>
    """
  
  Scenario: Attempt to Create a tag with "index" as the permalink
    When I PUT "/tags/index.xml"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't be index, new, create, edit, update or show</error>
      </errors>
    """
  
  Scenario: Attempt to Create a tag with "new" as the permalink
    When I PUT "/tags/new.xml"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't be index, new, create, edit, update or show</error>
      </errors>
    """
  
  Scenario: Attempt to Create a tag with "create" as the permalink
    When I PUT "/tags/create.xml"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't be index, new, create, edit, update or show</error>
      </errors>
    """
  
  Scenario: Attempt to Create a tag with "show" as the permalink
    When I PUT "/tags/show.xml"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't be index, new, create, edit, update or show</error>
      </errors>
    """
  
  Scenario: Attempt to Create a tag with "edit" as the permalink
    When I PUT "/tags/edit.xml"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't be index, new, create, edit, update or show</error>
      </errors>
    """
  
  Scenario: Attempt to Create a tag with "update" as the permalink
    When I PUT "/tags/update.xml"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't be index, new, create, edit, update or show</error>
      </errors>
    """
  
  Scenario: Attempt to Update a tag with a period
    Given a tag "animals"
    When I PUT "/tags/animals.xml" with body "tag[permalink]=inse.cts"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't have a period</error>
      </errors>
    """
  
  Scenario: Attempt to Update a tag with a slash
    Given a tag "animals"
    When I PUT "/tags/animals.xml" with body "tag[permalink]=insects/tigers/bears"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't have a slash</error>
      </errors>
    """
  
  Scenario: Attempt to Update a tag with a period and a slash
    Given a tag "animals"
    When I PUT "/tags/animals.xml" with body "tag[permalink]=in.se/cts"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't have a period</error>
        <error>Permalink can't have a slash</error>
      </errors>
    """
  
  Scenario: Attempt to Update a tag with "index" as the permalink
    Given a tag "animals"
    When I PUT "/tags/animals.xml" with body "tag[permalink]=index"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't be index, new, create, edit, update or show</error>
      </errors>
    """
  
  Scenario: Attempt to Update a tag with "new" as the permalink
    Given a tag "animals"
    When I PUT "/tags/animals.xml" with body "tag[permalink]=new"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't be index, new, create, edit, update or show</error>
      </errors>
    """
  
  Scenario: Attempt to Update a tag with "create" as the permalink
    Given a tag "animals"
    When I PUT "/tags/animals.xml" with body "tag[permalink]=create"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't be index, new, create, edit, update or show</error>
      </errors>
    """
  
  Scenario: Attempt to Update a tag with "show" as the permalink
    Given a tag "animals"
    When I PUT "/tags/animals.xml" with body "tag[permalink]=show"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't be index, new, create, edit, update or show</error>
      </errors>
    """
  
  Scenario: Attempt to Update a tag with "edit" as the permalink
    Given a tag "animals"
    When I PUT "/tags/animals.xml" with body "tag[permalink]=edit"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't be index, new, create, edit, update or show</error>
      </errors>
    """
  
  Scenario: Attempt to Update a tag with "update" as the permalink
    Given a tag "animals"
    When I PUT "/tags/animals.xml" with body "tag[permalink]=update"
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Permalink can't be index, new, create, edit, update or show</error>
      </errors>
    """
  

  
  
  
  
  Scenario: Recreate a tag
    Given a tag "exists"
    When I PUT "/tags/exists.json" with body ""
    Then I should get a 200 OK response
  
  Scenario: Update a tag
    When I PUT "/tags/Animals.xml" with body "tag[permalink]=NiceAnimals"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <tag>
        <created-at type="datetime">2009-10-01T12:00:00Z</created-at>
        <path>/tags/NiceAnimals.xml</path>
        <permalink>NiceAnimals</permalink>
        <updated-at type="datetime">2009-09-09T12:00:00Z</updated-at>
      </tag>
    """
  
  # Scenario: Attempt to update tag with other invalid permalinks
  Scenario: Destroy a tag
    When I DELETE "/tags/Animals.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <tag>
        <created-at type="datetime">2009-10-01T12:00:00Z</created-at>
        <path>/tags/Animals.xml</path>
        <permalink>Animals</permalink>
        <updated-at type="datetime">2009-10-01T12:00:00Z</updated-at>
      </tag>
    """
  