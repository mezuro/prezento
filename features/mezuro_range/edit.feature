Feature: Mezuro Range Edit
  In Order to be able to update my mezuro range info
  As a regular user
  I should be able to edit my mezuro ranges

  @kalibro_restart
  Scenario: editing a mezuro range successfully
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I own a sample reading group
    And I have a sample metric configuration within the given mezuro configuration
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample range within the sample metric configuration with beginning "1.1"
    And I am at the Edit Mezuro Range page
    And the select field "Reading" is set as "My Reading"
    And the field "Beginning" should be filled with "1.1"
    And the field "End" should be filled with "5.1"
    And the field "Comments" should be filled with "Comment"    
    When I fill the Beginning field with "2.2"
    And I press the Save button
    Then I should see "2.2"

  @kalibro_restart
  Scenario: editing a mezuro range with blank fields
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I own a sample reading group
    And I have a sample metric configuration within the given mezuro configuration
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample range within the sample metric configuration with beginning "1"
    And I am at the Edit Mezuro Range page
    When I fill the Beginning field with " "
    And I press the Save button
    Then I should see "Beginning can't be blank"
