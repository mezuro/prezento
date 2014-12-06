Feature: Metric Configuration edition
  In order to interact with metric configurations
  As a regular user
  I should edit the informations of metric configurations

  Background: Regular user and signed in
    Given I am a regular user
    And I am signed in
    And I have a sample reading group

  @kalibro_configuration_restart
  Scenario: the configuration is not mine
    And I have a sample configuration
    And I have a sample metric configuration within the given mezuro configuration
    When I am at the Sample Configuration page
    Then I should not see Edit within table

  @kalibro_configuration_restart
  Scenario: editing a metric configuration successfully
    And I own a sample configuration
    And I have a sample metric configuration within the given mezuro configuration
    And I am at the Sample Configuration page
    When I click the Edit link
    And I fill the Weight field with "3.0"
    And I press the Save button
    Then I should see "3.0"

  @kalibro_configuration_restart
  Scenario: trying to edit with blank fields and metric configuration with invalid weight
    And I own a sample configuration
    And I have a sample metric configuration within the given mezuro configuration
    When I visit the sample metric configuration edit page
    And I fill the Weight field with " "
    And I press the Save button
    Then I should see "Weight must be greater than 0"
    And I fill the Weight field with "0"
    And I set the select field "Aggregation Form" as "Median"
    When I press the Save button
    Then I should see "Weight must be greater than 0"

 
