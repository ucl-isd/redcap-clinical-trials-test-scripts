Feature: A.2.3.300 Assign administrators and account managers

  As a REDCap end user
  I want to see that Assign Super Users / Account Managers is functioning as expected

Scenario: A.2.3.300.100 Modify and Revoke Admin's User Rights
#SETUP control center
Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Administrator Privileges"
Then I should see "Set administrator privileges"

#FUNCTIONAL REQUIREMENT
##ACTION Add administrator #A.2.3.200.100
When I enter "Test_User1" into the field with the placeholder text of "Search users to add as admin"
    And I enable the Administrator Privilege "Set administrator privileges" for a new administrator
    And I click on the button labeled "Add"
Then I should see 'The user "Test_User1" has now been granted one or more administrator privileges'
    And I click on the button labeled "OK"
    And I should see "Test_User1"

##VERIFY added administrator
When I click on the link labeled "Control Center"
    And I click on the link labeled "Administrator Privileges"
Then I should see "Set administrator privileges"
    And I enable the Administrator Privilege "Manage user accounts" for the administrator "Test_User1"
    And I enable the Administrator Privilege "Modify system configuration pages" for the administrator "Test_User1"

Given I logout

##VERIFY new administrator access to control center
Given I login to REDCap with the user "Test_User1"
When I click on the link labeled "Control Center"
Then I should see "Control Center Home"
    And I should see a link labeled "Browse Projects"
    And I should see a link labeled "Browse Users"
    And I should see a link labeled "Multi-Language Management"
    And I should see a link labeled "General Configuration"

Given I logout

##ACTION change new admins rights
Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Administrator Privileges"
Then I should see "Set administrator privileges"

Given I enable the Administrator Privilege "Access to Control Center dashboards" for the administrator "Test_User1"
When I disable the Administrator Privilege "Set administrator privileges" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Manage user accounts" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Modify system configuration pages" for the administrator "Test_User1"
    And I logout

##VERIFY limited admin rights
Given I login to REDCap with the user "Test_User1"
Then I should see a link labeled "Control Center"

Given I logout

##ACTION Remove new admin #A.2.3.200.100
Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Administrator Privileges"
Then I should see "Set administrator privileges"

Given I disable the Administrator Privilege "Set administrator privileges" for the administrator "Test_User1"
Then I should see a dialog containing the following text: "Please be aware that you have unchecked ALL the administrator privileges for this user"

Given I click on the button labeled "Close" in the dialog box
    When I click on the link labeled "Administrator Privileges"
Then I should see "Set administrator privileges"
    And I should NOT see "Test_User1"

Given I logout

##VERIFY user is no longer admin.
When I login to REDCap with the user "Test_User1"
Then I should NOT see a link labeled "Control Center"
    
