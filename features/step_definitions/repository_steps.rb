Given(/^I have a sample configuration with native metrics$/) do
  reading_group = FactoryGirl.create(:reading_group, id: nil)
  @configuration = FactoryGirl.create(:configuration, id: nil)
  metric_configuration = FactoryGirl.create(:metric_configuration,
                                            {id: nil,
                                             reading_group_id: reading_group.id,
                                             configuration_id: @configuration.id})
end

Given(/^I have a sample repository within the sample project$/) do
  @repository = FactoryGirl.create(:repository, {project_id: @project.id, 
                                                 configuration_id: @configuration.id, id: nil})
end

Given(/^I have a sample repository within the sample project named "(.+)"$/) do |name|
  @repository = FactoryGirl.create(:repository, {project_id: @project.id, 
                                                 configuration_id: @configuration.id, id: nil, name: name})
end

Given(/^I start to process that repository$/) do
  @repository.process
end

Given(/^I wait up for a ready processing$/) do
  unless Processing.has_ready_processing(@repository.id)
    while(true)
      if Processing.has_ready_processing(@repository.id)
        break
      else
        sleep(10)
      end
    end
  end
end

Given(/^I am at the New Repository page$/) do
  visit new_project_repository_path(@project.id)
end

Given(/^I am at repository edit page$/) do
  visit edit_project_repository_path(@repository.project_id, @repository.id)
end

Given(/^I ask for the last ready processing of the given repository$/) do
  @processing = Processing.last_ready_processing_of @repository.id
end

Given(/^I ask for the module result of the given processing$/) do
  @module_result = ModuleResult.find @processing.results_root_id
end

Given(/^I ask for the metric results of the given module result$/) do
  @metric_results = @module_result.metric_results
end

Given(/^I see a sample metric's name$/) do
  page.should have_content(@metric_results.first.metric_configuration_snapshot.metric.name)
end

When(/^I click on the sample metric's name$/) do
  click_link @metric_results.first.metric_configuration_snapshot.metric.name
end

When(/^I set the select field "(.+)" as "(.+)"$/) do |field, text|
  select text, from: field
end

When(/^I visit the repository show page$/) do
  visit project_repository_path(@project.id, @repository.id)
end

When(/^I click on the sample child's name$/) do
  click_link @module_result.children.first.module.name
end

Then(/^I should see the sample repository name$/) do
  page.should have_content(@repository.name)
end

Then(/^the field "(.*?)" should be filled with "(.*?)"$/) do |field, value|
  page.find_field(field).value.should eq(value)
end

Then(/^I should see the given module result$/) do
  page.should have_content(@module_result.module.name)
end

Then(/^I should see a sample child's name$/) do
  page.should have_content(@module_result.children.first.module.name)
end