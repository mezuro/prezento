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
