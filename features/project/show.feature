Feature: Show Project
  In order to know all the repositories of the given project and its contents
  As a regular user
  I should be able to see each of them

@kalibro_restart
Scenario: Considering the project has no repositories
  Given I have a sample project
  When I am at the Sample Project page
  Then I should see There are no repositories yet!

@kalibro_restart @wip
Scenario: Considering the project has repositories
  Given I have a sample project
  When I am at the Sample Project page
  Then I should not see There are no repositories yet!

@kalibro_restart
Scenario: Checking project contents
  Given I have a sample project
  When I am at the Sample Project page
  Then the sample project should be there