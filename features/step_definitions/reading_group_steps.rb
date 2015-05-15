require 'kalibro_client/errors'

Given(/^I am at the All Reading Groups page$/) do
  visit reading_groups_path
end

Given(/^I am at the New Reading Group page$/) do
  visit new_reading_group_path
end

Given(/^I have a reading group named "(.*?)"$/) do |name|
  @reading_group = FactoryGirl.create(:reading_group, {name: name})
end

Given(/^I own a sample reading group$/) do
  @reading_group = FactoryGirl.create(:reading_group)
  FactoryGirl.create(:reading_group_attributes, {user_id: @user.id, reading_group_id: @reading_group.id})
end

Given(/^I have a sample reading group$/) do
  @reading_group = FactoryGirl.create(:reading_group)
end

Given(/^I visit the Sample Reading Group page$/) do
  visit reading_group_path(id: @reading_group.id)
end

Given(/^I am at the sample reading group edit page$/) do
  visit edit_reading_group_path(id: @reading_group.id)
end

Given(/^I own a reading group named "(.*?)"$/) do |name|
  @reading_group = FactoryGirl.create(:reading_group, {name: name})
  FactoryGirl.create(:reading_group_attributes, {user_id: @user.id, reading_group_id: @reading_group.id})
end

When(/^I visit the sample reading group edit page$/) do
  visit edit_reading_group_path(id: @reading_group.id)
end

Then(/^The field "(.*?)" should be filled with the sample reading group "(.*?)"$/) do |field, value|
  expect(page.find_field(field).value).to eq(@reading_group.send(value))
end

Then(/^I should be in the Sample Reading Group page$/) do
  expect(page).to have_content(@reading_group.name)
  expect(page).to have_content(@reading_group.description)
end

Then(/^I should see the information of the sample reading$/) do
  expect(page).to have_content(@reading.label)
  expect(page).to have_content(@reading.grade)
  pager = page.body
  color = @reading.color
  var = (pager =~ /#{color}/)
  expect(var).to_not be_nil
end

Then(/^I should be in the Edit Reading Group page$/) do
  visit edit_reading_group_path(id: @reading_group.id)
end

Then(/^the Sample Reading Group should not be there$/) do
  expect { ReadingGroup.find(@reading_group.id) }.to raise_error
end
