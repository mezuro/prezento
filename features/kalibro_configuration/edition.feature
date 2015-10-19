Feature: Configuration
  In Order to be able to update my configurations info
  As a regular user
  I should be able to edit my configurations

  @kalibro_configuration_restart
  Scenario: Should go to the edit page from a configuration that I own
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I am at the All Configurations page
    When I click the Edit link
    Then I should be in the Edit Configuration page

  @kalibro_configuration_restart
  Scenario: Should not show edit links from configurations that doesn't belongs to me
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    And I am at the All Configurations page
    Then I should not see Edit within table

  @kalibro_configuration_restart
  Scenario: Should not render the edit page if the configuration doesn't belongs to the current user
    Given I am a regular user
    And I am signed in
    And I have a sample configuration
    And I am at the All Projects page
    When I visit the sample configuration edit page
    Then I should see "You're not allowed to do this operation"

  @kalibro_configuration_restart
  Scenario: Filling up the form
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I am at the All Configurations page
    When I click the Edit link
    Then The field "kalibro_configuration[name]" should be filled with the sample configuration "name"
    And The field "kalibro_configuration[description]" should be filled with the sample configuration "description"

  @kalibro_configuration_restart
  Scenario: With valid attributes
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I am at the sample configuration edit page
    And I fill the Name field with "Kalibro"
    And I fill the Description field with "Web Service to collect metrics"
    When I press the Save button
    Then I should see "Kalibro"
    And I should see "Web Service to collect metrics"

  @kalibro_configuration_restart
  Scenario: With configuration name already taken
    Given I am a regular user
    And I am signed in
    And I have a configuration named "Qt-Calculator"
    And I own a configuration named "Kalibro"
    And I am at the sample configuration edit page
    And I fill the Name field with "Qt-Calculator"
    When I press the Save button
    Then I should see "Name has already been taken"

  @kalibro_configuration_restart
  Scenario: Editing just the description
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I am at the sample configuration edit page
    And I fill the Description field with "Web Service to collect metrics"
    When I press the Save button
    And I should see "Web Service to collect metrics"

  @kalibro_configuration_restart
  Scenario: With blank configuration name
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I am at the sample configuration edit page
    And I fill the Name field with " "
    When I press the Save button
    Then I should see "Name can't be blank"
