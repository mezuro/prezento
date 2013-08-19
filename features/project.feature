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

  Scenario: Should not create project without login
    Given I am at the All Projects page
    Then I should not see New Project