Feature: A.2.2.0700. Add/Manage users

    As a REDCap end user
    I want to see that Users failed login lockout is functioning as expected.

    Scenario: A.2.2.0700.100 User account locked time
        #This feature has been tested manually in A.2.2.600 and this test has not been run 
        #This feature test is REDUNDANT and can be viewed in A.2.2.600.100
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Security & Authentication"
        Then I should see "Security & Authentication Configuration"

        Given I clear the field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
        When I enter "1" into the input field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
        And I clear the field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
        And I enter "2" into the input field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"
        And I logout

        #Login with bad password; first failed attempt at logging in
        Given I enter "Test_User1" into the input field labeled "Username:"
        And I enter "test" into the input field labeled "Password:"
        And I click on the button labeled "Log In"
        Then I should see "ERROR: You entered an invalid user name or password!"

        #Try to login again with a bad password; we will be locked out
        Given I enter "Test_User1" into the input field labeled "Username:"
        And I enter "test" into the input field labeled "Password:"
        And I click on the button labeled "Log In"
        Then I should see "ACCESS DENIED!"

        #Try logging in again after 1 minute
        Given I wait for 1 minute
        Given I attempt to login to REDCap with the user "Test_User1"
        Then I should see "ACCESS DENIED!"

        #2 minutes of waiting total; now we can login
        Given I wait for another 1 minute
        When I attempt to login to REDCap with the user "Test_User1"
        Then I should see "My Projects"
        And I logout

        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Control Center"
        Then I click on the link labeled "Security & Authentication"
        And I should see "Security & Authentication Configuration"

        Given I clear the field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
        When I enter "1" into the input field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
        And I clear the field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
        And I enter "1" into the input field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"
        And I logout

        #Login with bad password; first failed attempt at logging in
        Given I enter "Test_User1" into the input field labeled "Username:"
        And I enter "test" into the input field labeled "Password:"
        And I click on the button labeled "Log In"
        Then I should see "ERROR: You entered an invalid user name or password!"

        #Try to login again with a bad password and we will be locked out
        Given I enter "Test_User1" into the input field labeled "Username:"
        And I enter "test" into the input field labeled "Password:"
        And I click on the button labeled "Log In"
        Then I should see "ACCESS DENIED!"

        #We only have to wait for 1 minute total this time
        Given I wait for 1 minute
        When I attempt to login to REDCap with the user "Test_User1"
        Then I should see "My Projects"
        And I logout
#End
