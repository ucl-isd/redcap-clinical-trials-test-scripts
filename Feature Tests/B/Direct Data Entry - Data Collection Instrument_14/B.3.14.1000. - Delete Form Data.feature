Feature: Deleting Data: The system shall allow users to delete all data on the current form of a given record.

  As a REDCap end user
  I want to see that delete record is functioning as expected

  Scenario: B.3.14.1000.100 Delete all data in a form for a record form
    ###ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
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
    And I create a new project named "B.3.14.1000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    #SET UP_USER_RIGHTS
    When I click on the link labeled "User Rights"
    And I enter "Test_User1_CTSP" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

    ##ACTION
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Survey" instrument on event "Event Three" for record ID "1" and click on the bubble
    Then I should see "Name" in the data entry form field "Name"
    And I should see a button labeled "Delete data for THIS FORM only"

    #FUNCTIONAL_REQUIREMENT
    When I click on the button labeled "Delete data for THIS FORM only"
    And I click on the button labeled "Delete data for THIS FORM only" in the dialog box
    Then I should see "Record ID 1 successfully edited."

    Given I click on the link labeled "Record Status Dashboard"
    Then I should see the "Incomplete (no data saved)" icon for the "Survey" longitudinal instrument on event "Event Three" for record "1"

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action         | List of Data Changes OR Fields Exported |
      | test_user1_CTSP | Update record1 | email_survey = ''                       |
      | test_user1_CTSP | Update record1 | name_survey = ''                        |
      | test_user1_CTSP | Update record1 | survey_complete = ''                    |

    ##VERIFY_DE
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | email_survey | name_survey | survey_complete |
      | 1         |              |             | Incomplete (0)  |
#END
