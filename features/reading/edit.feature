Feature: Reading Edit
  In Order to be able to update my readings info
  As a regular user
  I should be able to edit my readings

  Background: Regular user and signed in
    Given I am a regular user
    And I am signed in

  @kalibro_restart
  Scenario: editing a reading successfully
    And I own a sample reading group
    And I have a sample reading within the sample reading group
    And I am at the Edit Reading page
    Then the field "Label" should be filled with "Good"
    And the field "Grade" should be filled with "10.5"
    And the field "Color" should be filled with "33dd33"
    When I fill the Label field with "Bad"
    And I press the Save button
    Then I should see "Bad"

  @kalibro_restart
  Scenario: editing a reading with already taken name, editing a reading with non numerical value and editing a reading with blank fields and editing a reading with already taken name
    And I own a sample reading group
    And I have a sample reading within the sample reading group labeled "Average"
    And I have a sample reading within the sample reading group labeled "Good"
    And I am at the Edit Reading page
    When I fill the Label field with "Average"
    And I press the Save button
    Then I should see "Label There is already a Reading with label Average! Please, choose another one."
    When I fill the Label field with "macaco"
    And I fill the Grade field with "z"
    And I fill the Color field with "FFFFFF"
    And I press the Save button
    Then I should see "Grade is not a number"
    When I fill the Label field with " "
    And I fill the Grade field with " "
    And I fill the Color field with " "
    And I press the Save button
    Then I should see "Label can't be blank"
    And I should see "Grade can't be blank"
    And I should see "Color can't be blank"

