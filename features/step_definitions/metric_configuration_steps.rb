Given(/^I have a sample metric configuration within the given mezuro configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration, 
    {id: nil, configuration_id: @mezuro_configuration.id, reading_group_id: @reading_group.id} )
end

Then(/^I should see the sample metric configuration content$/) do
  page.should have_content(@metric_configuration.metric.name)
  page.should have_content(@metric_configuration.code)
  page.should have_content(@metric_configuration.weight)
end