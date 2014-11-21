Feature: Metric Configuration Creation
  In order to register my metric configurations
  As a regular user
  I should be able to create metric configurations

  @kalibro_restart
  Scenario: Should not create metric configurations without login
    Given I have a sample configuration
    And I am at the Sample Configuration page
    Then I should not see "New Metric Configuration"

  @kalibro_restart @javascript
  Scenario: metric configuration creation
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a reading group named "Scholar"
    And I am at the Sample Configuration page
    And I click the Add Metric link
    And I click the "Analizo" h3
    And I click the Total Lines of Code link
    And I fill the Weight field with "2"
    And I set the select field "Aggregation Form" as "Average"
    And I set the select field "Reading Group" as "Scholar"
    When I press the Save button
    Then I should see "Total Lines of Code"
    Then I should see "2"

  @kalibro_restart @javascript
  Scenario: metric configuration creation
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a reading group named "Scholar"
    And I am at the Sample Configuration page
    And I click the Add Metric link
    And I click the "Analizo" h3
    And I click the Total Lines of Code link
    When I click the Back link
    Then I should be at the choose metric page
