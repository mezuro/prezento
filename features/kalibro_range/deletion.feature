Feature: Kalibro Range Deletion
  In order to be able to remove a kalibro range
  As a regular user
  The system should have an interface to it

  @kalibro_configuration_restart
  Scenario: Should delete a kalibro range I own which belongs to a metric configuration
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a sample reading group
    And I have a sample tree metric configuration within the given mezuro configuration
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample range within the sample tree metric configuration
    And I am at the sample metric configuration page
    When I click the Destroy link
    Then I should be at metric configuration sample page
    And I should see "There are no Ranges yet!"

  @kalibro_configuration_restart
  Scenario: Should delete a kalibro range I own which belongs to a compound metric configuration
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a sample reading group
    And I have a sample compound metric configuration within the given mezuro configuration
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample range within the sample compound metric configuration
    And I am at the sample compound metric configuration page
    When I click the Destroy link
    Then I should be at compound metric configuration sample page
    And I should see "There are no Ranges yet!"

  @kalibro_configuration_restart
  Scenario: Should not see the destroy kalibro range link in the kalibro range that I do not own
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    And I have a sample reading group
    And I have a sample tree metric configuration within the given mezuro configuration
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample range within the sample tree metric configuration
    When I am at the sample metric configuration page
    Then I should not see "Destroy"
