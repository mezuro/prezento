Given(/^I have a sample range within the sample metric configuration with beginning "(.*?)"$/) do |beginning|
  @mezuro_range = FactoryGirl.create(:mezuro_range, {beginning: beginning, metric_configuration_id: @metric_configuration.id, 
                                     reading_id: @reading.id, id: nil})
end

Given(/^I have a sample range within the sample metric configuration$/) do
  @mezuro_range = FactoryGirl.create(:mezuro_range, {metric_configuration_id: @metric_configuration.id, 
                                     reading_id: @reading.id, id: nil})
end

Then(/^I should be at the New Range page$/) do
  page.should have_content("New Range")
  page.should have_content("Beginning")
  page.should have_content("End")
  page.should have_content("Comments")
end

When(/^I am at the New Range page$/) do
  visit mezuro_configuration_metric_configuration_new_mezuro_range_path(@metric_configuration.configuration_id, @metric_configuration.id)
end

