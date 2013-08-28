Feature: Project Deletion
  In order to be able to remove projects
  As a regular user
  The system should have an interface to it
  
  @kalibro_restart
  Scenario: Should delete a project
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I am at the Sample Project page
    When I click the Destroy link
    Then I should be in the All Projects page
    And the sample project should not be there