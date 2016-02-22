Feature: Tree Metric Configuration Creation
  In order to register my metric configurations
  As a regular user
  I should be able to create metric configurations

  @kalibro_configuration_restart
  Scenario: Should not create metric configurations without login
    Given I have a sample configuration
    And I am at the Sample Configuration page
    Then I should not see "New Metric Configuration"

  @kalibro_configuration_restart @javascript
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
    And I set the select field "Aggregation Form" as "Mean"
    And I set the select field "Reading Group" as "Scholar"
    When I press the Save button
    Then I should see "Total Lines of Code"
    Then I should see "2"

  @kalibro_configuration_restart @javascript
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

  @kalibro_configuration_restart @javascript
  Scenario: compound metric configuration creation with same code
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a reading group named "Scholar"
    And I have a metric configuration with code "total_abstract_classes" within the given mezuro configuration
    And I am at the Sample Configuration page
    And I click the Add Metric link
    And I click the "Analizo" h3
    And I click the Total Abstract Classes link
    And I fill the Weight field with "2"
    And I set the select field "Aggregation Form" as "Mean"
    And I set the select field "Reading Group" as "Scholar"
    When I press the Save button
    Then I should see "Code must be unique within a kalibro configuration"

  @kalibro_configuration_restart @javascript
  Scenario: metric configuration creation with count aggregation form
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a reading group named "Scholar"
    And I am at the Sample Configuration page
    And I click the Add Metric link
    And I click the "Analizo" h3
    And I click the Lines of Code link
    And I fill the Weight field with "100"
    And I set the select field "Aggregation Form" as "Count"
    And I set the select field "Reading Group" as "Scholar"
    When I press the Save button
    Then I should see "Lines of Code"
    Then I should see "100"
