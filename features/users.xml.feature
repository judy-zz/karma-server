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
        <path>/users/bob.xml</path>
        <permalink>bob</permalink>
        <updated-at type="datetime">2009-10-01T12:00:00Z</updated-at>
      </user>
    """
    
  Scenario: Get a non-existent user
    Given a user "bob"
    When I GET "/users/not-there.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
    
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
    When I GET "/users/bob/adjustments.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <adjustments type="array">
        <adjustment>
          <created-at type="datetime">2009-09-10T15:06:25Z</created-at>
          <bucket-permalink>plants</bucket-permalink>
          <updated-at type="datetime">2009-09-10T15:06:25Z</updated-at>
          <user-permalink>bob</user-permalink>
          <id type="integer">1</id>
          <value type="integer">1</value>
          <path>/users/bob/buckets/plants/adjustments/1.xml</path>
        </adjustment>
        <adjustment>
          <created-at type="datetime">2009-09-10T15:06:25Z</created-at>
          <bucket-permalink>animals</bucket-permalink>
          <updated-at type="datetime">2009-09-10T15:06:25Z</updated-at>
          <user-permalink>bob</user-permalink>
          <id type="integer">3</id>
          <value type="integer">3</value>
          <path>/users/bob/buckets/animals/adjustments/3.xml</path>
        </adjustment>
        <adjustment>
          <created-at type="datetime">2009-09-10T15:06:32Z</created-at>
          <bucket-permalink>plants</bucket-permalink>
          <updated-at type="datetime">2009-09-10T15:06:32Z</updated-at>
          <user-permalink>bob</user-permalink>
          <id type="integer">2</id>
          <value type="integer">2</value>
          <path>/users/bob/buckets/plants/adjustments/2.xml</path>
        </adjustment>
      </adjustments>
    """
    
  Scenario: Get a user's karma
    Given a user "bob"
    And a bucket "plants"
    And a bucket "animals"
    When I GET "/users/bob/karma.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <karma>
        <total type="integer">0</total>
        <user-path>/users/bob.xml</user-path>
        <buckets>
          <animals>
            <adjustments-path>/users/bob/buckets/animals/adjustments.xml</adjustments-path>
            <bucket-path>/buckets/animals.xml</bucket-path>
            <total type="integer">0</total>
          </animals>
          <plants>
            <adjustments-path>/users/bob/buckets/plants/adjustments.xml</adjustments-path>
            <bucket-path>/buckets/plants.xml</bucket-path>
            <total type="integer">0</total>
          </plants>
        </buckets>
        <user>bob</user>
      </karma>
    """