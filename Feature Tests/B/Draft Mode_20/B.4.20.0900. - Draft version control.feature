Feature: User Interface: The system shall record all versions of the data dictionary post-production with date time stamp, requestor, and approver.

    As a REDCap end user
    I want to see that Draft Mode is functioning as expected

    Scenario: B.4.20.0900.100 Data dictionary version history
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
        And I create a new project named "B.4.20.0900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I should see Project status: "Production"

        #ACTION: Draft Mode
        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        #ACTION
        Given I click on the instrument labeled "Data Types"
        And I click on the button labeled "Add Field"

        And I select "Notes Box (Paragraph Text)" on the dropdown field labeled "Field Type:"
        And I enter "DD History" into the Field Label of the open "Add New Field" dialog box
        And I enter "dd_history" into the Variable Name of the open "Add New Field" dialog box
        And I click on the button labeled "Save"
        Then I should see the field labeled "DD History"

        #ACTION: Commit Changes
        When I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit" in the dialog box
        Then I should see "SUCCESS!"
        And I click on the button labeled "Close" in the dialog box

        #ACTION
        When I click on the tab labeled "Project Home"
        And I click on the link labeled "Project Revision History"
        Then I should see "Project Revision History"

        #FUNCTIONAL_REQUIREMENT
        And I should see a table rows containing the following values in a table:
            | Created project                  | mm/dd/yyyy hh:mm |                          | Test_User1_CTSP (Test User1_CTSP) |
            | Moved to production              | mm/dd/yyyy hh:mm | Download data dictionary | Test_User1_CTSP (Test User1_CTSP) |
            | Production revision #1 (current) | mm/dd/yyyy hh:mm | Download data dictionary | Test_User1_CTSP (Test User1_CTSP) |
#Project Revision History table also includes following language "Approved automatically"
#END
