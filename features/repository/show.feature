Feature: Show Repository
  In order to visualize the results of my repositories
  As a regular user
  I should see it's informations

  @kalibro_restart
  Scenario: With a ready processing
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository wihin the sample project
    And I start to process that repository
    And I wait up for a ready processing
    When I visit the repository show page
    Then I should see the sample repository name
    And I should see "Description"
    And I should see "Address"
    And I should see "Configuration"
    And I should see "State"
    And I should see "Date"
    And I should see "LOADING time"
    And I should see "COLLECTING time"
    And I should see "ANALYZING time"

  @kalibro_restart
  Scenario: Just after start to process
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository wihin the sample project
    And I start to process that repository
    When I visit the repository show page
    Then I should see the sample repository name
    And I should see "Description"
    And I should see "Address"
    And I should see "Configuration"
    And I should see "State"
    And I should see "Date"