Feature: Hotspot Configuration listing
  In order to interact with hotspot metric configurations
  As a regular user
  I should see the hotspot metric configurations of a given kalibro configuration

  @kalibro_configuration_restart
  Scenario: When there are hotspot metric configurations and no tree metric configurations
    Given I have a sample configuration
    And I have a sample hotspot metric configuration within the given mezuro configuration
    When I am at the Sample Configuration page
    Then I should see the sample hotspot metric configuration content
    And I should see "There are no Tree Metric Configurations yet!"
  
  
  @kalibro_configuration_restart
  Scenario: When there are hotspot metric configurations and tree metric configurations
    Given I have a sample configuration
    And I have a sample hotspot metric configuration within the given mezuro configuration
    And I have a sample reading group
    And I have a sample tree metric configuration within the given mezuro configuration
    When I am at the Sample Configuration page
    Then I should see the sample hotspot metric configuration content
    And I should not see "There are no Tree Metric Configurations yet!"
