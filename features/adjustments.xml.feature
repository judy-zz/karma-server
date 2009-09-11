Feature: Adjustments via XML
  In order to modify and report on karma
  As a client
  I want to be able to read and manipulate user's karma via the XML API

  Background:
    Given the following users:
      | id  | permalink      | created_at              | updated_at              |
      | 1   | bob            | 2009-09-10 19:55:35 UTC | 2009-09-10 19:55:35 UTC |
      | 2   | harry          | 2009-09-10 13:57:01 UTC | 2009-09-10 13:57:01 UTC |
    And the following buckets:
      | id | name       | created_at              | updated_at              |
      | 3  | plants     | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
      | 4  | animals    | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
    And the following adjustments:
      | id | user_id | bucket_id | value | created_at              | updated_at              |
      | 5  | 1       | 3         | 1     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
      | 6  | 1       | 4         | 2     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
      | 7  | 2       | 3         | 3     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
      | 8  | 2       | 4         | 4     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
      | 9  | 2       | 4         | -1    | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |

  Scenario: Read adjustments
    When I GET "/users/harry/buckets/animals/adjustments.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <adjustments type="array">
        <adjustment>
          <bucket-id type="integer">4</bucket-id>
          <created-at type="datetime">2009-09-10T15:06:32Z</created-at>
          <id type="integer">8</id>
          <updated-at type="datetime">2009-09-10T15:06:32Z</updated-at>
          <user-id type="integer">2</user-id>
          <value type="integer">4</value>
        </adjustment>
        <adjustment>
          <bucket-id type="integer">4</bucket-id>
          <created-at type="datetime">2009-09-10T15:06:32Z</created-at>
          <id type="integer">9</id>
          <updated-at type="datetime">2009-09-10T15:06:32Z</updated-at>
          <user-id type="integer">2</user-id>
          <value type="integer">-1</value>
        </adjustment>
      </adjustments>
    """
