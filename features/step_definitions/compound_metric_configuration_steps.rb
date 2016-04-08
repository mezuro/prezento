Given(/^I see the sample metric configuration name$/) do
  expect(page).to have_content(@metric_configuration.metric.name)
end

Given(/^I see the sample metric configuration code$/) do
  expect(page).to have_content(@metric_configuration.metric.code)
end

Given(/^I have a sample compound metric configuration within the given mezuro configuration$/) do
  @compound_metric_configuration = FactoryGirl.create(:compound_metric_configuration, {kalibro_configuration_id: @kalibro_configuration.id, reading_group_id: @reading_group.id})
end

Given(/^I have another compound metric configuration with code "(.*?)" within the given mezuro configuration$/) do |code|
  @another_compound_metric_configuration = FactoryGirl.create(:compound_metric_configuration, {kalibro_configuration_id: @kalibro_configuration.id, metric: FactoryGirl.build(:compound_metric, code: code), reading_group_id: @reading_group.id})
end

Given(/^I have a compound metric configuration with script "(.+)" within the given mezuro configuration$/) do |script|
  @another_compound_metric_configuration = FactoryGirl.create(:compound_metric_configuration, kalibro_configuration_id: @kalibro_configuration.id, metric: FactoryGirl.build(:compound_metric, script: script), reading_group_id: @reading_group.id)
end

When(/^I visit the sample compound metric configuration edit page$/) do
  visit edit_kalibro_configuration_compound_metric_configuration_path(kalibro_configuration_id: @compound_metric_configuration.kalibro_configuration_id, id: @compound_metric_configuration.id)
end

When(/^I click the edit link of the Compound Metric$/) do
  page.find('tr', :text => @compound_metric_configuration.metric.name).click_link('Edit')
end

When(/^I click the show link of "(.*?)"$/) do |name|
  page.find('tr', :text => name).click_link('Show')
end

When(/^I am at the sample compound metric configuration page$/) do
  visit kalibro_configuration_compound_metric_configuration_path(kalibro_configuration_id: @compound_metric_configuration.kalibro_configuration_id, id: @compound_metric_configuration.id)
  expect(page).to have_content(@compound_metric_configuration.metric.name)
  expect(page).to have_content("Ranges")
end

Then(/^I should be at compound metric configuration sample page$/) do
  expect(page).to have_content(@compound_metric_configuration.metric.name)
  expect(page).to have_content("Ranges")
end

Then(/^I should see only tree and compound metrics in the Created Metrics list$/) do
  metrics = MetricConfiguration.metric_configurations_of(@kalibro_configuration.id).map(&:metric)
  metrics_by_code = Hash[metrics.map { |metric| [metric.code, metric] }]

  get_table_column_values('#created-metrics-accordion', 'Code') do |code|
    metric = metrics_by_code[code]
    expect(metric).not_to be_nil
    expect(%w(NativeMetricSnapshot CompoundMetricSnapshot)).to include(metric.type)
  end
end
