Feature: Repository metric results
  In order the results of the analysis
  As a regular user
  I should see the metric results table with its graphics

  @kalibro_restart @javascript
  Scenario: Should show the graphic of a given metric
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
    When I click on the sample metric's name
    Then I should see "Loading data. Please, wait."
    When I wait up for the ajax request
    Then I should see a loaded graphic for the sample metric