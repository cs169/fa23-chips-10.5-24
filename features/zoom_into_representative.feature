@javascript
Feature: US Map Interaction
  As a user of the website
  I want to be able to click on a state in the US map
  So that I can see a zoomed-in view of the counties within that state
  And see a list of the county representatives

Background: On the page showing the map of the state "California"
  Given I am on the page showing the map of the state "CA"
  And I can see a county such as "Alameda County"

Scenario: Clicking on a county to find representatives
  When I click on the county "Alameda County"
  Then I should see "Yesenia Sanchez"
  Then I should see "Alameda County Sheriff-Coroner"

Scenario: Enter a url to find representatives
  When I am on the page showing the map of the county "Alameda County" with id "1" under "CA"
  Then I should see "Yesenia Sanchez"
  Then I should see "Alameda County Sheriff-Coroner"

Scenario: Enter an invalid url to find representatives
  When I am on the page showing the map of the county "N/A County" with id "99999" under "CA"
  Then I should see "County with code '99999' not found for CA"
