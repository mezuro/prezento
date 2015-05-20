Given(/^I am at the All Configurations page$/) do
  visit kalibro_configurations_path
end

Given(/^I am at the New Configuration page$/) do
  visit new_kalibro_configuration_path
end

Given(/^I have a configuration named "(.*?)"$/) do |name|
  @kalibro_configuration = FactoryGirl.create(:kalibro_configuration, {name: name})
end

Given(/^I have a sample configuration$/) do
  @kalibro_configuration = FactoryGirl.create(:kalibro_configuration)
  FactoryGirl.create(:kalibro_configuration_attributes, {id: nil, user_id: nil, kalibro_configuration_id: @kalibro_configuration.id})

end

Given(/^I own a sample configuration$/) do
  @kalibro_configuration = FactoryGirl.create(:kalibro_configuration)
  FactoryGirl.create(:kalibro_configuration_attributes, {id: nil, user_id: @user.id, kalibro_configuration_id: @kalibro_configuration.id})
end

Given(/^I am at the Sample Configuration page$/) do
  visit kalibro_configuration_path(id: @kalibro_configuration.id)
end

Given(/^I am at the sample configuration edit page$/) do
  visit edit_kalibro_configuration_path(id: @kalibro_configuration.id)
end

Given(/^I own a configuration named "(.*?)"$/) do |name|
  @kalibro_configuration = FactoryGirl.create(:kalibro_configuration, {name: name})
  FactoryGirl.create(:kalibro_configuration_attributes, {id: nil, user_id: @user.id, kalibro_configuration_id: @kalibro_configuration.id})
end

When(/^I visit the sample configuration edit page$/) do
  visit edit_kalibro_configuration_path(id: @kalibro_configuration.id)
end

Then(/^I should be in the Edit Configuration page$/) do
  expect(page).to have_content("Edit Configuration")
end

Then(/^The field "(.*?)" should be filled with the sample configuration "(.*?)"$/) do |field, value|
  expect(page.find_field(field).value).to eq(@kalibro_configuration.send(value))
end

Then(/^I should be in the All configurations page$/) do
  expect(page).to have_content("Configurations")
end

Then(/^the sample configuration should not be there$/) do
  expect { KalibroConfiguration.find(@kalibro_configuration.id) }.to raise_error
end

Then(/^the sample configuration should be there$/) do
  expect(page).to have_content(@kalibro_configuration.name)
  expect(page).to have_content(@kalibro_configuration.description)
end
