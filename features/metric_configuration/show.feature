Feature: Show Metric Configuration
  In order to know all the metric configurations of the given configuration and its contents
  As a regular user
  I should be able to see each of them

  Background: Sample reading group
    Given I have a sample configuration
    And I have a sample reading group
    And I have a sample reading within the sample reading group labeled "My Reading"
    And I have a sample metric configuration within the given mezuro configuration
    And I have a sample range within the sample metric configuration

  @kalibro_restart
  Scenario: Checking metric configuration show link
    When I am at the Sample Configuration page
    And I click the Show link
    Then I should be at metric configuration sample page
    And I should see the sample range

  @kalibro_restart @javascript
  Scenario: When there's a range created and I want to see its comments
    And I am at the sample metric configuration page
    When I click the "comment-icon" icon
    Then I should see "Comment"

