Feature: Show Configuration
  In order to know all the contents of a given configuration
  As a regular user
  I should be able to see each of them

@kalibro_configuration_restart
Scenario: Checking configuration contents
  Given I have a sample configuration
  And I have a hotspot metric configuration
  And I have a tree metric configuration
  When I am at the Sample Configuration page
  Then the sample configuration should be there