Feature: Create a new native configuration and process a repository using it
  In order to view the results of a ruby repository
  As a regular user
  I should be able to configure a set of metrics and process a repository using them

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: Create a ruby configuration and process a ruby repository
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a reading group named "Scholar"
    And I have a sample repository
    And I am at the Sample Configuration page
    And I click the Add Metric link
    And I click the "MetricFu" h3
    And I click the Pain link
    And I fill the Weight field with "2"
    And I set the select field "Aggregation Form" as "Mean"
    And I set the select field "Reading Group" as "Scholar"
    When I press the Save button
    Then I should see "Pain"
    And I should see "2"
    When I start to process that repository
    And I wait up for a ready processing
    And I ask for the last ready processing of the given repository
    And I ask for the module result of the given processing
    And I ask for the metric results of the given module result
    When I visit the repository show page
    And I click the "Tree Metric Results" h3
    Then I should see the sample metric's name
    And I should see the ruby metric results
