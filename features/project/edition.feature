Feature: Project
  In Order to be able to update my projects info
  As a regular user
  I should be able to edit my projects

  @kalibro_restart
  Scenario: Should go to edit form from All Projects page
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I am at the All Projects page
    When I click the Edit link
    Then I should be in the Edit Project page
    
  @kalibro_restart
  Scenario: Should have the content filled in form
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I am at the All Projects page
    When I click the Edit link
    Then The field "project[name]" should be filled with the sample project "name"
    And The field "project[description]" should be filled with the sample project "description"

  @kalibro_restart
  Scenario: After project edition should update the information
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I am at the sample project edit page
    And I fill the Name field with Kalibro
    And I fill the Description field with Web Service to collect metrics
    When I press the Update button
    Then I should see Kalibro
    And I should see Web Service to collect metrics