Feature: User Interface: The system shall require the event name in the csv file when importing data to a longitudinal study.

  As a REDCap end user
  I want to see that Data import is functioning as expected

  Scenario: B.3.16.0700.100 Import requires the event name
    #TEST FOR B.3.16.0300 The system shall highlight data modifications for user confirmation.

    Given I login to REDCap with the user "REDCap_Admin"
    And I create a new project named "B.3.16.0700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION
    When I click on the link labeled "Data Import Tool"
    And I click on the tab labeled "CSV import"

    When I upload a "csv" format file located at "import_files/B316700100_DATA_INACCURATE.csv", by clicking the button near "Upload your CSV file" to browse for the file, and clicking the button labeled "Upload" to upload the file
    And I click the button labeled "Upload File"
    Then I should see "ERROR:"
    And I click on the link labeled "RETURN TO PREVIOUS PAGE"

    When I upload a "csv" format file located at "import_files/B316700100_DATA_ACCURATE.csv", by clicking the button near "Upload your CSV file" to browse for the file, and clicking the button labeled "Upload" to upload the file
    And I click the button labeled "Upload File"
    Then I should see "Your document was uploaded successfully and is ready for review"

    When I click on the button labeled "Import Data"
    Then I should see "Import Successful!"
#End
