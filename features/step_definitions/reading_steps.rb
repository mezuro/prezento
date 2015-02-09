Given(/^I have a sample reading within the module result$/) do
  @reading = FactoryGirl.create(:reading, {reading_group_id: @reading_group.id})
end

Given(/^I am at the New Reading page$/) do
  visit new_reading_group_reading_path(@reading_group.id)
end

Given(/^I am at the Edit Reading page$/) do
  visit edit_reading_group_reading_url(@reading_group.id, @reading.id)
end

Given(/^I have a sample reading within the sample reading group labeled "(.*?)"$/) do |label|
  @reading = FactoryGirl.create(:reading, {label: label, reading_group_id: @reading_group.id})
end

When(/^I click the "(.*?)" td$/) do |text|
  page.find('td', text: text).methods
end

When(/^I click on the center of the color picker$/) do
  page.find('div.colorpicker_color').click
end

Then(/^I should be at the New Reading page$/) do
  visit new_reading_group_reading_path(@reading_group.id)
end

Then(/^I should see a color picker Canvas$/) do
  page.find('div.colorpicker')
end
