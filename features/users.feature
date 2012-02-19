Feature: Users

  Background: 
    Given I am a registered user

  Scenario: View the user
    When I visit the user page
    Then I should see the users info
