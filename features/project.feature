Feature: Project
  In Order to have a good interaction with the website
  As a regular user
  I should see and manage projects

  Scenario: Listing projects
    Given I am at the homepage
    When I click the All Projects link
    Then I should see Listing Projects
    And I should see Name
    And I should see Description

  # This will fail until do the authentication to project.
  @wip
  Scenario: Should not create project without login
    Given I am at the All Projects page
    Then I should not see New Project

  Scenario: Should list the existing projects
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I am at the All Projects page
    Then the sample project should be there

  Scenario: Should show the existing project
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I am at the All Projects page
    When I click the Show link
    Then I should see Name
    And I should see Description
    And I should see Back
    And the sample project should be there

  @wip
  Scenario: Should back to the All Projects page from show project view
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I am at the Sample Project page
    When I click the Back link
    Then I should be in the All Projects page
