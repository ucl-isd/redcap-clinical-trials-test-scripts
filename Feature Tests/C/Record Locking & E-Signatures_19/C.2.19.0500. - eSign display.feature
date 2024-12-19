Feature: User Interface: The tool shall display e-signature status of forms for all records.

    As a REDCap end user
    I want to see that Record locking and E-signatures is functioning as expected

    Scenario: C.2.19.500.100 Display e-signature

        #SETUP
        Given I login to REDCap with the user "REDCap_Admin"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
        And I create a new project named "C.2.19.500.100 LTS 14.5.26" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
        Then I should see Project status: "Production"

        #USER_RIGHTS
        When I click on the link labeled "User Rights"
        And I enter "Test_User1_CTSP" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see "Adding new user "test_user1_CTSP"

        When I click on the checkbox for the field labeled "Logging"
        And I click on the checkbox for the field labeled "Record Locking Customization"
        And I click on the radio labeled "Locking / Unlocking with E-signature authority" for the field labeled "Lock / Unlock Records (instrument level)"
        And I click on the button labeled "Close" in the dialog box
        And I click on the button labeled "Add user"
        Then I should see "User "test_user1_CTSP" was successfully added"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action              | List of Data Changes OR Fields Exported |
            | REDCap_admin | Add user test_user1_CTSP | user = 'test_user1_CTSP'                     |

        And I logout

        Given I login to REDCap with the user "Test_User1_CTSP"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.2.19.500.100 LTS 14.5.26"
        #SETUP
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I click on the button labeled "I understand. Let me make changes" in the dialog box
        And I verify the checkbox on the column labeled "Display the Lock option for this instrument?" for the Data Collection Instrument labeled "Text Validation" is selected
        And I click on the checkbox on the column labeled "Also display E-signature option on instrument?" for the Data Collection Instrument labeled "Text Validation"
        Then I should see a table header and rows including the following values in the table:
            | Display the Lock option for this instrument? | Data Collection Instrument | Also display E-signature option on instrument? |
            | [✓]                                          | Text Validation            | [✓]                                            |
            | [✓]                                          | Consent                    |                                                |


        ##ACTION
        When I click on the link labeled "Record Status Dashboard"
        And I click the bubble for the instrument labeled "Text Validation" for record "3" for event "Event 1"
        Then I should see "Text Validation"
        And I should see the checkbox for the field labeled "Lock this instrument?"
        And I should see the checkbox for the field labeled "E-signature"

        When I click on the checkbox for the field labeled "Lock this instrument?"
        And I click on the checkbox labeled "E-signature"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "E-signature: Username/password verification" in a dialog box

        Given I enter Test_User login credentials
        Then I should see "Record Home Page"
        And I should see a lock image for the Data Collection Instrument labeled "Text Validation" for event "Event 1"
        And I should see an e-signature image for the Data Collection Instrument labeled "Text Validation" for event "Event 1"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows including the following values in the logging table:
            | Username   | Action               | List of Data Changes OR Fields Exported                                    |
            | test_user1_CTSP | E-signature 3        | Action: Save e-signature, Record: 3, Form: Text Validation, Event: Event 1 |
            | test_user1_CTSP | Lock/Unlock Record 3 | Action: Lock instrument, Record: 3, Form: Text Validation, Event: Event 1  |

        #FUNCTIONAL REQUIREMENT
        ##ACTION Record lock and signature status
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I click on the button labeled "I understand. Let me make changes" in the dialog box
        And I click on the link labeled "E-signature and Locking Management"

        ##VERIFY
        Then I should see a table header and rows including the following values in the E-signature and Locking Management table:
            | Record | Form Name       | Locked?    | E-signed?         |
            | 3      | Text Validation | lock image | e-signature image |
            | 3      | Consent         |            | N/A               |
#END
