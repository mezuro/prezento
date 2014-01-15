require 'kalibro_gem/errors'

Given(/^I own a sample reading group$/) do
  @reading_group = FactoryGirl.create(:reading_group, {id: nil})
  FactoryGirl.create(:reading_group_ownership, {user_id: @user.id, reading_group_id: @reading_group.id})
end

Given(/^I have a sample reading group$/) do
  @reading_group = FactoryGirl.create(:reading_group, {id: nil})
end

Given(/^I visit the Sample Reading Group page$/) do
  visit reading_group_path(@reading_group.id)
end

When(/^I am at the Sample Reading Group page$/) do
  p @reading_group
  page.should have_content(@reading_group.name)
  page.should have_content(@reading_group.description)
end

Then(/^I should be in the Sample Reading Group page$/) do
  page.should have_content(@reading_group.name)
  page.should have_content(@reading_group.description)
end