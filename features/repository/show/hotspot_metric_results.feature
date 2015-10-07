Feature: Repository hotspot metric results
  In order to better understand the results of the analysis
  As a regular user
  I should see the hotspot metric results list

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: Should show the error message when the process fails
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample of an invalid repository within the sample project
    And I start to process that repository
    And I wait up for a error processing
    When I visit the repository show page
    And I click the "Hotspot Metric Results" h3
    Then I should see "Repository process returned with error. There are no hotspot metric results."
