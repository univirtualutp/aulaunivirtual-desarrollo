@core @core_group
Feature: Automatic deletion of groups and groupings
  In order to check the expected results occur when deleting groups and groupings in different scenarios
  As a teacher
  I need to create groups and groupings under different scenarios and check that the expected result occurs when attempting to delete them.

  Background:
    Given the following "courses" exist:
      | fullname | shortname | format |
      | Course 1 | C1 | topics |
    And the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
    And I log in as "teacher1"
    And I am on the "Course 1" "groups" page
    And I press "Create group"
    And I set the following fields to these values:
      | Group name | Group (without ID) |
    And I press "Save changes"
    And I press "Create group"
    And I set the following fields to these values:
      | Group name | Group (with ID) |
      | Group ID number | An ID |
    And I press "Save changes"
    And I select "Groupings" from the "jump" singleselect
    And I press "Create grouping"
    And I set the following fields to these values:
      | Grouping name | Grouping (without ID) |
    And I press "Save changes"
    And I press "Create grouping"
    And I set the following fields to these values:
      | Grouping name | Grouping (with ID) |
      | Grouping ID number | An ID |
    And I press "Save changes"
    And I select "Groups" from the "jump" singleselect

  @javascript
  Scenario: Delete groups and groupings with and without ID numbers
    Given I set the field "groups" to "Group (without ID) (0)"
    And I press "Delete selected group"
    And I press "Yes"
    Then the "groups" select box should not contain "Group (without ID) (0)"
    And I set the field "groups" to "Group (with ID) (0)"
    And I press "Delete selected group"
    And I press "Yes"
    And the "groups" select box should not contain "Group (with ID) (0)"
    And I select "Groupings" from the "jump" singleselect
    And I click on "Delete" "link" in the "Grouping (without ID)" "table_row"
    And I press "Yes"
    And I should not see "Grouping (without ID)"
    And I click on "Delete" "link" in the "Grouping (with ID)" "table_row"
    And I press "Yes"
    And I should not see "Grouping (with ID)"

  @javascript @skip_chrome_zerosize
  Scenario: Delete groups and groupings with and without ID numbers without the 'moodle/course:changeidnumber' capability
    Given the following "role capability" exists:
      | role                         | editingteacher |
      | moodle/course:changeidnumber | prevent        |
    And I am on the "Course 1" "groups" page
    When I set the field "groups" to "Group (with ID) (0)"
    Then the "Delete selected group" "button" should be disabled
    And I set the field "groups" to "Group (without ID) (0)"
    And I press "Delete selected group"
    And I press "Yes"
    And I should not see "Group (without ID)"
    And I select "Groupings" from the "jump" singleselect
    And "Delete" "link" should not exist in the "Grouping (with ID)" "table_row"
    And I click on "Delete" "link" in the "Grouping (without ID)" "table_row"
    And I press "Yes"
    And I should not see "Grouping (without ID)"
