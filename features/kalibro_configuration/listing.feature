Feature: Configuration listing
  In order to interact with other configurations
  As a regular user
  I should have various listings

  Scenario: Listing configurations
    Given I am at the homepage
    When I click the Configurations link
    Then I should see "Configurations"
    And I should see "Name"
    And I should see "Description"
    And I should see "You must be logged in to create configurations."

  @kalibro_configuration_restart
  Scenario: Should list the existing configurations
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    And I am at the All Configurations page
    Then the sample configuration should be there
    And I should not see "You must be logged in to create configurations."

  @kalibro_configuration_restart
  Scenario: Should show the existing configuration
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    And I am at the All Configurations page
    When I click the Show link
    Then the sample configuration should be there

  @kalibro_configuration_restart
  Scenario: Should show only the public or owned configurations
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    And there is a public configuration created
    And there is a private configuration created
    When I am at the All Configurations page
    Then the sample configuration should be there
    And the public configuration should be there
    And the private configuration should not be there
