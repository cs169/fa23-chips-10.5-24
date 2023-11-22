@javascript
Feature: US Map Interaction
  As a user of the website
  I want to be able to click on a state in the US map
  So that I can see a zoomed-in view of the counties within that state
  And see a list of the county representatives

Background: On the page showing the map of the state "California"
  Given I am on the page showing the map of the state "California"
  And I can see a county such as "Alameda County"

Scenario: Clicking on a county to find representatives
  When I click on the county "Alameda County"
  Then I should see "Yesenia Sanchez" 
  Then I should see "Alameda County Sheriff-Coroner"

