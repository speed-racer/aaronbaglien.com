Feature: Recovery Library Sales Page
  aaronbaglien front page
  As a visitor to the site
  I can find my favorite restaurant

  Scenario: Checking the front page
    When I go to /
    Then I should see "AaronBaglien"
    When I click "#eat"



