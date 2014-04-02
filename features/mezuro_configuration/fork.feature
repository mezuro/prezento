Feature: Configuration
  In Order to be able to fork configurations
  As a regular user
  I should be able to fork configurations of other users

	@kalibro_restart
	Scenario: Should go to the fork page
		Given I am a regular user
		And I am signed in
		And I have a sample configuration
		And I am at the All Configurations page
		When I click the Fork link
		Then I should be in the Fork Configuration page	

	@kalibro_restart
	Scenario: Should see a fork of the description
		Given I am a regular user
		And I am signed in
		And I have a sample configuration
		And I am at the All Configurations page
		When I click the Fork link
		Then The field "mezuro_configuration[description]" should be filled with the sample configuration "description"

	@kalibro_restart
	Scenario: Should save forked configuration
		Given I am a regular user
		And I am signed in
		And I have a sample configuration
		And I am at the All Configurations page
		And I click the Fork link
		And I fill the Name field with "Fork Conf"
		When I press the Save button
    Then I should see "Fork Conf"

  @kalibro_restart
  Scenario: With configuration name already taken
    Given I am a regular user
    And I am signed in
    And I have a configuration named "Qt-Calculator"
    And I am at the All Configurations page
		And I click the Fork link
    And I fill the Name field with "Qt-Calculator"
    When I press the Save button
    Then I should see "There's already"