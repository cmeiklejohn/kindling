Feature: Receipt Processing

  Scenario: Amazon receipt for ebook and registered user
    Given a registered user
    And a valid receipt from Amazon for an ebook for that user
    When the receipt processor runs
    Then an record should be created for that item
    And an ownership of that item should be recorded for that user
    And the receipt should be marked as processed
    And the receipt should not be marked as rejected

  Scenario: Amazon receipt for ebook and unregistered user
    Given a valid receipt from Amazon for an ebook for another user
    When the receipt processor runs
    Then the receipt should be marked as processed
    And the receipt should be marked as rejected
