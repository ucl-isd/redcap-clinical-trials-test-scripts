Feature: A.2.2.0500. Add/Manage users

    As a REDCap end user
    I want to see that Users in tabular form is functioning as expected

    Scenario: A.2.2.0500.100 Users in tabular form
        #This feature test is REDUNDANT and can be viewed in A.2.2.300.100
        Given I login to REDCap with the user "REDCap_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Browse Users"
        Then I should see "User Search: Search for user by username, first name, last name, or primary email"

        #FUNCTIONAL REQUIREMENT
        ##ACTION View Users in tabular form
        When I click on the link labeled "View User List By Criteria"
        And I select "All users" on the dropdown field labeled "Display only:"
        And I click on the button labeled "Display User List"

        #VERIFY View Users in tabular form
        Then I should see a table header and rows containing the following values in the browse users table:
            | Username   | First Name | Last Name | Email               |
            | REDCap_admin | REDCap      | Administrator      | ctsp@ucl.ac.uk |
#End
