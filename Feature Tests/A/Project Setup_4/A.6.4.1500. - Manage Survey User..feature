Feature: Control Center: The system shall allow the survey feature to be enabled or disabled.

    As a REDCap end user
    I want to see that survey feature is functioning as expected

    Scenario: A.6.4.1500.100 Enable and disable survey feature
    #SETUP_DEV
    Given I login to REDCap with the user "REDCap_Admin"
    And I create a new project named "A.6.4.1500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #FUNCTIONAL REQUIREMENT
    ##ACTION Disable survey feature in Control Center
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    And I select "Disabled" on the dropdown field labeled "Enable the use of surveys in projects?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"


    #VERIFY Disable survey feature in project setup
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.1500.100"
    And I click on the link labeled "Project Setup"
    Then I should NOT see "Use surveys in this project?" in the "Main project settings" section

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Enable survey mode in Control Center
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    And I select "Enabled" on the dropdown field labeled " Enable the use of surveys in projects?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY Enable survey feature in project setup
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.1500.100"
    And I click on the link labeled "Project Setup"
    Then I should see a button labeled "Disable" in the "Use surveys in this project?" row in the "Main project settings" section

    When I click on the button labeled "Disable" in the "Use surveys in this project?" row in the "Main project settings" section
    And I click on the button labeled "Disable" in the dialog box
    Then I should see a button labeled "Enable" in the "Use surveys in this project?" row in the "Main project settings" section

    ##VERIFY_LOG
    Given I click on the link labeled "Logging"
    Then I should see "This module lists all changes made to this project"
    And I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported |
      | REDCap_admin | Manage/Design | Modify project settings                 |
#End
