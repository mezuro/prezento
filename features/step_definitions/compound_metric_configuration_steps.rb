Given(/^I see the sample metric configuration name$/) do
  page.should have_content(@metric_configuration.metric.name)
end

Given(/^I see the sample metric configuration code$/) do
  page.should have_content(@metric_configuration.code)
end

Given(/^I have a sample compound metric configuration within the given mezuro configuration$/) do
  @compound_metric_configuration = FactoryGirl.create(:compound_metric_configuration, {id: nil, configuration_id: @mezuro_configuration.id, reading_group_id: @reading_group.id})
end

Given(/^I have another compound metric configuration with code "(.*?)" within the given mezuro configuration$/) do |code|
  @another_compound_metric_configuration = FactoryGirl.create(:compound_metric_configuration, {id: nil, configuration_id: @mezuro_configuration.id, code: code, reading_group_id: @reading_group.id})
end

When(/^I visit the sample compound metric configuration edit page$/) do
  visit edit_mezuro_configuration_compound_metric_configuration_path(@compound_metric_configuration.configuration_id, @compound_metric_configuration.id)
end

When(/^I click the edit link of the Coumpound Metric$/) do
  page.find('tr', :text => @compound_metric_configuration.metric.name).click_link('Edit')
end

Then(/^I should be at compound metric configuration sample page$/) do
  page.should have_content(@compound_metric_configuration.metric.name)
  page.should have_content("Ranges")
end
