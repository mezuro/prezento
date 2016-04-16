Feature: Compound Metric Configuration Creation
  In order to register my compound metric configurations
  As a regular user
  I should be able to create compound metric configurations

  @kalibro_configuration_restart @javascript
  Scenario: compound metric configuration creation
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a reading group named "Scholar"
    And I have a sample tree metric configuration within the given mezuro configuration
    And I am at the Sample Configuration page
    And I click the Add Metric link
    And I click the Compound Metric link
    Then I see the sample metric configuration name
    And I see the sample metric configuration code
    When I fill the Name field with "My Compound Metric"
    And I fill the Description field with "Some description"
    And I fill the Code field with "mcm"
    And I fill the Script field with "return 8*8;"
    And I fill the Weight field with "8"
    And I set the select field "Scope" as "Class"
    And I set the select field "Reading Group" as "Scholar"
    And I press the Save button
    Then I should see "Metric Configuration was successfully created."
    And I click the show link of "My Compound Metric"
    Then I should see "My Compound Metric"
    And I should see "mcm"
    And I should see "8"

  @kalibro_configuration_restart @javascript
  Scenario: compound metric configuration creation with same code
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a reading group named "Scholar"
    And I have another compound metric configuration with code "Another_Code" within the given mezuro configuration
    And I am at the Sample Configuration page
    And I click the Add Metric link
    And I click the Compound Metric link
    When I fill the Name field with "My Compound Metric"
    And I fill the Description field with "Some description"
    And I fill the Code field with "Another_Code"
    And I fill the Script field with "8*8;"
    And I fill the Weight field with "8"
    And I set the select field "Scope" as "Class"
    And I set the select field "Reading Group" as "Scholar"
    When I press the Save button
    Then I should see "Code must be unique within a kalibro configuration"

  @kalibro_configuration_restart @javascript
  Scenario: compound metric configuration creation must not include non-tree metrics
    Given I am a regular user
    And I am signed in
    And I own a sample configuration
    And I have a reading group named "Scholar"
    And I have a tree metric configuration
    And I have a hotspot metric configuration
    And I have a sample compound metric configuration within the given mezuro configuration
    And I am at the Sample Configuration page
    And I click the Add Metric link
    When I click the Compound Metric link
    Then I should see only tree and compound metrics in the Created Metrics list
