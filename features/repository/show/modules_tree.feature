Feature: Repository modules tree
  In order to visualize specific results for each module
  As a regular user
  I should see the tree and be able to navigate over it

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: Should show modules directories root when the process has been finished
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project
    And I start to process that repository
    And I wait up for a ready processing
    And I ask for the last ready processing of the given repository
    And I ask for the module result of the given processing
    When I visit the repository show page
    And I click the "Modules Tree" h3
    Then I should see the given module result
    And I should not see "../"

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: Should show children of root when the process has been finished
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with native metrics
    And I have a sample repository within the sample project
    And I start to process that repository
    And I wait up for a ready processing
    And I ask for the last ready processing of the given repository
    And I ask for the module result of the given processing
    When I visit the repository show page
    And I click the "Modules Tree" h3
    Then I should see a sample child's name
    And I should see "Name"
    And I should see "Granularity"
    And I should see "Grade"

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: Module navigation
    Given I am a regular user
    And I am signed in
    And I have a sample configuration with ruby native metrics
    And I have a sample repository
    And I start to process that repository
    And I wait up for a ready processing
    And I ask for the last ready processing of the given repository
    And I ask for the module result of the given processing
    When I visit the repository show page
    And I click the "Modules Tree" h3
    And I click on the sample child's name
    Then I should see a sample child's name

  @kalibro_configuration_restart @kalibro_processor_restart @javascript
  Scenario: Should show modules directories root when the process has been finished
    Given I am a regular user
    And I am signed in
    And I have a sample project
    And I have a sample configuration with MetricFu metrics
    And I have a sample ruby repository within the sample project
    And I start to process that repository
    And I wait up for a ready processing
    And I ask for the last ready processing of the given repository
    And I ask for the module result of the given processing
    When I visit the repository show page
    And I click the "Modules Tree" h3
    Then I should see the given module result
