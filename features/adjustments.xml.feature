Feature: Adjustments via XML
  In order to modify and report on karma
  As a client
  I want to be able to read and manipulate user's karma via the XML API
  
  # This is the typical set of adjustments, buckets, and users that is 
  # referenced in some scenarios below:
  # 
  # Background:
  #     Given the following users:
  #       | id  | permalink      | created_at              | updated_at              |
  #       | 1   | bob            | 2009-09-10 19:55:35 UTC | 2009-09-10 19:55:35 UTC |
  #       | 2   | harry          | 2009-09-10 13:57:01 UTC | 2009-09-10 13:57:01 UTC |
  #     And the following buckets:
  #       | id | permalink  | created_at              | updated_at              |
  #       | 3  | plants     | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
  #       | 4  | animals    | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
  #     And the following adjustments:
  #       | id | user_id | bucket_id | value | created_at              | updated_at              |
  #       | 5  | 1       | 3         | 1     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
  #       | 6  | 1       | 4         | 2     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
  #       | 7  | 2       | 3         | 3     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
  #       | 8  | 2       | 4         | 4     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
  #       | 9  | 2       | 4         | -1    | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |

  Scenario: Read list of adjustments
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/animals/adjustments.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <adjustments type="array">
        <adjustment>
          <id type="integer">4</id>
          <value type="integer">4</value>
          <path>/users/harry/buckets/animals/adjustments/4.xml</path>
          <user-permalink>harry</user-permalink>
          <bucket-permalink>animals</bucket-permalink>
          <created-at type="datetime">2009-09-10T15:06:32Z</created-at>
          <updated-at type="datetime">2009-09-10T15:06:32Z</updated-at>
        </adjustment>
        <adjustment>
          <id type="integer">5</id>
          <value type="integer">-1</value>
          <path>/users/harry/buckets/animals/adjustments/5.xml</path>
          <user-permalink>harry</user-permalink>
          <bucket-permalink>animals</bucket-permalink>
          <created-at type="datetime">2009-09-10T15:06:32Z</created-at>
          <updated-at type="datetime">2009-09-10T15:06:32Z</updated-at>
        </adjustment>
      </adjustments>
    """
    
  Scenario: Read a list of adjustments with a non-existing bucket
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/doesnt-exist/adjustments.xml"
    Then I should get a 404 Not Found response
    
  Scenario: Read a list of adjustments with a non-existing user
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/doesnt-exist/buckets/animals/adjustments.xml"
    Then I should get a 404 Not Found response
    
  Scenario: Read a list of adjustments with a non-existing user and bucket
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/doesnt-exist/buckets/doesnt-exist/adjustments.xml"
    Then I should get a 404 Not Found response
    
  Scenario: Read list of adjustments when there are none
    Given a typical set of adjustments, buckets, and users
    And there are no adjustments
    When I GET "/users/harry/buckets/animals/adjustments.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <adjustments type="array"/>
    """
    
  Scenario: Read adjustment
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/animals/adjustments/4.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <adjustment>
          <id type="integer">4</id>
          <value type="integer">4</value>
          <path>/users/harry/buckets/animals/adjustments/4.xml</path>
          <user-permalink>harry</user-permalink>
          <bucket-permalink>animals</bucket-permalink>
          <created-at type="datetime">2009-09-10T15:06:32Z</created-at>
          <updated-at type="datetime">2009-09-10T15:06:32Z</updated-at>
      </adjustment>
    """
    
  Scenario: Read a non-existing adjustment
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/animals/adjustments/300.xml"
    Then I should get a 404 Not Found response
    
  Scenario: Read an adjustment with a non-existing bucket
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/doesnt-exist/adjustments/300.xml"
    Then I should get a 404 Not Found response
    
  Scenario: Read an adjustment with a non-existing user
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/doesnt-exist/buckets/animals/adjustments/300.xml"
    Then I should get a 404 Not Found response
    
  Scenario: Read an adjustment with a non-existing user and bucket
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/doesnt-exist/buckets/doesnt-exist/adjustments/300.xml"
    Then I should get a 404 Not Found response
       
  Scenario: Request a new adjustment
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/animals/adjustments/new.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <adjustment>
        <id type="integer" nil='true'></id>
        <value type="integer" nil='true'></value>
        <path nil='true'></path>
        <user-permalink>harry</user-permalink>
        <bucket-permalink>animals</bucket-permalink>
        <created-at type="datetime" nil='true'></created-at>
        <updated-at type="datetime" nil='true'></updated-at>
      </adjustment>
    """
    
  Scenario: Request a new adjustment with a non-existing bucket
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/doesnt-exist/adjustments/300.xml"
    Then I should get a 404 Not Found response
    
  Scenario: Request a new adjustment with a non-existing user
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/doesnt-exist/buckets/animals/adjustments/300.xml"
    Then I should get a 404 Not Found response
    
  Scenario: Request a new adjustment with a non-existing user and bucket
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/doesnt-exist/buckets/doesnt-exist/adjustments/300.xml"
    Then I should get a 404 Not Found response

  Scenario: Create an adjustment
    Given a typical set of adjustments, buckets, and users
    When I POST "/users/harry/buckets/animals/adjustments.xml" with body "adjustment[value]=2"
    Then I should get a 201 Created response
  
  Scenario: Attempt to create an adjustment with no value
    Given a typical set of adjustments, buckets, and users
    When I POST "/users/harry/buckets/animals/adjustments.xml" with body ""
    Then I should get a 422 Unprocessable Entity response
  
  Scenario: Destroy an adjustment
    Given a typical set of adjustments, buckets, and users
    When I DELETE "/users/harry/buckets/animals/adjustments/4.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <adjustment>
          <id type="integer">4</id>
          <value type="integer">4</value>
          <path>/users/harry/buckets/animals/adjustments/4.xml</path>
          <user-permalink>harry</user-permalink>
          <bucket-permalink>animals</bucket-permalink>
          <created-at type="datetime">2009-09-10T15:06:32Z</created-at>
          <updated-at type="datetime">2009-09-10T15:06:32Z</updated-at>
      </adjustment>
    """
    
  Scenario: Attempt to destroy a non-existing adjustment
    Given a typical set of adjustments, buckets, and users
    When I DELETE "/users/harry/buckets/animals/adjustments/300.xml"
    Then I should get a 404 Not Found response
    
  Scenario: Attempt to destroy an adjustment with a non-existing bucket
    Given a typical set of adjustments, buckets, and users
    When I DELETE "/users/harry/buckets/doesnt-exist/adjustments/300.xml"
    Then I should get a 404 Not Found response
    
  Scenario: Attempt to destroy an adjustment with a non-existing user
    Given a typical set of adjustments, buckets, and users
    When I DELETE "/users/doesnt-exist/buckets/animals/adjustments/300.xml"
    Then I should get a 404 Not Found response
    
  Scenario: Attempt to destroy an adjustment with a non-existing user and bucket
    Given a typical set of adjustments, buckets, and users
    When I DELETE "/users/doesnt-exist/buckets/doesnt-exist/adjustments/300.xml"
    Then I should get a 404 Not Found response