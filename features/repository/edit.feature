Feature: Repository Edit
  In Order to be able to update my repositories info
  As a regular user
  I should be able to edit my repositories

  @kalibro_configuration_restart @kalibro_processor_restart
  Scenario: editing a repository successfully
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project named "QtCalculator"
    And I own that repository
    And I am at repository edit page
    Then the field "Name" should be filled with "QtCalculator"
    And the field "Type" should be filled with "GIT"
    And the field "Address" should be filled with "https://github.com/rafamanzo/runge-kutta-vtk.git"
    And I set the select field "Process Period" as "Weekly"
    And I set the select field "License" as "EU DataGrid Software License (EUDatagrid)"
    When I fill the Name field with "MedSquare"
    And I set the select field "Type" as "GIT"
    And I fill the Address field with "git://git.code.sf.net/p/medsquare/git"
    And I press the Save button
    Then I should see "MedSquare"
    And I should see "git://git.code.sf.net/p/medsquare/git"
    And I should see "Weekly"
    And I should see "EU DataGrid Software License (EUDatagrid)"

  @kalibro_configuration_restart @kalibro_processor_restart
  Scenario: editing a repository with blank fields
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project named "QtCalculator"
    And I own that repository
    And I am at repository edit page
    When I fill the Name field with " "
    And I fill the Address field with " "
    And I press the Save button
    Then I should see "Name can't be blank"
    And I should see "Address can't be blank"

  @kalibro_configuration_restart @kalibro_processor_restart
  Scenario: editing a repository with already taken name
    Given I am a regular user
    And I am signed in
    And I own a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project named "MedSquare"
    And I own that repository
    And I have a sample repository within the sample project named "QtCalculator"
    And I own that repository
    And I am at repository edit page
    When I fill the Name field with "MedSquare"
    And I press the Save button
    Then I should see "Name has already been taken"
