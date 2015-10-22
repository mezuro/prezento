Feature: Metric Configuration listing
  In order to interact with metric configurations
  As a regular user
  I should see the metric configurations of a given configuration

  @kalibro_configuration_restart
  Scenario: When there are no tree metric configurations
    Given I have a sample configuration
    When I am at the Sample Configuration page
    Then I should see "Metric"
    And I should see "Code"
    And I should see "Weight"
    And I should see "There are no Tree Metric Configurations yet!"

  @kalibro_configuration_restart
  Scenario: When there are tree metric configurations and no hotspot metric configurations
    Given I have a sample configuration
    And I have a sample reading group
    And I have a sample tree metric configuration within the given mezuro configuration
    When I am at the Sample Configuration page
    Then I should see the sample tree metric configuration content
    And I should see "There are no Hotspot Metric Configurations yet!"

  @kalibro_configuration_restart
  Scenario: I should see the add metric link when I am the owner of the given configuration
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    When I am at the Sample Configuration page
    Then I should see "Add Metric"

  @kalibro_configuration_restart
  Scenario: I should not see the add metric link when I am at a given configuration page
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    When I am at the Sample Configuration page
    Then I should not see "Add Metric"
