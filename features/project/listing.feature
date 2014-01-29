Feature: Project listing
  In order to interact with other projects
  As a regular user
  I should have various listings

  Scenario: Listing projects 
    Given I am at the homepage
    When I click the Project link
    Then I should see "Projects"
    And I should see "Name"
    And I should see "Description"
    And I should see "To create new projects you must be logged in page."

  @kalibro_restart
  Scenario: Should list the existing projects
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I am at the All Projects page
    Then the sample project should be there
    And I should not see "To create new projects you must be logged in page."

  @kalibro_restart
  Scenario: Should show the existing project
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I am at the All Projects page
    When I click the Show link
    Then the sample project should be there