Feature: B.2.10.0400. User Interface: The system shall provide the ability to restrict a user who has been assigned to a DAG to: (data they entered | data entered by any member of the same DAG | files uploaded in the File Repository)


    As a REDCap end user
    I want to see that Data Access Groups is functioning as expected

    Scenario: B.2.10.0400.100 User restriction for records in DAGs

        #SETUP_NOTE: Will reference unique Group ID numbers located on DAG page. These numbers are specific the PID

        #SETUP
        Given I login to REDCap with the user "REDCap_Admin"
        And I create a new project named "B.2.10.0400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.10.0400.100"
        And I click on the link labeled "User Rights"
        And I click on the button labeled "Upload or download users, roles, and assignments"
        Then I should see "Upload users (CSV)"

        When I click on the link labeled "Upload users (CSV)"
        Then I should see a dialog containing the following text: "Upload users (CSV)"

        Given I upload a "csv" format file located at "import_files/user list for project 1_CTSP.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see a dialog containing the following text: "Upload users (CSV) - Confirm"
        And I should see a table header and rows containing the following values in a table:
            | username   |
            | REDCap_admin |
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


        #This will give Test_User3 elevated privileges for this test
        And I click on the link labeled "Test User3_CTSP"
        And I click on the button labeled "Edit user privileges"
        Then I should see a dialog containing the following text: "Editing existing user"

        ##ACTION: Set user access to View & Edit + Edit survey responses
        When I set Data Viewing Rights to View & Edit for the instrument "Text Validation"
        And I set Data Viewing Rights to View & Edit for the instrument "Consent"
        And I save changes within the context of User Rights

        #This will give Test_User4 elevated privileges for this test
        And I click on the link labeled "Test User4_CTSP"
        And I click on the button labeled "Edit user privileges"
        Then I should see a dialog containing the following text: "Editing existing user"

        ##ACTION: Set user access to View & Edit + Edit survey responses
        When I set Data Viewing Rights to View & Edit for the instrument "Text Validation"
        And I set Data Viewing Rights to View & Edit for the instrument "Consent"
        And I save changes within the context of User Rights

        #ASSIGN RECORDS TO SPECIFIC DAGs
        # -- Record ID 3 - TestGroup1 --
        Given I click on the link labeled "Add / Edit Records"
        And I select "3" on the dropdown field labeled "Choose an existing Record ID"
        Then I should see "Record ID 3"

        Given I click on the span element labeled "Choose action for record"
        And I click on the link labeled "Assign to Data Access Group"
        Then I should see a dialog containing the following text: "Assign record to a Data Access Group?"

        When I select "TestGroup1" on the dropdown field labeled "Assign record" on the dialog box
        And I click on the button labeled "Assign to Data Access Group" in the dialog box
        Then I should see "Record ID 3 was successfully assigned to a Data Access Group"

        # -- Record ID 4 - TestGroup2 --
        Given I click on the link labeled "Add / Edit Records"
        And I select "4" on the dropdown field labeled "Choose an existing Record ID"
        Then I should see "Record ID 4"

        Given I click on the span element labeled "Choose action for record"
        And I click on the link labeled "Assign to Data Access Group"
        Then I should see a dialog containing the following text: "Assign record to a Data Access Group?"

        When I select "TestGroup2" on the dropdown field labeled "Assign record" on the dialog box
        And I click on the button labeled "Assign to Data Access Group" in the dialog box
        Then I should see "Record ID 4 was successfully assigned to a Data Access Group"

        When I click on the link labeled "DAGs"
        Then I should see "Assign user to a group"

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Assign User to DAG
        When I select "test_user3_CTSP (Test User3_CTSP)" on the dropdown field labeled "Assign user"
        When I select "TestGroup1" on the dropdown field labeled "to"
        And I click on the button labeled "Assign"

        ##VERIFY
        Then I should see a table header and rows containing the following values in data access groups table:
            | Data Access Groups | Users in group |
            | TestGroup1         | test_user3_CTSP     |

        When I select "test_user1_CTSP (Test User1_CTSP)" on the dropdown field labeled "Assign user"
        When I select "TestGroup1" on the dropdown field labeled "to"
        And I click on the button labeled "Assign"

        ##VERIFY
        Then I should see a table header and rows containing the following values in data access groups table:
            | Data Access Groups | Users in group |
            | TestGroup1         | test_user1_CTSP     |
            | TestGroup1         | test_user3_CTSP     |


        When I select "test_user4_CTSP (Test User4_CTSP)" on the dropdown field labeled "Assign user"
        When I select "TestGroup2" on the dropdown field labeled "to"
        And I click on the button labeled "Assign"

        ##VERIFY
        Then I should see a table header and rows containing the following values in data access groups table:
            | Data Access Groups | Users in group |
            | TestGroup1         | test_user3_CTSP     |
            | TestGroup1         | test_user1_CTSP    |
            | TestGroup2         | test_user4_CTSP     |

        When I select "test_user2_CTSP (Test User2_CTSP)" on the dropdown field labeled "Assign user"
        When I select "TestGroup2" on the dropdown field labeled "to"
        And I click on the button labeled "Assign"

        Then I should see a table header and rows containing the following values in data access groups table:
            | Data Access Groups | Users in group |
            | TestGroup1         | test_user3_CTSP     |
            | TestGroup1         | test_user1_CTSP     |
            | TestGroup2         | test_user2_CTSP     |
            | TestGroup2         | test_user4_CTSP     |

        And I logout

        ##VERIFY
        Given I login to REDCap with the user "Test_User3_CTSP"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.10.0400.100"
        And I click on the link labeled "Record Status Dashboard"

        ##VERIFY_RSD:
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID     |
            | 3  TestGroup1 |

        ##VERIFY
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        Then I should see "Record Home Page"

        ##ACTION: Add record while in a DAG
        Given I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
        And I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event Three"

        #This opens the survey
        When I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label

        #On the survey
        Then I should see "Consent"
        And I should see "Please complete the survey below."

        Given I click on the button labeled "Next Page"
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I check the checkbox labeled "I certify"
        When I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."

        When I click on the button labeled "Close survey"
        #Then I should see "You may now close this tab/window"
        And  click on the button labeled "Leave without saving changes" in the dialog box
        Then I should seen "Record Home Page"

        ##VERIFY_LOG:
        And I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user3_CTSP | Create record | record_id = '1-1'                       |

        ##VERIFY_RSD:
        When I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID     |
            | 3  TestGroup1 |

        ##VERIFY_FR:
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        Then I should see a table header and rows containing the following values in a table:
            | Record | Survey                               | Survey Completion Time |
            | 1-1    | Consent (Event Three (Arm 1: Arm 1)) | mm/dd/yyyy hh:mm       |
        And I logout

        ##ACTION: Another user from same DAG has access to same DAG records
        Given I login to REDCap with the user "Test_User1_CTSP"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.10.0400.100"

        ##VERIFY_RSD:
        When I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID       |
            | 1-1  TestGroup1 |
            | 3  TestGroup1   |

        ##VERIFY_FR:
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"

        Then I should see a table header and rows containing the following values in a table:
            | Record | Survey                               | Survey Completion Time |
            | 1-1    | Consent (Event Three (Arm 1: Arm 1)) | mm/dd/yyyy hh:mm       |
        And I logout

        ##ACTION: Separate User DAG
        Given I login to REDCap with the user "Test_User4_CTSP"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.10.0400.100"

        ##VERIFY
        When I click on the link labeled "Add / Edit Records"
        And I select "4" on the dropdown field labeled "Choose an existing Record ID"
        Then I should see "Record Home Page"

        ##ACTION: Add record while in a DAG
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        Then I should see "Record Home Page"

        ##ACTION: Add record while in a DAG
        Given I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
        And I click the bubble to select a record for the "Consent" longitudinal instrument on event "Event Three"

        #This opens the survey
        When I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label

        #On the survey
        Then I should see "Consent"
        And I should see "Please complete the survey below."

        Given I click on the button labeled "Next Page"
        And I should see "Consent"
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I check the checkbox labeled "I certify"
        When I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."

        When I click on the button labeled "Close survey"
        Then I should see "You may now close this tab/window"

        Given I am still logged in to REDCap with the user "Test_User4_CTSP"
        ##VERIFY_RSD:
        And I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID       |
            | 4  TestGroup2   |
            | 2-1  TestGroup2 |

        ##VERIFY_FR:
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        Then I should see a table header and rows containing the following values in a table:
            | Record | Survey                               | Survey Completion Time |
            | 2-1    | Consent (Event Three (Arm 1: Arm 1)) | mm/dd/yyyy hh:mm       |
        And I logout

        ##ACTION: Another user from same DAG has access to same DAG records
        Given I login to REDCap with the user "Test_User2_CTSP"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.10.0400.100"

        ##VERIFY_RSD:
        When I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID       |
            | 4  TestGroup2   |
            | 2-1  TestGroup2 |

        ##VERIFY_FR:
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        Then I should see a table header and rows containing the following values in a table:
            | Record | Survey                               | Survey Completion Time |
            | 2-1    | Consent (Event Three (Arm 1: Arm 1)) | mm/dd/yyyy hh:mm       |
        And I logout
#End
