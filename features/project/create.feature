Feature: Project Creation
  In order to register my projects
  As a regular user
  I should be able to create projects

  # This will fail until do the authentication to project.
  @wip
  Scenario: Should not create project without login
    Given I am at the All Projects page
    Then I should not see New Project

  @kalibro_restart
  Scenario: project creation
    Given I am a regular user
    And I am signed in
    And I am at the New Project page
    And I fill the Name field with "Kalibro"
    And I fill the Description field with "Web Service to collect metrics"
    When I press the Create Project button
    Then I should see Kalibro
    And I should see Web Service to collect metrics