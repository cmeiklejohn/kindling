Feature: Items

  Background:
    Given I am a signed in registered user
    And I have some items
    And I go to the home page

  Scenario: View my items
    When I view my items
