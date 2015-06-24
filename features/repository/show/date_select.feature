Feature: Date Select
  In order to view previous processings
  As a regular user
  I should be able to select a specific date

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: With a specific date selected
    Given I am a regular user
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project
    And I start to process that repository
    And I wait up for a ready processing
    And I wait for "60" seconds
    And I start to process that repository
    And I wait up for the last processing to get ready
    When I visit the repository show page
    Then I should see "Retrieve the closest processing information from:"
    When I set the select field "day" as "1"
    And I set the select field "month" as "1"
    And I set the select field "year" as "2013"
    And I press the Search button
    And I get the Creation Date information as "before"
    When I set the select field "day" as "1"
    And I set the select field "month" as "1"
    And I set the select field "year" as "2020"
    And I press the Search button
    And I get the Creation Date information as "after"
    Then "before" should be lesser than "after"
