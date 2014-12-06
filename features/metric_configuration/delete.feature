Feature: Metric Configuration Deletion
  In order to be able to remove metric configuration
  As a regular user
  The system should have an interface to it

  Background: Regular user and signed in
    Given I am a regular user
    And I am signed in
    And I have a sample reading group

  @kalibro_restart
  Scenario: Should delete a metric configuration that I own and not see the destroy metric configuration link in the mezuro    
    And I own a sample configuration
    And I have a sample metric configuration within the given mezuro configuration
    When I am at the Sample Configuration page
    And I click the Destroy link
    Then I should see "There are no Metric Configurations yet!"
    And I have a sample configuration
    When I am at the Sample Configuration page
    Then I should not see "Destroy"


