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

	@kalibro_restart @javascript
	Scenario: Shouldn't allow to go to the fork page
		Given I am a regular user
		And I am signed in
		And I own a sample configuration
		When I visit the fork page of my sample configuration
		When I take a picture of the page
		Then I should see "You're not allowed to do this operation"		

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
    Then I should see "mezuro configuration was successfully created."

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

  @kalibro_restart
  Scenario: Should update fork counter
		Given I am a regular user
		And I am signed in
		And I have a sample configuration
		And I am at the All Configurations page
		And I see the sample configuration fork counter showing "0"
		And I click the Fork link
		And I fill the Name field with "New Fork Conf"
		And I press the Save button
		When I click the Back link
		Then I should see the counter showing "1"