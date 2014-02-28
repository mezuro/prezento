Feature: Range Deletion
  In order to be able to remove a range
  As a regular user
  The system should have an interface to it

  @kalibro_restart
  Scenario: Should delete a range that I own
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a sample reading group
    And I have a sample metric configuration within the given mezuro configuration
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample range within the sample metric configuration
    And I am at the sample metric configuration page
    When I click the Destroy link
    Then I should be at metric configuration sample page
    And I should see "There are no ranges yet!"

  @kalibro_restart
  Scenario: Should not see the destroy range link in the range that I not own
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    And I have a sample reading group
    And I have a sample metric configuration within the given mezuro configuration
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample range within the sample metric configuration
    When I am at the sample metric configuration page
    Then I should not see "Destroy"
