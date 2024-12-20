Feature: User Interface: Survey Project Settings: The system shall support tracking responders and non-responders to surveys when using the participant list.
  As a REDCap end user
  I want to see that Survey Feature is functioning as expected

  Scenario: B.3.15.1100.100 Tracking survey responders
    #ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
    Given I login to REDCap with the user "REDCap_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    Given I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
    When I click on the button labeled "Save Changes"
    And I see "Your system configuration values have now been changed!"
    Then I logout

    #SETUP
    Given I login to REDCap with the user "Test_User1_CTSP"
    And I create a new project named "B.3.15.1100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    ##ACTION: Set Consent to survey mode
    When I click on Designer for the project B.2.10.0400.100 
    Then I should see "Data Collection Insturments"
    Then I should click "Enable" next to Consent
    And I click Save Changes
    Then I should see "Your changes have been saved successfully"

    ##VERIFY_SDT
    Given I click on the link labeled "Survey Distribution Tools"
    When I click on the tab labeled "Participant List"
    Then I should see the dropdown field labeled "Participant List" with the option '"Consent" - Event 1 (Arm 1: Arm 1)' selected
    And I should see a "gray bubble" within the "1)  email@test.edu" row of the column labeled "Responded?" of the Participant List table
    And I should see a "gray bubble" within the "2)  email@test.edu" row of the column labeled "Responded?" of the Participant List table

    #FUNCTIONAL_REQUIREMENT
    ##ACTION
    When I click on the link labeled exactly "1"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    And I click on the button labeled "Next Page >>"
    And I check the checkbox labeled "I certify that all of my information in the document above is correct"
    And I click on the button labeled "Submit"
    And I click on the button labeled "Close survey"

    Given I return to the REDCap page I opened the survey from
    And I click on the link labeled "Leave without saving changes" in the dialog box
    And I click on the link labeled "Survey Distribution Tools"
    When I click on the tab labeled "Participant List"
    Then I should see the dropdown field labeled "Participant List" with the option '"Consent" - Event 1 (Arm 1: Arm 1)' selected
    And I should see a "green checkmark" within the "1)  email@test.edu" row of the column labeled "Responded?" of the Participant List table
    And I should see a "gray bubble" within the "2)  email@test.edu" row of the column labeled "Responded?" of the Participant List table
#END
