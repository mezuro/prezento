Feature: User projects list
  In Order to be able to easily find my projects
  As a regular user
  I want to have a page with a list of my projects

  @kalibro_restart
  Scenario: with current password
    Given I am a regular user
    And I own a sample project
    And I am signed in
    And I am at the homepage
    When I click the My projects link
    Then I should be in the User Projects page
    And the sample project should be there