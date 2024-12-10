Feature: Project Level:  The system shall allow instrument level data export rights to be (No Access, De-Identified, Remove All Identifier Fields, Full Data Set)

    As a REDCap end user
    I want to see that data export rights is functioning as expected

    Scenario: B.2.6.300.100 Data Export Rights
        #SETUP_PRODUCTION
        Given I login to REDCap with the user "REDCap_Admin"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
        And I create a new project named "B.2.6.300.100 LTS 14.5.26" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I should see Project status: "Production"

        ##USER_RIGHTS
        When I click on the link labeled "User Rights"
        And I click on the button labeled "Upload or download users, roles, and assignments"
        Then I should see "Upload users (CSV)"

        When I click on the link labeled "Upload users (CSV)"
        Then I should see a dialog containing the following text: "Upload users (CSV)"

        Given I upload a "csv" format file located at "import_files/user list for project 1_CTSP.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see a dialog containing the following text: "Upload users (CSV) - Confirm"
        And I should see a table header and rows containing the following values in a table in the dialog box:
            | username   |
            | REDCap_admin |
            | test_user1_CTSP |
            | test_user2_CTSP |
            | test_user3_CTSP |
            | test_user4_CTSP |

        Given I click on the button labeled "Upload" in the dialog box
        Then I should see a dialog containing the following text: "SUCCESS!"
        And I click on the button labeled "Close" in the dialog box

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

        #B.2.6.500.100 Assign User Roles
        When I click on the link labeled "Test User1_CTSP"
        And I click on the button labeled "Assign to role" on the role selector dropdown
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled exactly "Assign"
        ##VERIFY
        Then I should see a table header and rows containing the following values in a table:
            | Role name               | Username            |
            | —                       | REDCap_admin          |
            | —                       | test_user2_CTSP          |
            | —                       | test_user3_CTSP          |
            | —                       | test_user4_CTSP          |
            | 1_FullRights            | test_user1_CTSP          |
            | 2_Edit_RemoveID         | [No users assigned] |
            | 3_ReadOnly_Deidentified | [No users assigned] |
            | 4_NoAccess_Noexport     | [No users assigned] |

        When I click on the link labeled "Test User2_CTSP"
        And I click on the button labeled "Assign to role" on the role selector dropdown
        And I select "2_Edit_RemoveID" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled exactly "Assign"
        ##VERIFY
        Then I should see a table header and rows containing the following values in a table:
            | Role name               | Username            |
            | —                       | REDCap_admin          |
            | —                       | test_user3_CTSP          |
            | —                       | test_user4_CTSP          |
            | 1_FullRights            | test_user1_CTSP          |
            | 2_Edit_RemoveID         | test_user2_CTSP          |
            | 3_ReadOnly_Deidentified | [No users assigned] |
            | 4_NoAccess_Noexport     | [No users assigned] |

        When I click on the link labeled "Test User3_CTSP"
        And I click on the button labeled "Assign to role" on the role selector dropdown
        And I select "3_ReadOnly_Deidentified" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled exactly "Assign"
        ##VERIFY
        Then I should see a table header and rows containing the following values in a table:
            | Role name               | Username            |
            | —                       | REDCap_admin          |
            | —                       | test_user4_CTSP          |
            | 1_FullRights            | test_user1_CTSP          |
            | 2_Edit_RemoveID         | test_user2_CTSP          |
            | 3_ReadOnly_Deidentified | test_user3_CTSP          |
            | 4_NoAccess_Noexport     | [No users assigned] |

        When I click on the link labeled "Test User4"
        And I click on the button labeled "Assign to role" on the role selector dropdown
        And I select "4_NoAccess_Noexport" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled exactly "Assign"
        ##VERIFY
        Then I should see a table header and rows containing the following values in a table:
            | Role name               | Username            |
            | —                       | REDCap_admin          |
            | 1_FullRights            | test_user1_CTSP          |
            | 2_Edit_RemoveID         | test_user2_CTSP          |
            | 3_ReadOnly_Deidentified | test_user3_CTSP          |
            | 4_NoAccess_Noexport     | test_user4_CTSP          |
        And I logout

        Given I login to REDCap with the user "Test_User1_CTSP"
        Then I should see "Logged in as"

        #FUNCTIONAL REQUIREMENT #B.5.21.300.100 Export Full Data Set
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.6.300.100 LTS 14.5.26"
        And I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see "All data (all records and fields)"

        ##ACTION
        Given I click on the button labeled "Export Data" for the report named "All data (all records and fields)"
        When I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
        And I click on the button labeled "Export Data" in the dialog box
        Then I should see a dialog containing the following text: "Data export was successful!"

        Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
        And I click on the button labeled "Close" in the dialog box

        ##VERIFY_DE
        Then I should have a "csv" file that contains the headings below
            | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | name | email | text_validation_complete | ptname | textbox | text2 | radio | notesbox | multiple_dropdown_manual | multiple_dropdown_auto | multiple_radio_auto | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | calc_test | calculated_field | signature | file_upload | required | identifier | identifier_2 | edit_field | date_ymd | date_mdy | date_dmy | time_hhmmss | time_hhmm | time_mmss | datetime_ymd_hmss | datetime_ymd_hm | datetime_mdy_hmss | datetime_dmy_hmss | integer | number | number_1_period | number_1_comma | letters | mrn_10_digits | mrn | ssn | phone_north_america | phone_australia | phone_uk | zipcode_us | postal_5 | postal_code_australia | postal_code_canada | data_types_complete | survey_timestamp | name_survey | email_survey | survey_complete | name_consent | email_consent | dob | signature_consent | consent_complete |
        #Manual: Close the file

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action      | List of Data Changes OR Fields Exported |
            | test_user1_CTSP | Data export | Download exported data file (CSV raw)   |

        And I logout

        #SETUP
        Given I login to REDCap with the user "Test_User2_CTSP"
        Then I should see "Logged in as"

        #FUNCTIONAL REQUIREMENT Export remove all identifier fields
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.6.300.100 LTS 14.5.26"
        And I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see "All data (all records and fields)"

        ##ACTION
        Given I click on the button labeled "Export Data" for the report named "All data (all records and fields)"
        When I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
        And I click on the button labeled "Export Data" in the dialog box
        Then I should see a dialog containing the following text: "Data export was successful!"

        Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
        And I click on the button labeled "Close" in the dialog box
        ##VERIFY_DE
        #And I open the Excel CSV File

        Then I should have a "csv" file that contains the headings below
            | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | name | email | text_validation_complete | ptname | textbox | text2 | radio | notesbox | multiple_dropdown_manual | multiple_dropdown_auto | multiple_radio_auto | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | calc_test | calculated_field | signature | file_upload | required | edit_field | date_ymd | date_mdy | date_dmy | time_hhmmss | time_hhmm | time_mmss | datetime_ymd_hmss | datetime_ymd_hm | datetime_mdy_hmss | datetime_dmy_hmss | integer | number | number_1_period | number_1_comma | letters | mrn_10_digits | mrn | ssn | phone_north_america | phone_australia | phone_uk | zipcode_us | postal_5 | postal_code_australia | postal_code_canada | data_types_complete | survey_timestamp | name_survey | email_survey | survey_complete | name_consent | email_consent | dob | signature_consent | consent_complete |
        # And I should NOT see "ptname"
        # And I should NOT see "identifier"
        # And I should NOT see "identifier2"
        #M: Close csv file

        And I logout

        #SETUP
        Given I login to REDCap with the user "Test_User3_CTSP"
        Then I should see "Logged in as"

        #FUNCTIONAL REQUIREMENT: Export Deidentified
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.6.300.100 LTS 14.5.26"
        And I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see "All data (all records and fields)"

        ##ACTION
        Given I click on the button labeled "Export Data" for the report named "All data (all records and fields)"
        When I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
        And I click on the button labeled "Export Data" in the dialog box
        Then I should see a dialog containing the following text: "Data export was successful!"

        Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
        And I click on the button labeled "Close" in the dialog box
        ##VERIFY_DE

        Then I should have a "csv" file that contains the headings below
            | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | email | text_validation_complete | radio | multiple_dropdown_manual | multiple_dropdown_auto | multiple_radio_auto | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | calc_test | calculated_field | signature | file_upload | date_ymd | date_mdy | date_dmy | time_hhmmss | time_hhmm | time_mmss | datetime_ymd_hmss | datetime_ymd_hm | datetime_mdy_hmss | datetime_dmy_hmss | integer | number | number_1_period | number_1_comma | letters | mrn_10_digits | mrn | ssn | phone_north_america | phone_australia | phone_uk | zipcode_us | postal_5 | postal_code_australia | postal_code_canada | data_types_complete | survey_timestamp | email_survey | survey_complete | email_consent | dob | signature_consent | consent_complete |
        # And I should NOT see "ptname"
        # And I should NOT see "identifier"
        # And I should NOT see "identifier2"
        #M: Close csv file
        And I logout

        #SETUP
        Given I login to REDCap with the user "Test_User4_CTSP"
        Then I should see "Logged in as"

        #FUNCTIONAL REQUIREMENT: Export No Access
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.6.300.100 LTS 14.5.26"
        ##ACTION:
        And I click on the link labeled "Data Exports, Reports, and Stats"
        ##VERIFY
        Then I should see the button labeled "View Report"
        Then I should NOT see a button labeled "Export Data"
#End
