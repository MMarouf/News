Feature: Filter popup

@NoResults
Scenario: Show Filter Popup Screen

    Given I am on All News
    When I Tap on Filter CTA
    Then I can see the popup dialog with the little Select Category
