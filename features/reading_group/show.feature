Feature: Show Reading Group
  In order to know all the readings of the given reading group and its contents
  As a regular user
  I should be able to see each of them

@kalibro_configuration_restart
Scenario: Should not show the create, edit and destroy reading link to user that doesn't own the reading group
  Given I am a regular user
  And I have a sample reading group
  And I have a sample reading within the sample reading group
  When I visit the Sample Reading Group page
  Then I should be in the Sample Reading Group page
  And I should not see "New Reading"
  And I should not see Edit within table
  And I should not see "Destroy"

@kalibro_configuration_restart
Scenario: Should show the links for the user that owns the reading group
  Given I am a regular user
  And I am signed in
  And I own a sample reading group
  And I have a sample reading within the sample reading group
  When I visit the Sample Reading Group page
  Then I should be in the Sample Reading Group page
  And I should see "New Reading"
  And I should see "Edit"
  And I should see "Destroy"
  And I should see "Destroy"

@kalibro_configuration_restart
Scenario: Should show the information of the sample reading
  Given I have a sample reading group
  And I have a sample reading within the sample reading group
  When I visit the Sample Reading Group page
  Then I should be in the Sample Reading Group page
  And I should not see "There are no Readings yet!"
  And I should see "Label"
  And I should see "Grade"
  And I should see "Color"
  And I should see the information of the sample reading

@kalibro_configuration_restart
Scenario: Should show a message when there is no readings
  Given I have a sample reading group
  When I visit the Sample Reading Group page
  Then I should be in the Sample Reading Group page
  And I should see "There are no Readings yet!"
