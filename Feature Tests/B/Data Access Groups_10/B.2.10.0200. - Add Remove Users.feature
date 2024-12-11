Feature: B.2.10.0200. User Interface: The system shall support adding and removing users from DAGs.
  As a REDCap end user
  I want to see that Data Access Groups is functioning as expected

  Scenario: B.2.10.0200.100 Assign & Remove User to DAG
    #SETUP
    Given I login to REDCap with the user "REDCap_Admin"
    And I create a new project named "B.2.10.0200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.0200.100"
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

    When I click on the link labeled "DAGs"
    Then I should see "Assign user to a group"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Assign User to DAG
    When I select "test_user1_CTSP (Test User1_CTSP)" on the dropdown field labeled "Assign user"
    When I select "TestGroup1" on the dropdown field labeled "to"
    And I click on the button labeled "Assign"

    ##VERIFY: DAG assignment
    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups | Users in group |
      | TestGroup1         | test_user1_CTSP     |

    ##VERIFY_LOG:
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | REDCap_admin | Manage/Design | Assign user to data access group        |
      | mm/dd/yyyy hh:mm | REDCap_admin | Manage/Design | user = 'test_user1'                     |
      | mm/dd/yyyy hh:mm | REDCap_admin | Manage/Design | group = 'TestGroup1'                    |
    And I logout

    Given I login to REDCap with the user "Test_User1_CTSP"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.0200.100"

    ##VERIFY: Access to DAG Module restricted
    And I click on the button labeled "Data Access Groups"
    Then I should see "RESTRICTED:"

    ##VERIFY_UR: DAG assignment
    When I click on the link labeled "User Rights"
    Then I should see a table header and rows containing the following values in a table:
      | Role name | Username   | Data Access Groups |
      | —         | test_user1_CTSP | TestGroup1         |

    ##VERIFY_RSD:
    When I click on the link labeled "Record Status Dashboard"
    Then I should see "No records exist yet"

    #SETUP
    And I logout
    Given I login to REDCap with the user "REDCap_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.0200.100"
    And I click on the link labeled "DAGs"
    Then I should see "Assign user to a group"

    ##ACTION: Remove DAG
    When I select "test_user1_CTSP (Test User1_CTSP)" on the dropdown field labeled "Assign user"
    When I select "[No Assignment]" on the dropdown field labeled "to"
    And I click on the button labeled "Assign"

    ##VERIFY
    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups        | Users in group          |
      | [Not assigned to a group] | test_user1_CTSP (Test User1_CTSP) |
    And I logout

    Given I login to REDCap with the user "Test_User1_CTSP"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.0200.100"

    ##VERIFY: Access to DAG Module
    And I click on the button labeled "Data Access Group"
    Then I should see "Assign user to a group"

    ##VERIFY_UR
    When I click on the link labeled "User Rights"
    Then I should see a table header and rows containing the following values in a table:
      | Role name | Username   | Data Access Groups |
      | —         | test_user1_CTSP |                    |

    ##VERIFY_RSD:
    When I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1         |
      | 2         |
      | 3         |
      | 4         |

    ##VERIFY_LOG:
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | REDCap_admin | Manage/Design | Remove user from data access group      |
      | mm/dd/yyyy hh:mm | REDCap_admin | Manage/Design | user = 'test_user1_CTSP'                     |
      | mm/dd/yyyy hh:mm | REDCap_admin | Manage/Design | group = 'TestGroup1'                    |
      | mm/dd/yyyy hh:mm | REDCap_admin | Manage/Design | Assign user to data access group        |
      | mm/dd/yyyy hh:mm | REDCap_admin | Manage/Design | user = 'test_user1_CTSP'                     |
      | mm/dd/yyyy hh:mm | REDCap_admin | Manage/Design | group = 'TestGroup1'                    |
#End
