Feature: A.2.2.0300. Add/Manage users Control Center - Users: The system shall support the ability to search for individual users and view/edit user information for username, first name, last name and/or primary email.

  As a REDCap end user
  I want to see that Search Users is functioning as expected.

  Scenario: A.2.2.0300.100 Search by username, first name, last name and/or primary email

    Given I login to REDCap with the user "REDCap_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    Then I should see "View User List By Criteria"

    #FUNCTIONAL REQUIREMENT
    ##ACTION Search by username with "Keyword search"
    #Username is Redcap_Admin
    When I enter "Redcap_Admin" into the field with the placeholder text of "Keyword search"
    And I click on the button labeled "Display User List"
    #VERIFY_SEARCH
    Then I should see a table header and rows containing the following values in the browse users table:
      | Username   | First Name | Last Name | Email               |
      | REDCap_admin | REDCap      | Administrator     | ctsp@ucl.ac.uk |


    #FUNCTIONAL REQUIREMENT
    ##ACTION Search by First Name with "Keyword search"
    When I click on the link labeled "View User List By Criteria"
    And I enter "REDCap" into the field with the placeholder text of "Keyword search"
    And I click on the button labeled "Display User List"
    Then I should see a table header and rows containing the following values in the browse users table:
      | Username   | First Name | Last Name | Email               |
      | REDCap_admin | REDCap      | Administrator     | ctsp@ucl.ac.uk |

    #FUNCTIONAL REQUIREMENT
    ##ACTION Search by Last Name with "Keyword search"
    When I click on the link labeled "View User List By Criteria"
    And I enter "Administrator" into the field with the placeholder text of "Keyword search"
    And I click on the button labeled "Display User List"
    Then I should see a table header and rows containing the following values in the browse users table:
      | Username   | First Name | Last Name | Email               |
      | REDCap_admin | REDCap      | Administrator     | ctsp@ucl.ac.uk |

    #FUNCTIONAL REQUIREMENT
    ##ACTION Search by Email with "Keyword search"
    When I click on the link labeled "View User List By Criteria"
    And I enter "ctsp@ucl.ac.uk" into the field with the placeholder text of "Keyword search"
    And I click on the button labeled "Display User List"
    Then I should see a table header and rows containing the following values in the browse users table:
      | Username   | First Name | Last Name | Email               |
      | REDCap_admin | REDCap      | Administrator     | ctsp@ucl.ac.uk |

    #FUNCTIONAL REQUIREMENT
    ##ACTION Edit user information
    When I click on the link labeled "View User List By Criteria"
    And I click on the button labeled "Display User List"
    When I click on the link labeled exactly "test_user1_ctsp"
    Then I should see "Editable user attributes"
    And I click on the button labeled "Edit user info"
    And I clear the field labeled "First name:"
    And I enter "User1 CTSP" into the input field labeled "First name:"
    And I click on the button labeled "Save"
    Then I should see "User has been successfully saved."

    #VERIFY
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I enter "test_user1_ctsp" into the field with the placeholder text of "Keyword search"
    And I click on the button labeled "Display User List"
    Then I should see a table header and rows containing the following values in the browse users table:
      | Username   | First Name | Last Name | Email               |
      | test_user1_ctsp | User1 CTSP     | Test CTSP     | ctsp+Test_User1_CTSP@ucl.ac.uk |

    ##VERIFY_LOG
    When I click on the link labeled "User Activity Log"
    Then I should see a table header and rows containing the following values in a table:
      | User       | Event     |
      | REDCap_admin | Edit user |
#End
