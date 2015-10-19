Feature: Date Select
  In order to view independent repositories
  As a regular user
  I should be able to navigate within it

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: With a idenpendent repository
    Given I am a regular user
    And I am signed in
    And I have a sample configuration with ruby native metrics
    And I have a sample repository
    And I own that independent repository
    And I start to process that repository
    And I wait up for a ready processing
    When I visit the repository show page
    Then I should see the sample repository name
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
    When I click the Back link
    And I wait for "5" seconds
    Then I should be at the Repositories index
