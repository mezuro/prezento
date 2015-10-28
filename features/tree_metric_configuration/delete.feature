Feature: Metric Configuration Deletion
  In order to be able to remove metric configuration
  As a regular user
  The system should have an interface to it

  @kalibro_configuration_restart
  Scenario: Should delete a metric configuration that I own
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a sample reading group
    And I have a sample tree metric configuration within the given mezuro configuration
    When I am at the Sample Configuration page
    And I click destroy Metric Configuration
    Then I should see "There are no Tree Metric Configurations yet!"

  @kalibro_configuration_restart
  Scenario: Should not see the destroy metric configuration link in the mezuro configuration that I not own
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    And I have a sample reading group
    And I have a sample tree metric configuration within the given mezuro configuration
    When I am at the Sample Configuration page
    Then I should not see "Destroy"
