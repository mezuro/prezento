Given(/^I am at the All Configurations page$/) do
  visit mezuro_configurations_path
end

Given(/^I am at the New Configuration page$/) do
  visit new_mezuro_configuration_path
end

Given(/^I have a configuration named "(.*?)"$/) do |name|
  @mezuro_configuration = FactoryGirl.create(:mezuro_configuration, {id: nil, name: name})
end

Given(/^I have a sample configuration$/) do
  @mezuro_configuration = FactoryGirl.create(:mezuro_configuration, {id: nil})
end

Given(/^I own a sample configuration$/) do
  @mezuro_configuration = FactoryGirl.create(:mezuro_configuration, {id: nil})
  FactoryGirl.create(:mezuro_configuration_ownership, {id: nil, user_id: @user.id, mezuro_configuration_id: @mezuro_configuration.id})
end

Given(/^I am at the Sample Configuration page$/) do
  visit mezuro_configuration_path(@mezuro_configuration.id)
end

Given(/^I am at the sample configuration edit page$/) do
  visit edit_mezuro_configuration_path(@mezuro_configuration.id)
end

Given(/^I own a configuration named "(.*?)"$/) do |name|
  @mezuro_configuration = FactoryGirl.create(:mezuro_configuration, {id: nil, name: name})
  FactoryGirl.create(:mezuro_configuration_ownership, {id: nil, user_id: @user.id, mezuro_configuration_id: @mezuro_configuration.id})
end

When(/^I visit the sample configuration edit page$/) do
  visit edit_mezuro_configuration_path(@mezuro_configuration.id)
end

Then(/^I should be in the Edit Configuration page$/) do
  page.should have_content("Edit Configuration")
end

Then(/^The field "(.*?)" should be filled with the sample configuration "(.*?)"$/) do |field, value|
  page.find_field(field).value.should eq(@mezuro_configuration.send(value))
end

Then(/^I should be in the All configurations page$/) do
  page.should have_content("Configurations")
end

Then(/^the sample configuration should not be there$/) do
  expect { MezuroConfiguration.find(@mezuro_configuration.id) }.to raise_error 
end

Then(/^the sample configuration should be there$/) do
  page.should have_content(@mezuro_configuration.name)
  page.should have_content(@mezuro_configuration.description)
end