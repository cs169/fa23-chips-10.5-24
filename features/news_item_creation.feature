Feature: News Item Creation
  In order to rate news articles
  As a user
  I want to select news articles related to a representative and issue

  Scenario: Selecting and saving a news article
    Given I am on the new news item page
    When I select "Representative Name" from "Representative"
    And I select "Healthcare" from "Issue"
    And I click "Search"
    And I choose the first article
    And I select a rating of "4"
    And I click "Save"
    Then I should see "News item was successfully created."
    And the rating of the last news item should be "4"
