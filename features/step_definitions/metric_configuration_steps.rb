Given(/^I have a sample tree metric configuration within the given mezuro configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration_with_id,
    {kalibro_configuration_id: @kalibro_configuration.id, reading_group_id: @reading_group.id} )
end

Given(/^I have a sample hotspot metric configuration within the given mezuro configuration$/) do
  @metric_configuration = FactoryGirl.create(:hotspot_metric_configuration,
                                             kalibro_configuration_id: @kalibro_configuration.id)
end


Given(/^I have a metric configuration with code "(.*?)" within the given mezuro configuration$/) do |code|
  @metric_configuration = FactoryGirl.create(:metric_configuration_with_id,
    {kalibro_configuration_id: @kalibro_configuration.id, reading_group_id: @reading_group.id, metric: FactoryGirl.build(:metric, code: code)})
end

Given(/^I have a sample configuration with MetricFu metrics$/) do
  reading_group = FactoryGirl.create(:reading_group)
  FactoryGirl.create(:reading, {reading_group_id: reading_group.id})

  @kalibro_configuration = FactoryGirl.create(:kalibro_configuration)
  FactoryGirl.create(:metric_configuration,
                                            {metric: FactoryGirl.build(:pain),
                                             reading_group_id: reading_group.id,
                                             kalibro_configuration_id: @kalibro_configuration.id})
  FactoryGirl.create(:metric_configuration,
                                            {metric: FactoryGirl.build(:saikuro),
                                             reading_group_id: reading_group.id,
                                             kalibro_configuration_id: @kalibro_configuration.id})
end

Given(/^I have a tree metric configuration$/) do
  @tree_metric_configuration = FactoryGirl.create(:metric_configuration_with_id,
    {kalibro_configuration_id: @kalibro_configuration.id, metric: FactoryGirl.build(:hotspot_metric)})
end

Given(/^I have a hotspot metric configuration$/) do
  @hotspot_metric_configuration = FactoryGirl.create(:metric_configuration_with_id,
    {kalibro_configuration_id: @kalibro_configuration.id, metric: FactoryGirl.build(:pain)})
end

When(/^I visit the sample metric configuration edit page$/) do
  visit edit_kalibro_configuration_metric_configuration_path(kalibro_configuration_id: @metric_configuration.kalibro_configuration_id, id: @metric_configuration.id)
end

When(/^I visit the sample metric configuration page$/) do
  visit kalibro_configuration_metric_configuration_path(kalibro_configuration_id: @metric_configuration.kalibro_configuration_id, id: @metric_configuration.id)
end

When(/^I visit the sample metric configuration page$/) do
  visit edit_kalibro_configuration_path(id: @kalibro_configuration.id)
end

Then(/^I am at the sample metric configuration page$/) do
  visit kalibro_configuration_metric_configuration_path(kalibro_configuration_id: @metric_configuration.kalibro_configuration_id, id: @metric_configuration.id)
  expect(page).to have_content(@metric_configuration.metric.name)
  expect(page).to have_content("Ranges")
end

Then(/^I should see the sample tree metric configuration content$/) do
  expect(page).to have_content(@metric_configuration.metric.name)
  expect(page).to have_content(@metric_configuration.metric.code)
  expect(page).to have_content(@metric_configuration.weight)
end

Then(/^I should see the sample hotspot metric configuration content$/) do
  expect(page).to have_content(@metric_configuration.metric.name)
  expect(page).to have_content(@metric_configuration.metric.code)
end

Then(/^I should be at metric configuration sample page$/) do
  expect(page).to have_content(@metric_configuration.metric.name)
  expect(page).to have_content("Ranges")
end

Then(/^I should be at the choose metric page$/) do
  expect(page).to have_content("Choose a metric from a Base Tool:")
end

Then(/^the tree configuration should be there$/) do
  expect(page).to have_content(@tree_metric_configuration.metric.name)
  expect(page).to have_content(@tree_metric_configuration.metric.code)
end

Then(/^the hotspot configuration should be there$/) do
  expect(page).to have_content(@hotspot_metric_configuration.metric.name)
  expect(page).to have_content(@hotspot_metric_configuration.metric.code)
end

When(/^I click destroy Metric Configuration$/) do
  find('#tree_metrics').first(:link, "Destroy").click
end
