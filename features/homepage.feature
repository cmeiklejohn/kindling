Feature: Homepage

  Scenario: Show the homepage
    When I go to the home page
    Then I should see the about section
    And I should not see the bookshelf section

  Scenario: View my bookshelf
    Given I am signed in
    And I have a bunch of books in my bookshelf
    When I go to the home page
    Then I should see my bookshelf containing those books
