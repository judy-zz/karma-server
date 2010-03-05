Feature: Clients CRUD via HTML
  In order to control which clients can submit karma adjustments
  As a admin
  I want to manage clients

    Background:
      Given I have an client with attributes id "1", hostname "West Arete Computing", and ip_address "20.30.40.50"
      And I have an client with attributes id "2", hostname "Yahoo", and ip_address "10.20.30.40"

    Scenario: Create a client
      Given I am on the new client page
      When I fill in "Hostname" with "Reddit"
      And I fill in "IP Address" with "55.55.55.55"
      And I press "Create Client"
      Then I should be on the "Reddit" client page
      And I should see "Client was successfully created."

    Scenario: Edit a client
      Given I am on the edit "West Arete Computing" client page
      When I fill in "Hostname" with "West Arete Pizza Delivery"
      And I press "Update Client"
      Then I should be on the "West Arete Pizza Delivery" client page
      And I should see "Client was successfully saved."

    Scenario: Attempt to Edit a client with a blank hostname
      Given I am on the edit "West Arete Computing" client page
      When I fill in "Hostname" with ""
      And I press "Update Client"
      Then I should see "Edit Client"
      And I should see an error message
      And I should see "Hostname can't be blank"
      
    Scenario: Attempt to Edit a client with a blank ip address
      Given I am on the edit "West Arete Computing" client page
      When I fill in "IP Address" with ""
      And I press "Update Client"
      Then I should see "Edit Client"
      And I should see an error message
      And I should see "IP Address can't be blank"

    Scenario: View list of clients
      Given I am on the clients page
      Then I should see "West Arete Computing"
      And I should see "Yahoo"

    Scenario: View a client
      Given I am on the "West Arete Computing" client page
      Then I should see "West Arete Computing"
      And I should not see "Yahoo"

    Scenario: Destroy a client
      Given I am on the clients page
      When I click "Destroy West Arete Computing client"
      Then I should be on the clients page
      And I should see "Client was successfully destroyed."
      And I should not see "West Arete Computing"
