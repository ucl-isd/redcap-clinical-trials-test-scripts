Feature: User Interface: The system shall support the ability for a user to change between following project statuses bidirectionally: Development, Production, Analysis/Cleanup, Mark as Complete.

    As a REDCap end user
    I want to see that My Project is functioning as expected

    Scenario: B.6.11.0200.100 Move project from development to production to analysis/cleanup to complete to analysis/cleanup to production to development
        #SETUP
        Given I login to REDCap with the user "REDCap_Admin"
        And I create a new project named "B.6.11.0200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #FUNCTIONAL REQUIREMENT
        ##ACTION: move to production
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        ##VERIFY
        Then I should see Project status: "Production"

        ##ACTION: move to analysis/cleanup
        When I click on the link labeled "Other Functionality"
        And I click on the button labeled "Move to Analysis/Cleanup status"
        And I click on the button labeled "YES, Move to Analysis/Cleanup" in the dialog box
        ##VERIFY
        Then I should see Project status: "Analysis/Cleanup"

        ##ACTION: move to Completed
        When I click on the button labeled "Mark project as Completed"
        And I click on the button labeled "Mark project as Completed" in the dialog box
        And I click on the link labeled "Show Completed Projects"
        Then I should see a link labeled "B.6.11.0200.100"
        ##VERIFY
        When I click on the link labeled "B.6.11.0200.100"
        Then I should see "NOTICE: Project was marked as Completed"

        #FUNCTIONAL REQUIREMENT
        ##ACTION: move to analysis/cleanup
        When I click on the button labeled "Restore Project" in the dialog box
        Then I should see a dialog containing the following text: "PROJECT RESTORED"
        And I click on the button labeled "Close" in the dialog box
        ##VERIFY
        Then I should see Project status: "Analysis/Cleanup"

        ##ACTION: move to production
        When I click on the link labeled "Other Functionality"
        And I click on the button labeled "Move back to Production status"
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        ##VERIFY
        Then I should see Project status: "Production"

        ##ACTION: move to development
        When I click on the button labeled "Move back to Development status"
        ##VERIFY
        Then I should see Project status: "Development"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        And I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported                             |
            | REDCap_admin | Manage/Design | Move project back to Development status                             |
            | REDCap_admin | Manage/Design | Return project to Production from Analysis/Cleanup status           |
            | REDCap_admin | Manage/Design | Project moved from Completed status back to Analysis/Cleanup status |
            | REDCap_admin | Manage/Design | Project marked as Completed                                         |
            | REDCap_admin | Manage/Design | Move project to Analysis/Cleanup status                             |
            | REDCap_admin | Manage/Design | Move project to Production status                                   |
#END
