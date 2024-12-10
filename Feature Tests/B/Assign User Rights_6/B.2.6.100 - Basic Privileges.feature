Feature: Project Level: The system shall allow the ability to add, edit or delete user access to application tools for Basic Privileges and expiration date.

    As a REDCap end user
    I want to see that project level user access is functioning as expected

    Scenario: B.2.6.0100.100 Project level User Rights functions (Add, Edit, Expire, Remove)

        #SETUP

        Given I login to REDCap with the user "REDCap_Admin"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
        And I create a new project named "B.2.6.0100.100 LTS 14.5.26" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.6.0100.100 LTS 14.5.26"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I see Project status: "Production"

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Add User with Basic custom rights

        When I click on the link labeled "User Rights"
        And I enter "Test_User1_CTSP" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see a dialog containing the following text: "Adding new user"

        When I uncheck the User Right named "Project Setup & Design"
        And I select the radio option "No Access" for the field labeled "User Rights"
        And I uncheck the User Right named "Data Access Groups"
        And I uncheck the User Right named "Survey Distribution Tools"
        And I uncheck the User Right named "Alerts & Notifications"
        And I uncheck the User Right named "Calendar & Scheduling"
        And I uncheck the User Right named "Add/Edit/Organize Reports"
        And I uncheck the User Right named "Stats & Charts"
        And I uncheck the User Right named "Data Import Tool"
        And I uncheck the User Right named "Data Comparison Tool"
        And I uncheck the User Right named "Logging"
        And I uncheck the User Right named "File Repository"
        And I uncheck the User Right named "Data Quality - Create & edit rules"
        And I uncheck the User Right named "Data Quality - Execute rules"
        And I uncheck the User Right named "API Export"
        And I uncheck the User Right named "API Import/Update"
        And I uncheck the User Right named "REDCap Mobile App - Allow users to collect data offline in the mobile app"
        And I uncheck the User Right named "Allow user to download data for all records to the app?"
        And I uncheck the User Right named "Create Records"
        And I uncheck the User Right named "Rename Records"
        And I uncheck the User Right named "Delete Records"
        And I uncheck the User Right named "Record Locking Customization"
        And I select the User Right named "Lock/Unlock Records" and choose "Disabled"
        And I uncheck the User Right named "Lock/Unlock *Entire* Records (record level)"
        And I click on the link labeled "Add User" in the dialog box

        ##VERIFY_LOG: Verify Update user rights
        And I click on the button labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action   | List of Data Changes OR Fields Exported |
            | REDCap_admin | Add User | test_user1                              |

        ##ACTION #CROSS-FEATURE B.2.23.100: Verify Logging Filter by user name
        When I select the "REDCap_admin" on the dropdown field labeled "Filter by username"
        ##VERIFY_LOG #CROSS-FEATURE: Verify Logging Filter by user name
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action   | List of Data Changes OR Fields Exported |
            | REDCap_admin | Add User | test_user1_CTSP                              |
        Given I logout

        ##VERIFY: Verify User with Basic custom rights
        Given I login to REDCap with the user "Test_User1_CTSP"
        Then I should see "Logged in as test_user1_CTSP"

        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.6.0100.100 LTS 14.5.26"
        Then I should see a link labeled "Project Home"
        And I should NOT see a link labeled "Project Setup"
        And I should NOT see a link labeled "Designer"
        And I should NOT see a link labeled "Dictionary"
        And I should see a link labeled "Codebook"
        And I should NOT see a link labeled "Survey Distribution Tools"
        And I should see a link labeled "Record Status Dashboard"
        And I should see a link labeled "View / Edit Records"
        And I should see "Applications"
        And I should NOT see a link labeled "Alerts & Notifications"
        And I should NOT see a link labeled "Multi-Language Management"
        And I should NOT see a link labeled "Calendar"
        And I should NOT see a link labeled "Data Import Tool"
        And I should NOT see a link labeled "Logging and Email Logging"
        And I should NOT see a link labeled "File Repository"
        And I should NOT see a link labeled "Data Comparison Tool"
        And I should NOT see a link labeled "User Rights and DAGs"
        And I should NOT see a link labeled "Customize & Manage Locking/E-signatures"
        And I should NOT see a link labeled "Data Quality"
        And I should NOT see a link labeled "API and API Playground"
        And I should NOT see a link labeled "REDCap Mobile App"
        Given I logout

        ##ACTION: Edit User to read-only custom rights
        Given I login to REDCap with the user "REDCap_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.6.0100.100 LTS 14.5.26"
        And I click on the link labeled "User Rights"
        And I click on the link labeled "Test User1_CTSP"
        And I click on the button labeled "Edit user privileges" on the tooltip
        Then I should see a dialog containing the following text: "Editing existing user"

        When I select the radio option "Read Only" for the field labeled "User Rights"
        And I save changes within the context of User Rights

        ##VERIFY_LOG: Verify Update user rights
        And I click on the button labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action      | List of Data Changes OR Fields Exported |
            | REDCap_admin | Update user | test_user1_CTSP                              |
        Given I logout

        ##VERIFY: Verify User with full custom rights

        Given I login to REDCap with the user "Test_User1_CTSP"
        Then I should see "Logged in as test_user1_CTSP"
        And I should see a link labeled "Record Status Dashboard"
        And I should see a link labeled "Add / Edit Records"
        And I should see a link labeled "User Rights "

        When I click on the link labeled "User Rights"
        Then I should see "This page may be used for viewing the user privileges of users in this project. Since you have read-only privileges to this page, you may not add users, modify user privileges, add/edit roles, or other actions."
        And I logout

        ##ACTION: Edit User to full custom rights
        Given I login to REDCap with the user "REDCap_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.6.0100.100 LTS 14.5.26"
        And I click on the link labeled "Test User1_CTSP"
        And I click on the button labeled "Edit user privileges" on the tooltip
        Then I should see a dialog containing the following text: "Editing existing user"

        When I check the User Right named "Project Setup & Design"
        And I select the radio option "Full Access" for the field labeled "User Rights"
        And I check the User Right named "Data Access Groups"
        And I check the User Right named "Survey Distribution Tools"
        And I check the User Right named "Alerts & Notifications"
        And I check the User Right named "Calendar & Scheduling"
        And I check the User Right named "Add/Edit/Organize Reports"
        And I check the User Right named "Stats & Charts"
        And I check the User Right named "Data Import Tool"
        And I check the User Right named "Data Comparison Tool"
        And I check the User Right named "Logging"
        And I check the User Right named "Email Logging"
        And I check the User Right named "File Repository"
        And I check the User Right named "Data Quality - Create & edit rules"
        And I check the User Right named "Data Quality - Execute rules"
        And I check the User Right named "REDCap Mobile App - Allow users to collect data offline in the mobile app"
        Then I should see a dialog containing the following text: "Confirm Mobile App Privileges"
        When I click on the button labeled "Yes, I understand"
        And I check the User Right named "REDCap Mobile App - Allow user to download data for all records to the app?"
        And I check the User Right named "API Export"
        And I check the User Right named "API Import/Update"
        And I check the User Right named "Create Records"
        And I check the User Right named "Rename Records"
        And I check the User Right named "Delete Records"
        And I check the User Right named "Record Locking Customization"
        And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking"
        And I check the User Right named "Lock/Unlock *Entire* Records (record level) "
        And I save changes within the context of User Rights

        ##VERIFY_LOG: Verify Update user rights
        And I click on the button labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action      | List of Data Changes OR Fields Exported |
            | REDCap_admin | Update user | test_user1_CTSP                              |
        Given I logout

        ##VERIFY: Verify User with full custom rights

        Given I login to REDCap with the user "Test_User1_CTSP"
        Then I should see "Logged in as test_user1_CTSP"
        And I should see a link labeled "Project Setup"
        And I should see a link labeled "Designer"
        And I should see a link labeled "Dictionary"
        And I should see a link labeled "Codebook"
        And I should see a link labeled "Survey Distribution Tools"
        And I should see a link labeled "Scheduling"
        And I should see a link labeled "Record Status Dashboard"
        And I should see a link labeled "Add / Edit Records"
        And I should see "Applications"
        And I should see a link labeled "Project Dashboards"
        And I should see a link labeled "Alerts & Notifications"
        And I should see a link labeled "Multi-Language Management"
        And I should see a link labeled "Calendar"
        And I should see a link labeled "Data Exports, Reports, and Stats"
        And I should see a link labeled "Data Import Tool"
        And I should see a link labeled "Logging"
        And I should see a link labeled "Email Logging"
        And I should see a link labeled "Field Comment Log"
        And I should see a link labeled "File Repository"
        And I should see a link labeled "Data Comparison Tool"
        And I should see a link labeled "User Rights "
        And I should see a link labeled "DAGs"
        And I should see a link labeled "Customize & Manage Locking/E-signatures"
        And I should see a link labeled "Data Quality"
        And I should see a link labeled "API"
        And I should see a link labeled "API Playground"
        And I should see a link labeled "REDCap Mobile App"
        And I logout

        ##ACTION: Expire User
        Given I login to REDCap with the user "REDCap_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.6.0100.100 LTS 14.5.26"
        And I click on the link labeled "User Rights"
        And I assign an expired expiration date to user "Test User1_CTSP" with username of "test_user1_CTSP"
        ##VERIFY_LOG: Verify Expire User
        And I click on the button labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action                  | List of Data Changes OR Fields Exported |
            | REDCap_admin | Updated User Expiration | test_user1_CTSP                              |
        Given I logout

        ##VERIFY: Verify User access to project
        Given I login to REDCap with the user "Test_User1_CTSP"
        Then I should see "ACCESS DENIED!"
        And I should see "Your access to this particular REDCap project has expired"
        When I click on the link labeled "Return to My Projects page"
        And I logout

        ##ACTION: Remove expiration for User

        Given I login to REDCap with the user "REDCap_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.6.0100.100 LTS 14.5.26"
        And I click on the link labeled "User Rights"
        And I remove the expiration date to user "Test User1_CTSP" with username of "test_user1_CTSP"
        #The Expiration column shows 'never' for "Test_User1_CTSP"
        ##VERIFY_LOG: Verify Update user Expiration
        And I click on the button labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action                  | List of Data Changes OR Fields Exported |
            | REDCap_admin | Updated User Expiration | test_user1_CTSP                              |
        Given I logout

        ##VERIFY: Verify User access to project
        Given I login to REDCap with the user "Test_User1_CTSP"
        Then I should see "Logged in as test_user1_CTSP"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.6.0100.100 LTS 14.5.26"
        Then I should see a link labeled "Project Home"
        Given I logout

        ##ACTION: Remove User from project
        Given I login to REDCap with the user "REDCap_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.6.0100.100 LTS 14.5.26"
        And I click on the link labeled "User Rights"
        And I click on the link labeled "Test User1_CTSP"
        And I click on the button labeled "Edit user privileges" on the tooltip
        Then I should see a dialog containing the following text: "Editing existing user"

        When I click on a button labeled "Remove User"
        Then I should see a dialog containing the following text: "Remove user?"
        And I click on the button labeled "Remove user" in the dialog box

        ##VERIFY_LOG: Verify Logging of Delete user
        When I click on the link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action                  | List of Data Changes OR Fields Exported |
            | REDCap_admin | Delete user             | test_user1_CTSP                              |
            | REDCap_admin | Updated User Expiration | test_user1_CTSP                              |
        Given I logout

        ##VERIFY: Verify User has no access to project

        Given I login to REDCap with the user "Test_User1_CTSP"
        Then I should see "My Projects"
        And I should NOT see "B.2.6.0100.10 LTS 14.5.26"
#End
