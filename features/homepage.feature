Feature: Homepage

  Background:
    When I go to the home page

  Scenario: Show the homepage
    Then I should see the title

  Scenario: Sign up
    When I follow the sign up link
    And I fill out the sign up form
    Then I should be signed up
    And I should be logged in

  Scenario: Sign in
    Given I am a registered user
    When I follow the sign in link
    And I fill out the sign in form
    Then I should be signed in

  Scenario: Sign out
    Given I am a registered user
    When I follow the sign in link
    And I fill out the sign in form
    And I follow the sign out link
    Then I should be signed out
