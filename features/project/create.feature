Feature: Project Creation
  In order to register my projects
  As a regular user
  I should be able to create projects

  @kalibro_restart
  Scenario: Should not create project without login
    Given I am at the All Projects page
    When I click the New Project link
    Then I should be in the Login page
    And I should see You need to sign in or sign up before continuing.

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

  @kalibro_restart
  Scenario: project creation with already taken name
    Given I am a regular user
    And I am signed in
    And I have a project named "Kalibro"
    And I am at the New Project page
    And I fill the Name field with "Kalibro"
    And I fill the Description field with "Web Service to collect metrics"
    When I press the Create Project button
    Then I should see There's already

  @kalibro_restart
  Scenario: project creation with blank name
    Given I am a regular user
    And I am signed in
    And I am at the New Project page
    And I fill the Name field with " "
    And I fill the Description field with "Web Service to collect metrics"
    When I press the Create Project button
    Then I should see Name can't be blank