Feature: Reading Deletion
  In order to be able to remove reading
  As a regular user
  The system should have an interface to it

  @kalibro_configuration_restart
  Scenario: Should delete a reading that I own
    Given I am a regular user
    And I am signed in
    And I own a sample reading group
    And I have a sample reading within the sample reading group
    When I visit the Sample Reading Group page
    And I choose the destroy reading link
    Then I should see "There are no Readings yet!"

  @kalibro_configuration_restart
  Scenario: Should not see the destroy reading link in the reading groups that I not own
    Given I am a regular user
    And I am signed in
    And I have a sample reading group
    And I have a sample reading within the sample reading group
    When I visit the Sample Reading Group page
    Then I should not see "Destroy"
