Feature: Receipt Processing

  Background:
    Given a registered user

  Scenario: First Amazon receipt for ebook
    Given a valid receipt from Amazon for an ebook for that user
    When the receipt processor runs
    Then an record should be created for that item
    And an ownership of that item should be recorded for that user
