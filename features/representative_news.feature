Feature: Edit News Articles for Representatives

    As a user of the website
    I want to be able to select issues related to a representative
    So that I can edit relevant news articles for them

    Background:
        Given Representative "Pamela Price" exists
        And I am logged in
        And I am on the news editing page for "Pamela Price"

    Scenario: Selecting an issue for Pamela Price
        When I select "Unemployment" from "issue"
        Then I should see "Unemployment"
