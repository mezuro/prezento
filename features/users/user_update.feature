Feature: User update
  In Order to be able to update my name
  As a regular user
  I want to have an edit page

  @javascript
  Scenario: with current password
    Given I am a regular user
    And I am signed in
    And I am at the homepage
    When I click the Edit link
    And I fill the Name field with "Rafael Manzo"
    And I fill the Current password field with "password"
    And I press the Update button
    Then I should see "You updated your account successfully"
    And my name should have changed to Rafael Manzo
