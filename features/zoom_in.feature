@javascript
Feature: US Map Interaction
  As a user of the website
  I want to be able to click on a state in the US map
  So that I can see a zoomed-in view of the counties within that state

Background: Stay on the home page
  Given I am on the home page
  And I can see a state such as "California"

Scenario: Clicking on a state to zoom in
  When I click on the state "California"
  Then the map should zoom in on "California"
  Then I can see a county such as "Alameda County"

Scenario: Visit a page describing a non-existing state
  When I am on the page showing the map of the state "CB"
  Then I should see "State 'CB' not found."
