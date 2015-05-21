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
  FactoryGirl.create(:kalibro_configuration_attributes, user_id: FactoryGirl.create(:another_user).id, kalibro_configuration_id: @kalibro_configuration.id)

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

Given(/^there is a public configuration created$/) do
  @public_kc = FactoryGirl.create(:public_kalibro_configuration)
  FactoryGirl.create(:kalibro_configuration_attributes, kalibro_configuration_id: @public_kc.id)
end

Given(/^there is a private configuration created$/) do
  @private_kc = FactoryGirl.create(:another_kalibro_configuration)
  FactoryGirl.create(:kalibro_configuration_attributes, :private, kalibro_configuration_id: @private_kc.id, user: FactoryGirl.create(:another_user, id: nil, email: "private@email.com"))
end

Then(/^the public configuration should be there$/) do
  expect(page).to have_content(@public_kc.name)
  expect(page).to have_content(@public_kc.description)
end

Then(/^the private configuration should not be there$/) do
  expect(page).to have_no_content(@private_kc.name)
  expect(page).to have_no_content(@private_kc.description)
end

