Feature: Buckets via XML
  In order to query and manage buckets,
  As a client
  I want to be able to read and modify bucket resources via XML.
  
  Background:
    Given the following buckets:
      | id | permalink | created_at          | updated_at          |
      | 1  | Animals   | 2009-10-01 12:00:00 | 2009-10-01 12:00:00 | 
      | 2  | Plants    | 2009-10-02 12:00:00 | 2009-10-02 12:00:00 | 
    And I have a user with attributes permalink "bob" and id "1"

  Scenario: Read list of buckets
    When I GET "/buckets.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <buckets type="array">
        <bucket>
          <created-at type="datetime">2009-10-01T12:00:00Z</created-at>
          <path>/buckets/Animals.xml</path>
          <permalink>Animals</permalink>
          <updated-at type="datetime">2009-10-01T12:00:00Z</updated-at>
        </bucket>
        <bucket>
          <created-at type="datetime">2009-10-02T12:00:00Z</created-at>
          <path>/buckets/Plants.xml</path>
          <permalink>Plants</permalink>
          <updated-at type="datetime">2009-10-02T12:00:00Z</updated-at>
        </bucket>
      </buckets>
    """
    
  Scenario: Read list of buckets when there are no buckets
    Given there are no buckets
    When I GET "/buckets.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <buckets type="array"/>
    """
    
  Scenario: Read a bucket
    When I GET "/buckets/Plants.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <bucket>
        <created-at type="datetime">2009-10-02T12:00:00Z</created-at>
        <path>/buckets/Plants.xml</path>
        <permalink>Plants</permalink>
        <updated-at type="datetime">2009-10-02T12:00:00Z</updated-at>
      </bucket>
    """
    
  Scenario: Read a non-existing bucket
    When I GET "/buckets/not-there.xml"
    Then I should get a 404 Not Found response
     
  Scenario: Request a new bucket
    When I GET "/buckets/new.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <bucket>
        <created-at type="datetime" nil="true"></created-at>
        <path nil="true"></path>
        <permalink nil="true"></permalink>
        <updated-at type="datetime" nil="true"></updated-at>
      </bucket>
    """
  
  Scenario: Create a bucket
    When I PUT "/buckets/dinosaurs.xml" with body ""
    Then I should get a 201 Created response

  Scenario: Recreate a user
    Given a bucket "exists"
    When I PUT "/buckets/exists.json" with body ""
    Then I should get a 200 OK response
  
  Scenario: Update a bucket
    When I PUT "/buckets/Animals.xml" with body "bucket[permalink]=Nice Animals"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <bucket>
        <created-at type="datetime">2009-10-01T12:00:00Z</created-at>
        <path>/buckets/Nice%20Animals.xml</path>
        <permalink>Nice Animals</permalink>
        <updated-at type="datetime">2009-09-09T12:00:00Z</updated-at>
      </bucket>
    """
  
  Scenario: Destroy a bucket
    When I DELETE "/buckets/Animals.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <bucket>
        <created-at type="datetime">2009-10-01T12:00:00Z</created-at>
        <path>/buckets/Animals.xml</path>
        <permalink>Animals</permalink>
        <updated-at type="datetime">2009-10-01T12:00:00Z</updated-at>
      </bucket>
    """