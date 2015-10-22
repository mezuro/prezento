Feature: Show Metric Configuration
  In order to know all the metric configurations of the given configuration and its contents
  As a regular user
  I should be able to see each of them

  @kalibro_configuration_restart
  Scenario: Checking metric configuration show link
    Given I have a sample configuration
    And I have a sample reading group
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample tree metric configuration within the given mezuro configuration
    And I have a sample range within the sample tree metric configuration
    When I am at the Sample Configuration page
    And I click the Show link
    Then I should be at metric configuration sample page
    And I should see the sample range

  @kalibro_configuration_restart @javascript
  Scenario: When there's a range created and I want to see its comments
    Given I have a sample configuration
    And I have a sample reading group
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample tree metric configuration within the given mezuro configuration
    And I have a sample range within the sample tree metric configuration
    And I am at the sample metric configuration page
    When I click the "comment-icon" icon
    Then I should see "Comment"

