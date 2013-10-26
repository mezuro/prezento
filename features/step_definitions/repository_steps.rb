Given(/^I have a sample configuration with native metrics$/) do
  reading_group = FactoryGirl.create(:reading_group, id: nil)
  @configuration = FactoryGirl.create(:configuration, id: nil)
  metric_configuration = FactoryGirl.create(:metric_configuration,
                                            {id: nil,
                                             reading_group_id: reading_group.id,
                                             configuration_id: @configuration.id})
end

Given(/^I have a sample repository within the sample project$/) do
  @repository = FactoryGirl.create(:repository, {project_id: @project.id, configuration_id: @configuration.id, id: nil})
end

Given(/^I have a sample repository within the sample project named "(.+)"$/) do |name|
  @repository = FactoryGirl.create(:repository, {project_id: @project.id, configuration_id: @configuration.id, id: nil, name: name})
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

When(/^I set the select field "(.+)" as "(.+)"$/) do |field, text|
  select text, from: field
end

When(/^I visit the repository show page$/) do
  visit project_repository_path(@project.id, @repository.id)
end

Then(/^I should see the sample repository name$/) do
  page.should have_content(@repository.name)
end

Then(/^the field "(.*?)" should be filled with "(.*?)"$/) do |field, value|
  page.find_field(field).value.should eq(value)
end
