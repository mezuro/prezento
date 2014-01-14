Feature: Reading Edit
  In Order to be able to update my readings info
  As a regular user
  I should be able to edit my readings

@kalibro_restart @wip 
  Scenario: editing a reading successfully
    Given I am a regular user
    And I am signed in
    And I own a sample reading group
    And I have a sample reading within the sample reading group
    And I am at the Edit Reading page
    Then the field "Label" should be filled with "Good"
    And the field "Grade" should be filled with "10.5"
    And the field "Color" should be filled with "33dd33"    
    When I fill the Label field with "Bad"
    And I press the Save button
    Then I should see "Bad"
    And I should see "10.5"
    And I should see "33dd33"

  @kalibro_restart @wip
  Scenario: editing a reading with blank fields
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project named "QtCalculator"
    And I am at repository edit page
    When I fill the Name field with " "
    And I fill the Address field with " "
    And I press the Save button
    Then I should see "Name can't be blank"
    And I should see "Address can't be blank"

  @kalibro_restart @wip
  Scenario: editing a reading with already taken name
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project named "MedSquare"
    And I have a sample repository within the sample project named "QtCalculator"
    And I am at repository edit page
    When I fill the Name field with "MedSquare"
    And I press the Save button
    Then I should see "There's already"