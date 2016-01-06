Feature: Hotspot Metric Configuration Creation
  In order to register my metric configurations
  As a regular user
  I should be able to create hotspot metric configurations

  @kalibro_configuration_restart @javascript
  Scenario: hotspot metric configuration creation
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I am at the Sample Configuration page
    And I click the Add Metric link
    And I click the "MetricFu" h3
    When I click the Duplicate Code link
    Then I should see "Hotspot Metrics"
    And I should see "Duplicate Code"
