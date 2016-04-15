Feature: User update
  In Order to be able to update my name
  As a regular user
  I want to have an edit page

  @javascript
  Scenario: with current password
    Given I am a regular user
    And I am signed in
    And I am at the homepage
    And I take a picture of the page
    When I click the Diego Martinez link
    And I click the Edit Account link
    And I fill the Name field with "Rafael Manzo"
    And I fill the Current password field with "password"
    And I press the Update button
    Then I should see "Your account has been updated successfully"
    And my name should have changed to Rafael Manzo
