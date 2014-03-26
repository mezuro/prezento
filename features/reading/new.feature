Feature: New reading
  In order to be able to create new readings
  As a metric specialist
  I should be able to fill up a form with its informations and submit it

  @kalibro_restart
  Scenario: Visiting reading creation page
    Given I am a regular user
    And I am signed in
    And I own a sample reading group
    And I visit the Sample Reading Group page
    When I click the New Reading link
    Then I should be at the New Reading page
    And I should see "Label"
    And I should see "Grade"
    And I should see "Color"

  @kalibro_restart
  Scenario: With valid fields
    Given I am a regular user
    And I am signed in
    And I own a sample reading group
    And I am at the New Reading page
    And I fill the Label field with "My Reading"
    And I fill the Grade field with "1"
    And I fill the Color field with "00000ff00"
    When I press the Save button
    Then I should be in the Sample Reading Group page

  @kalibro_restart
  Scenario: With an existing label (Label uniqueness test)
    Given I am a regular user
    And I am signed in
    And I own a sample reading group
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I am at the New Reading page
    And I fill the Label field with "My Reading"
    And I fill the Grade field with "1"
    And I fill the Color field with "00000ff00"
    When I press the Save button
    Then I should see "1 error prohibited this Reading from getting saved"
    And I should be at the New Reading page

  # This test should get fixed with: https://github.com/mezuro/mezuro/issues/30
  @kalibro_restart @wip
  Scenario: With an invalid grade
    Given I am a regular user
    And I am signed in
    And I own a sample reading group
    And I am at the New Reading page
    And I fill the Label field with "My Reading"
    And I fill the Grade field with "z"
    And I fill the Color field with "00000ff00"
    When I press the Save button
    Then I should see "Grade is not a number"
    And I should be at the New Reading page

  @kalibro_restart
  Scenario: With an invalid color
    Given I am a regular user
    And I am signed in
    And I own a sample reading group
    And I am at the New Reading page
    And I fill the Label field with "My Reading"
    And I fill the Grade field with "1"
    And I fill the Color field with "z"
    When I press the Save button
    Then I should see "1 error prohibited this Reading from getting saved"
    And I should be at the New Reading page

