Given(/^I have a sample range within the sample metric configuration with beginning "(.*?)"$/) do |beginning|
  @mezuro_range = FactoryGirl.create(:mezuro_range, {beginning: beginning, metric_configuration_id: @metric_configuration.id, 
                                     reading_id: @reading.id, id: nil})
end

Given(/^I am at the Edit Mezuro Range page$/) do
  visit edit_mezuro_configuration_metric_configuration_mezuro_range_path(@metric_configuration.configuration_id, @metric_configuration.id, @mezuro_range.id)
end

Given(/^the select field "(.*?)" is set as "(.*?)"$/) do |field, text|
  select text, from: field
end

Given(/^I have a sample range within the sample metric configuration$/) do
  @mezuro_range = FactoryGirl.create(:mezuro_range, {metric_configuration_id: @metric_configuration.id, 
                                     reading_id: @reading.id, id: nil})
end

Given(/^I have a sample range within the sample compound metric configuration$/) do
  @mezuro_range = FactoryGirl.create(:mezuro_range, {metric_configuration_id: @compound_metric_configuration.id, 
                                     reading_id: @reading.id, id: nil})
end

When(/^I am at the New Range page$/) do
  visit mezuro_configuration_metric_configuration_new_mezuro_range_path(@metric_configuration.configuration_id, @metric_configuration.id)
end

Then(/^I should be at the New Range page$/) do
  page.should have_content("New Range")
  page.should have_content("Beginning")
  page.should have_content("End")
  page.should have_content("Comments")
end

Then(/^I should see the sample range$/) do
  page.should have_content(@mezuro_range.label)
  page.should have_content(@mezuro_range.beginning)
  page.should have_content(@mezuro_range.end)
end



