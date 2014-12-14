Feature: Reading Group
  In Order to be able to update my reading groups info
  As a regular user
  I should be able to edit my reading groups

  Background: Regular user and signed in
    Given I am a regular user
    And I am signed in

  @kalibro_restart
  Scenario: Should go to the edit page from a reading group that I own
    And I have a sample reading group
    And I am at the All Reading Groups page
    When I click the Edit link
    Then I should be in the Edit Reading Group page

  @kalibro_restart
  Scenario: Should not show edit links from reading groups that doesn't belongs to me
    And I have a sample reading group
    And I am at the All Reading Groups page
    Then I should not see Edit within table

  @kalibro_restart
  Scenario: Should not render the edit page if the reading group doesn't belongs to the current user
    And I have a sample reading group
    And I am at the All Reading Groups page
    When I visit the sample reading group edit page
    Then I should see "You're not allowed to do this operation"

  @kalibro_restart
  Scenario: Filling up the form
    And I own a sample reading group
    And I am at the All Reading Groups page
    When I click the Edit link
    Then The field "reading_group[name]" should be filled with the sample reading group "name"
    And The field "reading_group[description]" should be filled with the sample reading group "description"

  @kalibro_restart
  Scenario: With valid attributes
    And I own a sample reading group
    And I am at the sample reading group edit page
    And I fill the Name field with "My Reading Group"
    And I fill the Description field with "New Reading Group"
    When I press the Save button
    Then I should see "My Reading Group"
    And I should see "New Reading Group"

  @kalibro_restart
  Scenario: With reading group name already taken and with blank reading group name
    And I have a reading group named "A Reading"
    And I own a reading group named "My reading"
    And I am at the sample reading group edit page
    And I fill the Name field with "A Reading"
    When I press the Save button
    Then I should see "Name There is already a ReadingGroup with name A Reading!"
    And I am at the sample reading group edit page
    And I fill the Name field with " "
    When I press the Save button
    Then I should see "Name can't be blank"

  @kalibro_restart
  Scenario: Editing just the description
    And I own a sample reading group
    And I am at the sample reading group edit page
    And I fill the Description field with "New Reading Group"
    When I press the Save button
    Then I should see "New Reading Group"

   