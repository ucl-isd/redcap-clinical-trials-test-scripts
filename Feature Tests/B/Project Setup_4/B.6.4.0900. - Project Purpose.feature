Feature: User Interface: General: The system shall support the designation of the purpose of the project.

    As a REDCap end user
    I want to see that Project Setup is functioning as expected

    Scenario: B.6.4.0900.100 Change project purpose designation
        #SETUP
        Given I login to REDCap with the user "Test_User1_CTSP"
        And I create a new project named "B.6.4.0900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.6.4.0900.100"
        And I click on the link labeled "Project Setup"

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Change project purpose designation
        And I click on the button labeled "Modify project title, purpose, etc."
        And I select "Operational Support" on the dropdown field labeled "Project's purpose:"
        And I click on the button labeled "Save" in the dialog box

        ##VERIFY
        Then I should see "Success! Your changes have been saved."

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1_CTSP | Manage/Design | Modify project settings                 |

        ##ACTION #CROSS-FEATURE B.2.23.100: Verify Logging Filter by event manage/design
        And I select "Manage/Design" on the dropdown field labeled "Filter by event:"

        ##VERIFY_LOG #CROSS-FEATURE: Verify Logging Filter by event manage/design
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1_CTSP | Manage/Design | Modify project settings                 |
            | mm/dd/yyyy hh:mm | test_user1_CTSP | Manage/Design | Create project using REDCap XML file    |
#END
