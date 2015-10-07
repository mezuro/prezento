Feature: Repository hotspot metric results
  In order to better understand the results of the analysis
  As a regular user
  I should see the hotspot metric results list

  @kalibro_configuration_restart @kalibro_processor_restart @javascript @wip
  Scenario: Should show the message when the graphic of the given metric has only a single point
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with hotspot metrics
    And I have a sample ruby repository within the sample project
    And I start to process that repository
    And I wait up for a ready processing
    And I ask for the last ready processing of the given repository
    And I ask for the module result of the given processing
    And I ask for the hotspot metric results of the given module result
    When I visit the repository show page
    And I click the "Hotspot Metric Results" h3
    Then I should see a list of hotspot metric results

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
