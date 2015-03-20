Feature: Reading Group Creation
  In order to create new reading groups to make my own readings
  As a regular user
  I should be able to create reading groups

@kalibro_configuration_restart
Scenario: Should not create reading groups without login
  Given I am at the All Reading Groups page
  Then I should not see "New Reading Group"

@kalibro_configuration_restart
Scenario: Reading Group creation
  Given I am a regular user
  And I am signed in
  And I am at the New Reading Group page
  And I fill the Name field with "My reading group"
  And I fill the Description field with "New reading group"
  When I press the Save button
  Then I should see "My reading group"
  And I should see "New reading group"
  And I should see "New Reading"
  And I should see "Destroy"

@kalibro_configuration_restart
Scenario: Reading Group creation with already taken name
  Given I am a regular user
  And I am signed in
  And I have a reading group named "Group"
  And I am at the New Reading Group page
  And I fill the Name field with "Group"
  And I fill the Description field with "Same Group"
  When I press the Save button
  Then I should see "Name has already been taken"

@kalibro_configuration_restart
Scenario: Reading Group creation with blank name
  Given I am a regular user
  And I am signed in
  And I am at the New Reading Group page
  And I fill the Name field with " "
  And I fill the Description field with "Anything"
  When I press the Save button
  Then I should see "Name can't be blank"

@kalibro_configuration_restart
Scenario: Reading Group name with whitespaces
  Given I am a regular user
  And I am signed in
  And I have a reading group named "Reading Group"
  And I am at the New Reading Group page
  And I fill the Name field with "    Reading Group   "
  When I press the Save button
  Then I should see "Name has already been taken"

