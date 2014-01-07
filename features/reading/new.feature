# TODO: refactor when the ReadingGroup get finished
Feature: New reading
  In order to be able to create new readings
  As a metric specialist
  I should be able to fill up a form with its informations and submit it

  @kalibro_restart @wip
  Scenario: with valid fields
    Given I am a regular user
    And I am signed in
    And I have a sample reading group
    And I am at the New Reading page
    And I fill the Label field with "Good"
    And I fill the Grade field with "10"
    And I fill the Color field with "00FF00"
    When I press the Save button
    Then I should see "Reading was successfully created"
