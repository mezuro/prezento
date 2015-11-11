Feature: Project Deletion
  In order to be able to remove projects
  As a regular user
  The system should have an interface to it

  @kalibro_processor_restart
  Scenario: Should not delete a project without user authetication
    Given I have a sample project
    When I am at the Sample Project page
    Then I should not see "Destroy"

  @kalibro_processor_restart
  Scenario: Should not delete a project that doesn't belongs to user
    Given I am a regular user
    And I am signed in
    And I have a sample project
    When I am at the Sample Project page
    Then I should not see "Destroy"

  @kalibro_processor_restart
  Scenario: Should delete a project that I own
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I am at the Sample Project page
    When I click the Destroy Project link
    Then I should be in the All Projects page
    And the sample project should not be there
