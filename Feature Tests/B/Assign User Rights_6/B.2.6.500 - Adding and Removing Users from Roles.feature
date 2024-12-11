Feature: B.2.6.0500. Project Level:  The system shall support adding and removing users from user roles.

  As a REDCap end user
  I want to see that assign user rights is functioning as expected

  Scenario: B.2.6.0500.100 Cancel, Assign, Re-assign, & Remove User Roles
    #SETUP
    Given I login to REDCap with the user "REDCap_Admin"
    And I create a new project named "B.2.6.0500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.0500.100"
    When I click on the link labeled "User Rights"
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

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Cancel assign to role
    When I click on the link labeled "Test User1_CTSP"
    And I click on the button labeled "Assign to role" on the tooltip
    And I select "TestRole" on the dropdown field labeled "Select Role"
    And I click on the link labeled "Cancel"

    ##VERIFY
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

    ##ACTION: Assign to role
    When I click on the link labeled "Test User1_CTSP"
    And I click on the button labeled "Assign to role" on the tooltip
    # I have to select this twice. Not sure why
    And I select "TestRole" on the dropdown field labeled "Select Role"
    And I click on the button labeled exactly "Assign"

    ##VERIFY
    Then I should see a table header and rows containing the following values in a table:
      | Role name               | Username            |
      | —                       | REDCap_admin          |
      | —                       | test_user2_CTSP          |
      | —                       | test_user3_CTSP          |
      | —                       | test_user4_CTSP          |
      | 1_FullRights            | [No users assigned] |
      | 2_Edit_RemoveID         | [No users assigned] |
      | 3_ReadOnly_Deidentified | [No users assigned] |
      | 4_NoAccess_Noexport     | [No users assigned] |
      | TestRole                | test_user1_CTSP          |

    ##ACTION: Re-assign to role
    When I click on the link labeled "Test User1_CTSP"
    And I click on the button labeled "Re-assign to role" on the tooltip
    # I have to select this twice. Not sure why
    And I select "1_FullRights" on the dropdown field labeled "Select Role"
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
      | TestRole                | [No users assigned] |

    ##ACTION: Remove from role
    When I click on the link labeled "Test User1"
    And I click on the button labeled "Remove from role"

    ##VERIFY
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

    And I should see a dialog containing the following text: "User's privileges will remain the same"
    And I click on the button labeled "Close" in the dialog box
#End
