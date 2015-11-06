require 'kalibro_client/errors'

Given(/^I am at the All Projects page$/) do
  visit projects_path
end

Given(/^I have a sample project$/) do
  @project = FactoryGirl.create(:project)
  @project.attributes = FactoryGirl.create(:project_attributes, project: @project)
end

Given(/^I have a project named "(.*?)"$/) do |name|
  @project = FactoryGirl.create(:project, {name: name})
  @project.attributes = FactoryGirl.create(:project_attributes, project: @project)
end

Given(/^I own a sample project$/) do
  @project = FactoryGirl.create(:project)
  FactoryGirl.create(:project_attributes, {user_id: @user.id, project_id: @project.id})
end

Given(/^I own a project named "(.*?)"$/) do |name|
  @project = FactoryGirl.create(:project, {name: name})
  FactoryGirl.create(:project_attributes, {user_id: @user.id, project_id: @project.id})
end

Given(/^I am at the Sample Project page$/) do
  visit project_path(id: @project.id)
end

Given(/^I am at the sample project edit page$/) do
  visit edit_project_path(id: @project.id)
end

Given(/^I visit the sample project edit page$/) do
  visit edit_project_path(id: @project.id)
end

Given(/^I am at the New Project page$/) do
  visit new_project_path
end

Then(/^I should not see "(.+)"$/) do |text|
  expect(page).to_not have_content(text)
end

Then(/^I should not see (.+) within (.+)$/) do |text, selector|
  expect(page.find(selector)).to_not have_content(text)
end

Then(/^I should not find "(.+)" within "(.+)"$/) do |text, selector|
  step "I should not see #{text} within #{selector}"
end

Then(/^the sample project should be there$/) do
  expect(page).to have_content(@project.name)
  expect(page).to have_content(@project.description)
end

Then(/^I should be in the All Projects page$/) do
  expect(page).to have_content("Projects")
end

Then(/^I should be in the Edit Project page$/) do
  expect(page).to have_content("Edit Project")
end

Then(/^I should be in the Sample Project page$/) do
  expect(page).to have_content(@project.name)
  expect(page).to have_content(@project.description)
end

Then(/^I should be in the Login page$/) do
  expect(page).to have_content("Sign in")
end

Then(/^the sample project should not be there$/) do
  expect { Project.find(@project.id) }.to raise_error
end

Then(/^The field "(.*?)" should be filled with the sample project "(.*?)"$/) do |field, value|
  expect(page.find_field(field).value).to eq(@project.send(value))
end
