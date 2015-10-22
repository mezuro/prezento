Given(/^I have a sample range within the sample tree metric configuration with beginning "(.*?)"$/) do |beginning|
  @kalibro_range = FactoryGirl.create(:kalibro_range, {beginning: beginning, metric_configuration_id: @metric_configuration.id,
                                     reading_id: @reading.id})
end

Given(/^I have a sample range within the sample compound metric configuration with beginning "(.*?)"$/) do |beginning|
  @kalibro_range = FactoryGirl.create(:kalibro_range, {beginning: beginning, metric_configuration_id: @compound_metric_configuration.id,
                                     reading_id: @reading.id})
end

Given(/^I am at the Edit Kalibro Range page$/) do
  visit edit_kalibro_configuration_metric_configuration_kalibro_range_path(kalibro_configuration_id: @metric_configuration.kalibro_configuration_id, metric_configuration_id: @metric_configuration.id, id: @kalibro_range.id)
end

Given(/^I am at the Edit Kalibro Range page for the compound metric configuration$/) do
  visit edit_kalibro_configuration_metric_configuration_kalibro_range_path(kalibro_configuration_id: @compound_metric_configuration.kalibro_configuration_id, metric_configuration_id: @compound_metric_configuration.id, id: @kalibro_range.id)
end

Given(/^the select field "(.*?)" is set as "(.*?)"$/) do |field, text|
  select text, from: field
end

Given(/^I have a sample range within the sample tree metric configuration$/) do
  @kalibro_range = FactoryGirl.create(:kalibro_range, {metric_configuration_id: @metric_configuration.id,
                                     reading_id: @reading.id})
end

Given(/^I have a sample range within the sample compound metric configuration$/) do
  @kalibro_range = FactoryGirl.create(:kalibro_range, {metric_configuration_id: @compound_metric_configuration.id,
                                     reading_id: @reading.id})
end

When(/^I am at the New Range page$/) do
  visit kalibro_configuration_metric_configuration_new_kalibro_range_path(kalibro_configuration_id: @metric_configuration.kalibro_configuration_id, metric_configuration_id: @metric_configuration.id)
end

Given(/^I am at the New Range page for the compound metric configuration$/) do
  visit kalibro_configuration_metric_configuration_new_kalibro_range_path(kalibro_configuration_id: @compound_metric_configuration.kalibro_configuration_id, metric_configuration_id: @compound_metric_configuration.id)
end


Then(/^I should be at the New Range page$/) do
  expect(page).to have_content("New Range")
  expect(page).to have_content("Beginning")
  expect(page).to have_content("End")
  expect(page).to have_content("Comments")
end

Then(/^I should see the sample range$/) do
  expect(page).to have_content(@kalibro_range.label)
  expect(page).to have_content(@kalibro_range.beginning)
  expect(page).to have_content(@kalibro_range.end)
end
