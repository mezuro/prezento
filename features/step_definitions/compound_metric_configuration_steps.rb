Given(/^I see the sample metric configuration name$/) do
  page.should have_content(@metric_configuration.metric.name)
end

Given(/^I see the sample metric configuration code$/) do
  page.should have_content(@metric_configuration.code)
end

