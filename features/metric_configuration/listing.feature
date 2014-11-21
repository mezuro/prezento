Feature: Configuration listing
  In order to interact with metric configurations
  As a regular user
  I should see the metric configurations of a given configuration

  @kalibro_restart
  Scenario: When there are no metric configurations
    Given I have a sample configuration
    When I am at the Sample Configuration page
    Then I should see "Metric Name"
    And I should see "Code"
    And I should see "Weight"
    And I should see "There are no Metric Configurations yet!"

  @kalibro_restart
  Scenario: When there are metric configurations
    Given I have a sample configuration
    And I have a sample reading group
    And I have a sample metric configuration within the given mezuro configuration
    When I am at the Sample Configuration page
    Then I should see the sample metric configuration content

  @kalibro_restart
  Scenario: I should see the add metric link when I am the owner of the given configuration
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    When I am at the Sample Configuration page
    Then I should see "Add Metric"

  @kalibro_restart
  Scenario: I should not see the add metric link when I am at a given configuration page
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    When I am at the Sample Configuration page
    Then I should not see "Add Metric"
