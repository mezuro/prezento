Feature: Notify push to repository
  In order to automatically process a repository
  As a regular user
  I want to use a webhook in my repository to notify Mezuro of new pushes

  @kalibro_configuration_restart @kalibro_processor_restart @enable_forgery_protection
  Scenario: Valid repository
    Given I am a regular user
    And I have a sample configuration with hotspot metrics
    And I have a Kalibro Client GitLab repository
    And I start to process that repository
    And I wait up for a ready processing
    When I push some commits to the repository
    Then Mezuro should process the repository again

  @kalibro_configuration_restart @kalibro_processor_restart @enable_forgery_protection
  Scenario: Invalid repository
    Given I am a regular user
    When I push some commits to an invalid repository
    Then I should get a not found error

  @kalibro_configuration_restart @kalibro_processor_restart @enable_forgery_protection
  Scenario: Repository with an errored processing
    Given I am a regular user
    And I have a sample reading group
    And I have a sample configuration with the Saikuro native metric
    And I have a compound metric configuration with script "rtrnaqdfwqefwqr213r2145211234ed a = b=2" within the given mezuro configuration
    And I have a Kalibro Client GitLab repository
    And I start to process that repository
    And I wait up for an error processing
    When I push some commits to the repository
    Then Mezuro should process the repository again
