Feature: Show Compound Metric Configuration
  In order to know all the compound metric configurations contents
  As a regular user
  I should be able to see each of them

  @kalibro_configuration_restart
  Scenario: Checking metric configuration show link
    Given I have a sample configuration
    And I have a sample reading group
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample compound metric configuration within the given mezuro configuration
    And I have a sample range within the sample compound metric configuration
    When I am at the Sample Configuration page
    And I click the Show link
    Then I should be at compound metric configuration sample page
    And I should see the sample range
