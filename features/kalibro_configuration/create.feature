Feature: Configuration Creation
  In order to register my configurations
  As a regular user
  I should be able to create configurations

  @kalibro_configuration_restart
  Scenario: Should not create configuration without login
    Given I am at the All Configurations page
    Then I should not see "New Configuration"

  @kalibro_configuration_restart
  Scenario: configuration creation
    Given I am a regular user
    And I am signed in
    And I am at the New Configuration page
    And I fill the Name field with "Kalibro"
    And I fill the Description field with "Web Service to collect metrics"
    When I press the Save button
    Then I should see "Kalibro"
    And I should see "Web Service to collect metrics"

  @kalibro_configuration_restart
  Scenario: configuration creation with already taken name
    Given I am a regular user
    And I am signed in
    And I have a configuration named "Kalibro"
    And I am at the New Configuration page
    And I fill the Name field with "Kalibro"
    And I fill the Description field with "Web Service to collect metrics"
    When I press the Save button
    Then I should see "Name has already been taken"

  @kalibro_configuration_restart
  Scenario: configuration creation with blank name
    Given I am a regular user
    And I am signed in
    And I am at the New Configuration page
    And I fill the Name field with " "
    And I fill the Description field with "Web Service to collect metrics"
    When I press the Save button
    Then I should see "Name can't be blank"

  @kalibro_configuration_restart
  Scenario: configuration name with whitespaces
    Given I am a regular user
    And I am signed in
    And I have a configuration named "Kalibro Metrics"
    And I am at the New Configuration page
    And I fill the Name field with "   Kalibro Metrics  "
    When I press the Save button
    Then I should see "Name has already been taken"
