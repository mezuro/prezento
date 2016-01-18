Feature: Repository hotspot metric results
  In order to better understand the results of the analysis
  As a regular user
  I should see the hotspot metric results list

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: Should show the message when the graphic of the given metric has only a single point
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I am at the Sample Configuration page
    And I click the Add Metric link
    And I click the "MetricFu" h3
    And I click the Duplicate Code link
    Given I have a sample project
    And I have a sample ruby repository within the sample project
    And I start to process that repository
    And I wait up for a ready processing
    And I ask for the last ready processing of the given repository
    And I ask for the module result of the given processing
    And I ask for the hotspot metric results of the given module result
    When I visit the repository show page
    And I click the "Hotspot Metric Results" h3
    Then I should have at least one hotspot metric result
    And I should see the hotspot metric results file names
    And I should see the hotspot metric results messages
    When I click the "Tree Metric Results" h3
    Then I should not see "Duplicate Code"

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: Should show the error message when the process fails
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample of an invalid repository within the sample project
    And I start to process that repository
    And I wait up for an error processing
    When I visit the repository show page
    And I click the "Hotspot Metric Results" h3
    Then I should see "Repository process returned with error. There are no hotspot metric results."
