Feature: Project listing
  In order to interact with other projects
  As a regular user
  I should have various listings

  Background: Listing projects and regular user and signed in
    Given I am at the homepage
    When I click the Project link
    Then I should see "Projects"
    And I should see "Name"
    And I should see "Description"
    And I should see "You must be logged in to create projects"
    Given I am a regular user
    And I am signed in

  @kalibro_processor_restart
  Scenario: Should list the existing projects
    And I have a sample project
    And I am at the All Projects page
    Then the sample project should be there
    And I should not see "You must be logged in to create new Projects."

  @kalibro_processor_restart
  Scenario: Should show the existing project
    And I have a sample project
    And I have sample project_attributes
    And I am at the All Projects page
    When I click the Show link
    Then the sample project should be there
