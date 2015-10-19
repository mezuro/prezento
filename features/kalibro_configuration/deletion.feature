Feature: Configuration Deletion
  In order to be able to remove configurations
  As a regular user
  The system should have an interface to it

  @kalibro_configuration_restart
  Scenario: Should not delete a configuration without user authentication
    Given I have a sample configuration
    When I am at the Sample Configuration page
    Then I should not see "Destroy"

  @kalibro_configuration_restart
  Scenario: Should not delete a configuration that doesn't belongs to user
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    When I am at the Sample Configuration page
    Then I should not see "Destroy"

  @kalibro_configuration_restart
  Scenario: Should delete a configuration that I own
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I am at the Sample Configuration page
    When I click the Destroy Configuration link
    Then I should be in the All configurations page
    And the sample configuration should not be there
