Feature: Homepage
  In Order to have a good interaction with the website
  As a regular user
  I want to have in one page useful links to manage my account and session

  Scenario: Before signing in
    Given I am at the homepage
    Then I should see "Sign In"
    And I should see "Sign Up"
    And I should see "Latest projects"
    And I should see "Project"

  Scenario: Signed in
    Given I am a regular user
    And I am signed in
    And I am at the homepage
    Then I should see "Edit"
    And I should see "Sign Out"
    And I should see "Latest projects"
    And I should see "Project"
    And I should see "My projects"