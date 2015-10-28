Feature: Kalibro Range Edit
  In order to be able to update my kalibro range info
  As a regular user
  I should be able to edit my kalibro ranges

  @kalibro_configuration_restart
  Scenario: successfully editing a kalibro range which belongs to a metric configuration
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I own a sample reading group
    And I have a sample tree metric configuration within the given mezuro configuration
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample range within the sample tree metric configuration with beginning "1.1"
    And I am at the Edit Kalibro Range page
    And the select field "Reading" is set as "My Reading"
    And the field "Beginning" should be filled with "1.1"
    And the field "End" should be filled with "5.1"
    And the field "Comments" should be filled with "Comment"
    When I fill the Beginning field with "2.2"
    And I press the Save button
    Then I should see "2.2"

  @kalibro_configuration_restart
  Scenario: successfully editing a kalibro range which belongs to a compound metric configuration
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I own a sample reading group
    And I have a sample compound metric configuration within the given mezuro configuration
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample range within the sample compound metric configuration with beginning "1.1"
    And I am at the Edit Kalibro Range page for the compound metric configuration
    And the select field "Reading" is set as "My Reading"
    And the field "Beginning" should be filled with "1.1"
    And the field "End" should be filled with "5.1"
    And the field "Comments" should be filled with "Comment"
    When I fill the Beginning field with "2.2"
    And I press the Save button
    Then I should see "2.2"

  @kalibro_configuration_restart
  Scenario: editing a kalibro range with blank fields
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I own a sample reading group
    And I have a sample tree metric configuration within the given mezuro configuration
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample range within the sample tree metric configuration with beginning "1"
    And I am at the Edit Kalibro Range page
    When I fill the Beginning field with " "
    And I press the Save button
    Then I should see "Beginning can't be blank"
