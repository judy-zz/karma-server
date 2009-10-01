Feature: Users via XML
  In order to manage the representation of users of the web applications,
  As a client
  I want to be able to create, read, update, and delete User objects via XML.
  
  Scenario: Create a user
    When I PUT "/users/bob.xml" with body ""
    Then I should get a 201 Created response

  Scenario: Recreate a user
    Given a user "bob"
    When I PUT "/users/bob.xml" with body ""
    Then I should get a 200 OK response

  Scenario: Read a user
    Given the following users:
      | id | permalink | created_at          | updated_at          |
      | 1  | bob       | 2009-10-01 12:00:00 | 2009-10-01 12:00:00 | 
      | 2  | harry     | 2009-10-01 12:00:00 | 2009-10-01 12:00:00 | 
    When I GET "/users/bob.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <user>
        <created-at type="datetime">2009-10-01T12:00:00Z</created-at>
        <id type="integer">1</id>
        <permalink>bob</permalink>
        <updated-at type="datetime">2009-10-01T12:00:00Z</updated-at>
      </user>
    """
    
  Scenario: Get a non-existent user
    Given a user "bob"
    When I GET "/users/not-there.xml"
    Then I should get a 404 Not Found response
    
  Scenario: Get a user's karma
    Given a user "bob"
    And a bucket "plants"
    And a bucket "animals"
    When I GET "/users/bob/karma.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <hash>
        <total type="integer">0</total>
        <user-path>/users/bob.json</user-path>
        <buckets>
          <animals>
            <adjustments-path>/users/bob/buckets/animals/adjustments.json</adjustments-path>
            <bucket-path>/buckets/animals.json</bucket-path>
            <total type="integer">0</total>
          </animals>
          <plants>
            <adjustments-path>/users/bob/buckets/plants/adjustments.json</adjustments-path>
            <bucket-path>/buckets/plants.json</bucket-path>
            <total type="integer">0</total>
          </plants>
        </buckets>
        <user>bob</user>
      </hash>
    """