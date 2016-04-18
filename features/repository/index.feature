Feature: Repository listing
  In order to interact with other repositories
  As a regular user
  I should have various listings

  Scenario: Listing repositories
    Given I am at the homepage
    When I click the Repositories link
    Then I should see "Repositories"
    And I should see "Name"
    And I should see "Description"
    And I should see "You must be logged in to create repositories"

  @kalibro_processor_restart @kalibro_configuration_restart
  Scenario: Should list the existing repositories
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    And I have a sample repository
    And I have a sample project
    And I have a sample repository within the sample project
    And I own that repository
    And I am at the All Repositories page
    Then the sample repository should not be there
    And the project repository should be there
    And I should not see "You must be logged in to create new Repositories."

  @kalibro_processor_restart @kalibro_configuration_restart
  Scenario: Should show the existing repository
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    And I have a sample repository
    And I own that independent repository
    And I am at the All Repositories page
    When I click the Show link
    Then the sample repository should be there
