Feature: Repository Creation
	In order to register my repositories
	As a regular user
	I should be able to create repositories

@kalibro_restart
Scenario: should exist the repository create page
	Given I am a regular user
	And I am signed in
	And I own a sample project
	And I am at the Sample Project page
	When I click the New Repository link
	Then I should see "New Repository"

@kalibro_restart
Scenario: Should not show the create repository link to a nom project owner
	Given I am a regular user
	And I am signed in
	And I have a sample project
	When I am at the Sample Project page
	Then I should not see New Repository

@kalibro_restart @wip
Scenario: repository creation
	Given I am a regular user
	And I am signed in
	And I own a sample project
	And I am at the New Repository page
	And I fill the Name field with "Kalibro"
	And I set the select type as "GIT"
	And I fill the Address field with "https://github.com/mezuro/kalibro_entities.git"
	And I set the select configuration_id as "1"
	When I press the Create Repository button
	Then I should see a the created repository
