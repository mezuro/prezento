Feature: Reading Group Deletion
  In order to be able to remove a reading group
  As a regular user
  The system should have an interface to it

  @kalibro_configuration_restart
  Scenario: Should not delete a reading group without user authentication
    Given I have a sample reading group
    When I visit the Sample Reading Group page
    Then I should not see "Destroy"

  @kalibro_configuration_restart
  Scenario: Should not delete a reading group that doesn't belongs to user
    Given I am a regular user
    And I am signed in
    And I have a sample reading group
    When I visit the Sample Reading Group page
    Then I should not see "Destroy"

  @kalibro_configuration_restart
  Scenario: Should delete a reading group that I own
    Given I am a regular user
    And I am signed in
    And I own a sample reading group
    And I visit the Sample Reading Group page
    When I click the Destroy link
    Then I should see "New Reading Group"
    And the Sample Reading Group should not be there
