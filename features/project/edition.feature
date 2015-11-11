Feature: Project
  In Order to be able to update my projects info
  As a regular user
  I should be able to edit my projects

  @kalibro_processor_restart
  Scenario: Should go to the edit page from a project that I own
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I am at the All Projects page
    When I click the Edit link
    Then I should be in the Edit Project page

  @kalibro_processor_restart
  Scenario: Should not show edit links from projects that doesn't belong to me
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I am at the All Projects page
    Then I should not see Edit within table

  @kalibro_processor_restart
  Scenario: Should not render the edit page if the project doesn't belong to the current user
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I am at the All Projects page
    When I visit the sample project edit page
    Then I should see "You're not allowed to do this operation"

  @kalibro_processor_restart
  Scenario: Filling up the form
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I am at the All Projects page
    When I click the Edit link
    Then The field "project[name]" should be filled with the sample project "name"
    And The field "project[description]" should be filled with the sample project "description"

  @kalibro_processor_restart
  Scenario: With valid attributes
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I am at the sample project edit page
    And I fill the Name field with "Kalibro"
    And I fill the Description field with "Web Service to collect metrics"
    When I press the Save button
    Then I should see "Kalibro"
    And I should see "Web Service to collect metrics"

  @kalibro_processor_restart
  Scenario: With project name already taken
    Given I am a regular user
    And I am signed in
    And I have a project named "Qt-Calculator"
    And I own a project named "Kalibro"
    And I am at the sample project edit page
    And I fill the Name field with "Qt-Calculator"
    When I press the Save button
    Then I should see "Name has already been taken"

  @kalibro_processor_restart
  Scenario: Editing just the description
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I am at the sample project edit page
    And I fill the Description field with "Web Service to collect metrics"
    When I press the Save button
    And I should see "Web Service to collect metrics"

  @kalibro_processor_restart
  Scenario: With blank project name
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I am at the sample project edit page
    And I fill the Name field with " "
    When I press the Save button
    Then I should see "Name can't be blank"
