Feature: Reading Group
  In Order to be see the reading groups
  As a regular user
  I should be able to see the public and my own reading groups

  Scenario: Not logged in and no Reading Groups
    Given I am at the homepage
    When I click the Reading Groups link
    Then I should see "Reading Groups"
    And I should see "Name"
    And I should see "Description"
    And I should see "You must be logged in to Create Reading Group"

  @kalibro_configuration_restart @javascript
  Scenario: Logged in, should list Reading Groups
    Given I am a regular user
    And I am signed in
    And I own a sample reading group
    When I am at the All Reading Groups page
    Then the sample reading group should be there
    And I should not see "You must be logged in to Create Reading Group"

  @kalibro_configuration_restart
  Scenario: Should show only the public or owned reading groups
    Given I am a regular user
    And I am signed in
    And I own a sample reading group
    And there is a public reading group created
    And there is a private reading group created
    When I am at the All Reading Groups page
    Then the sample reading group should be there
    And the public reading group should be there
    And the private reading group should not be there
