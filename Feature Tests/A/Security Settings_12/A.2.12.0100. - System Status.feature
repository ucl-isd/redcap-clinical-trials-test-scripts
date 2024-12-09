Feature: A.2.12.0100. Security Settings- The system shall support changing the system status between online and offline.

  As a REDCap end user
  I want to see that system status is functioning as expected

  Scenario: A.2.12.0100.100 System Status Online/Offline

    Given I login to REDCap with the user "REDCap_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Server configuration settings"
    And I should see "System Status"
    And I should see the dropdown field labeled "System Status" with the option "SYSTEM ONLINE" selected

    Given I select "SYSTEM OFFLINE" on the dropdown field labeled "System Status"
    And I enter "<p><strong><span style="font-size: 12pt; color: #ff5f15; background-color: #ffffff;">This application is currently offline while we carry out an upgrade. The upgrade should be completed within the next hour or so. Please try again later.</span></strong></p>" into the textarea field labeled "Custom message to display to users when system is offline"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    When I logout

    #Test REDCap offline for Standard User
    Given Sven.Nelson login to REDCap with the user "Sven.Nelson@ucl.ac.uk"
    Then I should see "This application is currently offline while we carry out an upgrade. The upgrade should be completed within the next hour or so. Please try again later."
    And I logout

    #Test REDCap offline for Admin User
    Given I login to REDCap with the user "REDCap_Admin"
    Then I should see "REDCap and all its projects are currently OFFLINE and are not accessible to normal users."
    And I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Server configuration settings"
    Then I should see "System Status"
    Given I select "SYSTEM ONLINE" on the dropdown field labeled "System Status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #Test REDCap online for "Test_User1"
    Given I login to REDCap with the user "Test_User1"
    Then I should see "My Projects"
#End
