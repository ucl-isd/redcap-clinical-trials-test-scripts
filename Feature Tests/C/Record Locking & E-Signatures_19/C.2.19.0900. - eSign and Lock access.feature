Feature: User Interface: The system shall support the ability to limit access to the Record Locking Customization module, locking/unlocking instruments, locking/unlocking with e-signature authority and LOCK/INLOCK *Entire* Records (record level) through user rights.

    As a REDCap end user
    I want to see that Record locking and E-signatures is functioning as expected

    Scenario: C.2.19.900.100 Enable user rights for Record Locking Customization module
        Given I login to REDCap with the user "REDCap_Admin"
        And I create a new project named "C.2.19.900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    Scenario: ##SETUP_PRODUCTION
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I should see Project status: "Production"

    Scenario: #SETUP
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I click on the button labeled "I understand. Let me make changes" in the dialog box
        And for the Column Name "Also display E-signature option on instrument?", I check the checkbox within the Record Locking Customization table for the Data Collection Instrument named "Text Validation"
        Then I should see a table header and rows containing the following values in a table:
            | Display the Lock option for this instrument? | Data Collection Instrument | Also display E-signature option on instrument? | Lock Record Custom Text |
            | [✓]                                          | Text Validation            | [✓]                                            | [text box]              |
            | [✓]                                          | Data Types                 | [ ]                                            | [text box]              |
            | [✓]                                          | Survey                     | [ ]                                            | [text box]              |
            | [✓]                                          | Consent                    | [ ]                                            | [text box]              |

        And I click on the link labeled "User Rights"
        And I click on the button labeled "Upload or download users, roles, and assignments"
        Then I should see "Upload users (CSV)"
        When I click on the link labeled "Upload users (CSV)"
        Then I should see a dialog containing the following text: "Upload users (CSV)"

        Given I upload a "csv" format file located at "import_files/user list for project 1_CTSP.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see a dialog containing the following text: "Upload users (CSV) - Confirm"
        And I should see a table header and rows containing the following values in a table:
            | username   |
            | test_user1_CTSP |
            | test_user2_CTSP |
            | test_user3_CTSP |
            | test_user4_CTSP |

        Given I click on the button labeled "Upload" in the dialog box
        Then I should see a dialog containing the following text: "SUCCESS!"

        When I click on the button labeled "Close" in the dialog box
        Then I should see a table header and rows containing the following values in a table:
            | Role name               | Username            |
            | —                       | REDCap_admin          |
            | —                       | test_user1_CTSP          |
            | —                       | test_user2_CTSP          |
            | —                       | test_user3_CTSP          |
            | —                       | test_user4_CTSP          |
            | 1_FullRights            | [No users assigned] |
            | 2_Edit_RemoveID         | [No users assigned] |
            | 3_ReadOnly_Deidentified | [No users assigned] |
            | 4_NoAccess_Noexport     | [No users assigned] |
            | TestRole                | [No users assigned] |

    Scenario:  #USER_RIGHTS - Assign eSign and Lock user rights to users
        ##ACTION - Assign users rights for Test_User1_CTSP; Lock/Unlock *Entire* Records (record level)
        Given I click on the link labeled "Test User1_CTSP"
        And I click on the button labeled "Edit user privileges" on the tooltip
        Then I should see a dialog containing the following text: "Editing existing user"
        And I check the User Right named "Record Locking Customization"
        And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking with E-signature authority"
        Then I should see a dialog containing the following text: "NOTICE"
        And I click on the button labeled "Close" in the dialog box
        Given I check the User Right named "Lock/Unlock *Entire* Records (record level)"
        When I save changes within the context of User Rights
        Then I should see 'User "test_user1_CTSP was successfully edited'

        ##ACTION - Assign users rights for Test_User2_CTSP; Disable Lock/Unlock Records
        Given I click on the link labeled "Test User2_CTSP
        And I click on the button labeled "Edit user privileges" on the tooltip
        Then I should see a dialog containing the following text: "Editing existing user"
        And I check the User Right named "Record Locking Customization"
        And I select the User Right named "Lock/Unlock Records" and choose "Disabled"
        When I save changes within the context of User Rights
        Then I should see 'User "test_user2_CTSP" was successfully edited'

        ##ACTION - Assign users rights for Test_User3_CTSP; Enable Locking / Unlocking records
        Given I click on the link labeled "Test User3_CTSP"
        And I click on the button labeled "Edit user privileges" on the tooltip
        Then I should see a dialog containing the following text: "Editing existing user"
        And I uncheck the User Right named "Record Locking Customization"
        And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking"
        When I save changes within the context of User Rights
        Then I should see 'User "test_user3_CTSP" was successfully edited'

        ##ACTION - Assign users rights for Test_User4_CTSP;  Disable Lock/Unlock Records
        Given I click on the link labeled "Test User4_CTSP"
        And I click on the button labeled "Edit user privileges" on the tooltip
        Then I should see a dialog containing the following text: "Editing existing user"
        And I uncheck the User Right named "Record Locking Customization"
        And I select the User Right named "Lock/Unlock Records" and choose "Disabled"
        When I set Data Viewing Rights to View & Edit for the instrument "Text Validation"
        When I save changes within the context of User Rights
        Then I should see 'User "test_user4_CTSP" was successfully edited'

    Scenario: #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | REDCap_admin | Update user   | test_user4_CTSP                              |
            | REDCap_admin | Update user   | test_user3_CTSP                              |
            | REDCap_admin | Update user   | test_user2_CTSP                              |
            | REDCap_admin | Update user   | test_user1_CTSP                              |
            | REDCap_admin | Manage/Design | Upload users (CSV)                      |
            | REDCap_admin | Add User      | test_user4_CTSP                              |
            | REDCap_admin | Add User      | test_user3_CTSP                              |
            | REDCap_admin | Add User      | test_user2_CTSP                             |
            | REDCap_admin | Add User      | test_user1_CTSP                              |

        Given I logout

    Scenario:  #FUNCTIONAL_REQUIREMENT Test user privileges
        #Test_User1_CTSP
        Given I login to REDCap with the user "Test_User1_CTSP"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.2.19.900.100"
        ##VERIFY - Record Locking Customization module enabled
        Then I should see a link labeled "Customize & Manage Locking/E-signatures"
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I click on the button labeled "I understand. Let me make changes" in the dialog box
        Then I should see a link labeled "Record Locking Customization"
        And I should see a link labeled "E-signature and Locking Management"
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "3" and click on the bubble
        Then I should see "Text Validation"
        ##VERIFY - Locking / Unlocking with E-signature authority is enabled
        And I should see a checkbox labeled exactly "Lock" that is unchecked
        And I should see a checkbox labeled "E-signature" that is unchecked
        And I click on the button labeled "Cancel"
        ##VERIFY - Lock/Unlock *Entire* Records (record level) is enabled
        Then I should see "Record Home Page"
        When I click on the button labeled "Choose action for record"
        Then I should see a link labeled "Lock entire record"
        And I logout

    Scenario:  #Test_User2_CTSP
        Given I login to REDCap with the user "Test_User2_CTSP"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.2.19.900.100"
        ##VERIFY - Record Locking Customization module is enabled
        Then I should see a link labeled "Customize & Manage Locking/E-signatures"
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I click on the button labeled "I understand. Let me make changes" in the dialog box
        Then I should see a link labeled "Record Locking Customization"
        And I should NOT see a link labeled "E-signature and Locking Management"
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "3" and click on the bubble
        Then I should see "Text Validation"
        ##VERIFY - Locking / Unlock is disabled
        And I should NOT see a checkbox labeled "Lock"
        And I should NOT see a checkbox labeled "E-signature"
        And I click on the button labeled "Cancel"
        ##VERIFY - Lock/Unlock *Entire* Records (record level) is disabled
        Then I should see "Record Home Page"
        When I click on the button labeled "Choose action for record"
        Then I should NOT see a link labeled "Lock entire record"
        And I logout

    Scenario:  #Test_User3_CTSP
        Given I login to REDCap with the user "Test_User3_CTSP"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.2.19.900.100"
        ##VERIFY - Record Locking Customization module is disabled but becomes enabled if you have lock/unlock privileges
        Then I should see a link labeled "Customize & Manage Locking/E-signatures"
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        Then I should NOT see a link labeled "Record Locking Customization"
        And I should see a link labeled "E-signature and Locking Management"
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "3" and click on the bubble
        Then I should see "Text Validation"
        ##VERIFY - Locking / Unlock is enabled with no e-signature
        And I should see a checkbox labeled exactly "Lock" that is unchecked
        And I should NOT see a checkbox labeled "E-signature"
        When I click on the link labeled "Record Status Dashboard"
        When I click on the link labeled "3"
        ##VERIFY - Lock/Unlock *Entire* Records (record level) is disabled
        Then I should see "Record Home Page"
        When I click on the button labeled "Choose action for record"
        Then I should NOT see a link labeled "Lock entire record"
        And I logout

        #Test_User4_CTSP
        Given I login to REDCap with the user "Test_User4_CTSP"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.2.19.900.100"
        ##VERIFY - Record Locking Customization module is disabled
        Then I should NOT see a link labeled "Customize & Manage Locking/E-signatures"
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "3" and click on the bubble
        Then I should see "Text Validation"
        ##VERIFY - Locking / Unlock is disabled
        And I should NOT see a checkbox labeled "Lock"
        And I should NOT see a checkbox labeled "E-signature"
        And I click on the button labeled "Cancel"
        ##VERIFY - Lock/Unlock *Entire* Records (record level) is disabled
        Then I should see "Record Home Page"
        When I click on the button labeled "Choose action for record"
        Then I should NOT see a link labeled "Lock entire record"
        And I logout
#END
