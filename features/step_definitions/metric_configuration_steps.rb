Given(/^I have a sample metric configuration within the given mezuro configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration, 
    {id: nil, configuration_id: @mezuro_configuration.id, reading_group_id: @reading_group.id} )
end

Given(/^I have another metric configuration with code "(.*?)" within the given mezuro configuration$/) do |code|
  @another_metric_configuration = FactoryGirl.create(:metric_configuration,
    {id: nil, configuration_id: @mezuro_configuration.id, reading_group_id: @reading_group.id, code: code} )
end

When(/^I visit the sample metric configuration edit page$/) do
  visit edit_mezuro_configuration_metric_configuration_path(@metric_configuration.configuration_id, @metric_configuration.id)
end

When(/^I visit the sample metric configuration page$/) do
  visit mezuro_configuration_metric_configuration_path(@metric_configuration.configuration_id, @metric_configuration.id)
end

When(/^I visit the sample metric configuration page$/) do
  visit edit_mezuro_configuration_path(@mezuro_configuration.id)
end

Then(/^I am at the sample metric configuration page$/) do
  visit mezuro_configuration_metric_configuration_path(@metric_configuration.configuration_id, @metric_configuration.id)
  page.should have_content(@metric_configuration.metric.name)
  page.should have_content("Ranges")
end

Then(/^I should see the sample metric configuration content$/) do
  page.should have_content(@metric_configuration.metric.name)
  page.should have_content(@metric_configuration.code)
  page.should have_content(@metric_configuration.weight)
end

Then(/^I should be at metric configuration sample page$/) do
  page.should have_content(@metric_configuration.metric.name)
  page.should have_content("Ranges")
end

Then(/^I should be at the choose metric page$/) do
  page.should have_content("Choose a metric from a base tool:")
end
