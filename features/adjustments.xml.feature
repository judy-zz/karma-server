Feature: Adjustments via XML
  In order to modify and report on karma
  As a client
  I want to be able to read and manipulate user's karma via the XML API

  Background:
    Given a client with hostname "jimjim" and api key "123456789ABCDEFG"
    And I log in as "" with password "123456789ABCDEFG"
    
  Scenario: Read list of adjustments
    Given a typical set of adjustments, tags, and users
    When I GET "/users/harry/tags/animals/adjustments.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <adjustments type="array">
        <adjustment>
          <id type="integer">104</id>
          <value type="integer">4</value>
          <path>/users/harry/tags/animals/adjustments/104.xml</path>
          <user-permalink>harry</user-permalink>
          <tag-permalink>animals</tag-permalink>
          <created-at type="datetime">2009-09-10T15:06:32Z</created-at>
          <updated-at type="datetime">2009-09-10T15:06:32Z</updated-at>
        </adjustment>
        <adjustment>
          <id type="integer">105</id>
          <value type="integer">-1</value>
          <path>/users/harry/tags/animals/adjustments/105.xml</path>
          <user-permalink>harry</user-permalink>
          <tag-permalink>animals</tag-permalink>
          <created-at type="datetime">2009-09-10T15:06:32Z</created-at>
          <updated-at type="datetime">2009-09-10T15:06:32Z</updated-at>
        </adjustment>
      </adjustments>
    """
  
  Scenario: Read a list of adjustments with a non-existing tag
    Given a typical set of adjustments, tags, and users
    When I GET "/users/harry/tags/doesnt-exist/adjustments.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read a list of adjustments with a non-existing user
    Given a typical set of adjustments, tags, and users
    When I GET "/users/doesnt-exist/tags/animals/adjustments.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read a list of adjustments with a non-existing user and tag
    Given a typical set of adjustments, tags, and users
    When I GET "/users/doesnt-exist/tags/doesnt-exist/adjustments.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read list of adjustments when there are none
    Given a typical set of adjustments, tags, and users
    And there are no adjustments
    When I GET "/users/harry/tags/animals/adjustments.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <adjustments type="array"/>
    """
  
  Scenario: Read adjustment
    Given a typical set of adjustments, tags, and users
    When I GET "/users/harry/tags/animals/adjustments/104.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <adjustment>
          <id type="integer">104</id>
          <value type="integer">4</value>
          <path>/users/harry/tags/animals/adjustments/104.xml</path>
          <user-permalink>harry</user-permalink>
          <tag-permalink>animals</tag-permalink>
          <created-at type="datetime">2009-09-10T15:06:32Z</created-at>
          <updated-at type="datetime">2009-09-10T15:06:32Z</updated-at>
      </adjustment>
    """
  
  Scenario: Read a non-existing adjustment
    Given a typical set of adjustments, tags, and users
    When I GET "/users/harry/tags/animals/adjustments/300.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read an adjustment with a non-existing tag
    Given a typical set of adjustments, tags, and users
    When I GET "/users/harry/tags/doesnt-exist/adjustments/300.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read an adjustment with a non-existing user
    Given a typical set of adjustments, tags, and users
    When I GET "/users/doesnt-exist/tags/animals/adjustments/300.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read an adjustment with a non-existing user and tag
    Given a typical set of adjustments, tags, and users
    When I GET "/users/doesnt-exist/tags/doesnt-exist/adjustments/300.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Request a new adjustment
    Given a typical set of adjustments, tags, and users
    When I GET "/users/harry/tags/animals/adjustments/new.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <adjustment>
        <id type="integer" nil='true'></id>
        <value type="integer" nil='true'></value>
        <path nil='true'></path>
        <user-permalink>harry</user-permalink>
        <tag-permalink>animals</tag-permalink>
        <created-at type="datetime" nil='true'></created-at>
        <updated-at type="datetime" nil='true'></updated-at>
      </adjustment>
    """
  
  Scenario: Request a new adjustment with a non-existing tag
    Given a typical set of adjustments, tags, and users
    When I GET "/users/harry/tags/doesnt-exist/adjustments/300.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Request a new adjustment with a non-existing user
    Given a typical set of adjustments, tags, and users
    When I GET "/users/doesnt-exist/tags/animals/adjustments/300.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Request a new adjustment with a non-existing user and tag
    Given a typical set of adjustments, tags, and users
    When I GET "/users/doesnt-exist/tags/doesnt-exist/adjustments/300.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  # Scenario: Create an adjustment
  #   Given a typical set of adjustments, tags, and users
  #   When I POST "/users/harry/tags/animals/adjustments.xml" with body "adjustment[value]=2"
  #   Then I should get a 201 Created response
  #   And I should get an XML response
  #   And pending: I should receive the object in XML
  
  Scenario: Attempt to create an adjustment with no value
    Given a typical set of adjustments, tags, and users
    When I POST "/users/harry/tags/animals/adjustments.xml" with body ""
    Then I should get a 422 Unprocessable Entity response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <errors>
        <error>Value can't be blank</error>
        <error>Value is not a number</error>
      </errors>
    """
  
  Scenario: Destroy an adjustment
    Given a typical set of adjustments, tags, and users
    When I DELETE "/users/harry/tags/animals/adjustments/104.xml"
    Then I should get a 200 OK response
    And I should get an XML response body like:
    """
      <?xml version="1.0" encoding="UTF-8"?>
      <adjustment>
          <id type="integer">104</id>
          <value type="integer">4</value>
          <path>/users/harry/tags/animals/adjustments/104.xml</path>
          <user-permalink>harry</user-permalink>
          <tag-permalink>animals</tag-permalink>
          <created-at type="datetime">2009-09-10T15:06:32Z</created-at>
          <updated-at type="datetime">2009-09-10T15:06:32Z</updated-at>
      </adjustment>
    """
  
  Scenario: Attempt to destroy a non-existing adjustment
    Given a typical set of adjustments, tags, and users
    When I DELETE "/users/harry/tags/animals/adjustments/300.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Attempt to destroy an adjustment with a non-existing tag
    Given a typical set of adjustments, tags, and users
    When I DELETE "/users/harry/tags/doesnt-exist/adjustments/300.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Attempt to destroy an adjustment with a non-existing user
    Given a typical set of adjustments, tags, and users
    When I DELETE "/users/doesnt-exist/tags/animals/adjustments/300.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Attempt to destroy an adjustment with a non-existing user and tag
    Given a typical set of adjustments, tags, and users
    When I DELETE "/users/doesnt-exist/tags/doesnt-exist/adjustments/300.xml"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
