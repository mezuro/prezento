Feature: Compound Metric Configuration Creation
  In order to register my compound metric configurations
  As a regular user
  I should be able to create compound metric configurations

  @kalibro_restart @wip #Missing create action and native metrics name and code
  Scenario: compound metric configuration creation
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a reading group named "Scholar"
    And I am at the Sample Configuration page
    And I click the Add Metric link
    And I click the Compound Metric link
    And I fill the Name field with "My Compound Metric"    
    And I fill the Description field with "Some description"
    And I fill the Code field with "My Code"
    And I fill the Script field with "8*8;"
    And I fill the Weight field with "2"
    And I set the select field "Scope" as "Class"
    And I set the select field "Aggregation Form" as "Average"
    And I set the select field "Reading Group" as "Scholar"
    When I press the Save button
    #Then I should see "My Code"
    #Then I should see "Total Lines of Code"
    #Then I should see "2"
