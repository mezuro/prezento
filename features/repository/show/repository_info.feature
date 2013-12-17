Feature: Show Repository
  In order to visualize the results of my repositories
  As a regular user
  I should see it's informations

  @kalibro_restart @javascript
  Scenario: Testing the repository values
    Given I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project
    And I start to process that repository
    And I wait up for a ready processing
    When I visit the repository show page
    Then I should see "Address"
    And I should see "Configuration"
    And I should see "Periodicity"
    And I should see "Type"
    And I should see "Description"
    And I should see "License"
    And I should see the given repository's content

  @kalibro_restart @javascript
  Scenario: With a ready processing and asking to reprocess
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project named "QtCalculator"
    And I start to process that repository
    And I wait up for a ready processing
    When I visit the repository show page
    Then I should see the sample repository name
    And I should see "State"
    And I should see "Creation date"
    And I should see "LOADING time"
    And I should see "COLLECTING time"
    And I should see "ANALYZING time"
    When I click the "Metric Results" h3
    And I click the "Modules Tree" h3
    Then I should see "Metric"
    And I should see "Value"
    And I should see "Weight"
    And I should see "Threshold"
    And I should see "Name"
    And I should see "Granularity"
    And I should see "Grade"
    When I click the Reprocess link
    Then I should see "LOADING"

  @kalibro_restart @javascript
  Scenario: Just after start to process
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project
    And I start to process that repository
    When I visit the repository show page
    Then I should see the sample repository name
    And I should see "LOADING"
    And I should see "Address"
    And I should see "Configuration"
    And I should see "State"
    And I should see "Creation date"
    When I click the "Metric Results" h3
    Then I should see "Loading data. Please, wait."
    When I click the "Modules Tree" h3
    Then I should see "Loading data. Please, wait."
    When I click the "Processing information" h3
    And I wait for "75" seconds or until I see "COLLECTING"
    And I wait for "60" seconds or until I see "ANALYZING"
    And I wait for "400" seconds or until I see "READY"
    When I click the "Metric Results" h3
    Then I should see "Metric"
    And I should see "Value"
    And I should see "Weight"
    And I should see "Threshold"
    When I click the "Modules Tree" h3
    Then I should see "Name"
    And I should see "Granularity"
    And I should see "Grade"