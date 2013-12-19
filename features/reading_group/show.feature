Feature: Show Reading Group
  In order to know all the readings of the given reading group and its contents
  As a regular user
  I should be able to see each of them

@kalibro_restart @wip
Scenario: Should not show the create reading link to user that doesn't own the reading group
  Given I am a regular user
  And I have a sample reading group
  And I have a sample reading within the sample reading group
  When I am at the Sample Reading Group page
  Then I should not see New Reading
  And I should not see Destroy reading group
  And I should not see Edit
