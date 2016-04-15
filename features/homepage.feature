Feature: Homepage
  In Order to have a good interaction with the website
  As a regular user
  I want to have in one page useful links to manage my account and session

  @kalibro_processor_restart
  Scenario: Before signing in
    Given I have a project named "GCC"
    Then I am at the homepage
    And I should see "Home"
    And I should see "Project"
    And I should see "Repository"
    And I should see "Configuration"
    And I should see "Reading Group"
    And I should see "Sign In"
    And I should see "Sign Up"
    And I should see "Language"
    And I should see "Latest projects"
    And I should see "Latest repositories"
    And I should see "Latest configurations"
    Then I should see "GCC" only "1" times

  Scenario: Signed in
    Given I am a regular user
    And I am signed in
    And I am at the homepage
    Then I should see "Edit Account"
    And I should see "Sign Out"
    And I should see "Your projects"

  Scenario: Language selection
    Given I am at the homepage
    When I click the Language link
    And I click the pt link
    Then I should see "Entendendo Métricas de Código"
    When I click the Idioma link
    And I click the en link
