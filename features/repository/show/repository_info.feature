Feature: Show Repository
  In order to visualize the results of my repositories
  As a regular user
  I should see it's informations

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: Testing the repository values
    Given I am a regular user
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project
    And I start to process that repository
    And I wait up for a ready processing
    When I visit the repository show page
    Then I should see "Address"
    And I should see "Configuration"
    And I should see "Period"
    And I should see "Type"
    And I should see "Description"
    And I should see "License"
    And I should see the given repository's content
    And I should not see "Notify Push Url for Gitlab"

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: With a ready processing and asking to reprocess
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project named "QtCalculator"
    And I own that repository
    And I start to process that repository
    And I wait up for a ready processing
    When I visit the repository show page
    Then I should see the sample repository name
    And I should see the correct notify push url
    And I should see "State"
    And I should see "Creation Date"
    And I should see "PREPARING time"
    And I should see "COLLECTING time"
    And I should see "BUILDING time"
    And I should see "AGGREGATING time"
    And I should see "CALCULATING time"
    And I should see "INTERPRETING time"
    When I click the "Tree Metric Results" h3
    And I click the "Modules Tree" h3
    Then I should see "Metric"
    And I should see "Value"
    And I should see "Weight"
    And I should see "Threshold"
    And I should see "Name"
    And I should see "Granularity"
    And I should see "Grade"
    When I click the Reprocess link
    Then I should see "PREPARING"

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: Just after start to process
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project
    And I start to process that repository
    When I visit the repository show page
    Then I should see the sample repository name
    And I should see "PREPARING"
    And I should see "Address"
    And I should see "Configuration"
    And I should see "State"
    And I should see "Creation Date"
    When I click the "Tree Metric Results" h3
    Then I should see "Loading data. Please, wait."
    When I click the "Modules Tree" h3
    Then I should see "Loading data. Please, wait."
    And I wait for "75" seconds or until I see "COLLECTING"
    And I wait for "120" seconds or until I see "AGGREGATING"
    And I wait for "400" seconds or until I see "READY"
