Feature: Repository metric results
  In order the results of the analysis
  As a regular user
  I should see the metric results table with its graphics

  @kalibro_restart @kalibro_processor_restart @javascript
  Scenario: Should show the message when the graphic of the given metric have only a single point
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project
    And I start to process that repository
    And I wait up for a ready processing
    And I ask for the last ready processing of the given repository
    And I ask for the module result of the given processing
    And I ask for the metric results of the given module result
    When I visit the repository show page
    And I click the "Metric Results" h3
    And I see a sample metric's name
    And I click on the sample metric's name
    Then I should see "Loading data. Please, wait."
    When I wait up for the ajax request
    Then I should see "There is only one point and it will not be printed into a chart."

  @kalibro_restart @kalibro_processor_restart @javascript
  Scenario: Should show the no range message after a process without range
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with native metrics but without ranges
    And I have a sample repository within the sample project
    And I start to process that repository
    And I wait up for a ready processing
    And I ask for the last ready processing of the given repository
    And I ask for the module result of the given processing
    And I ask for the metric results of the given module result
    When I visit the repository show page
    And I click the "Metric Results" h3
    And I see a sample metric's name
    Then I should see "Missing range"  

  # TODO: Scenario: Should show the graphic of a given metric
  #         It was getting really difficult to test this because of Poltergeist's timeouts
  #       so we gave up on this for now