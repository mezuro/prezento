Feature: Metric Configuration Creation
  In order to register my metric configurations
  As a regular user
  I should be able to create metric configurations

  @kalibro_restart
  Scenario: Should not create metric configurations without login
    Given I have a sample configuration
    And I am at the Sample Configuration page
    Then I should not see New Metric Configuration

  @kalibro_restart
  Scenario: metric configuration creation
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a reading group named "Schoolar"
    And I am at the Sample Configuration page
    And I click the Add Metric link
    And I fill the Code field with "My Code"
    And I set the select field "BaseTool" as "Analizo"
    And I set the select field "Metric" as "Lines Of Code"
    And I fill the Description field with "Web Service to collect metrics"
    And I fill the Weigth field with "2"
    And I set the select field "AgregationForm" as "Average"
    And I set the select field "ReadingGroup" as "Schoolar"
    When I press the Save button
    Then I should see "My Code"
    Then I should see "Lines Of Code"
    Then I should see "2"