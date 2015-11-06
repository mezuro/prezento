Feature: Repository Creation
  In order to register my repositories
  As a regular user
  I should be able to create repositories

@kalibro_configuration_restart @kalibro_processor_restart @javascript
Scenario: repository creation associated with a project
  Given I am a regular user
  And I am signed in
  And I own a sample project
  And I have a sample configuration with native metrics
  And I am at the New Repository page
  And I fill the Name field with "Kalibro"
  And I fill the Description field with "Description"
  And I set the select field "License" as "ISC License (ISC)"
  When I set the select field "Type" as "SVN"
  Then I should not see "Branch"
  When I set the select field "Type" as "GIT"
  Then I should see "Branch"
  Given I fill the Address field with "https://github.com/mezuro/kalibro_client.git"
  And I set the select field "Branch" as "master"
  And I set the select field "Process Period" as "1 day"
  And I set the select field "Configuration" as "Java"
  When I press the Save button
  Then I should see the saved repository's content
  When I am at the Sample Project page
  Then I should see the sample repository name

@kalibro_configuration_restart @kalibro_processor_restart @javascript
Scenario: repository creation blank validations
  Given I am a regular user
  And I am signed in
  And I own a sample project
  And I have a sample configuration with native metrics
  And I am at the New Repository page
  And I fill the Name field with " "
  And I fill the Address field with " "
  And I set the select field "License" as "ISC License (ISC)"
  And I set the select field "Type" as "GIT"
  And I set the select field "Process Period" as "1 day"
  And I set the select field "Configuration" as "Java"
  When I press the Save button
  Then I should see "Name can't be blank"
  And I should see "Address can't be blank"

@kalibro_configuration_restart @kalibro_processor_restart @javascript
Scenario: repository creation with name already taken
  Given I am a regular user
  And I am signed in
  And I have a sample configuration with native metrics
  And I have a sample repository named "KalibroEntities"
  And I am at the New Repository page
  And I fill the Name field with "KalibroEntities"
  And I fill the Description field with "Description"
  And I set the select field "License" as "ISC License (ISC)"
  And I fill the Address field with "https://github.com/mezuro/kalibro_client.git"
  And I set the select field "Type" as "GIT"
  And I set the select field "Process Period" as "1 day"
  And I set the select field "Configuration" as "Java"
  When I press the Save button
  Then I should see "Name has already been taken"

@kalibro_configuration_restart @kalibro_processor_restart @javascript
Scenario: Repository name with whitespaces
  Given I am a regular user
  And I am signed in
  And I own a sample project
  And I have a sample configuration with native metrics
  And I have a sample repository within the sample project named "Kalibro Entities"
  And I am at the New Repository page
  And I fill the Name field with "   Kalibro Entities  "
  And I set the select field "License" as "ISC License (ISC)"
  And I fill the Address field with "https://github.com/mezuro/kalibro_client.git"
  And I set the select field "Type" as "GIT"
  And I set the select field "Process Period" as "1 day"
  And I set the select field "Configuration" as "Java"
  When I press the Save button
  Then I should see "Name has already been taken"

@kalibro_configuration_restart @kalibro_processor_restart @javascript
Scenario: Create repository without project
  Given I am a regular user
  And I am signed in
  And I have a sample configuration with native metrics
  And I am at the New Repository page
  And I fill the Name field with "Kalibro Client"
  And I set the select field "License" as "ISC License (ISC)"
  And I fill the Address field with "https://github.com/mezuro/kalibro_client.git"
  And I set the select field "Type" as "GIT"
  And I set the select field "Process Period" as "1 day"
  And I set the select field "Configuration" as "Java"
  When I press the Save button
  Then I should see the saved repository's content
