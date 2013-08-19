Given(/^I am at the All Projects page$/) do
  visit projects_path
end

Given(/^I have a sample project$/) do
  @project = FactoryGirl.create(:project)
end

Given(/^I am at the Sample Project page$/) do
  visit  "#{projects_path}/#{@project.id}"
end

Then(/^I should not see (.+)$/) do |text|
  page.should_not have_content(text)
end

Then(/^the sample project should be there$/) do
  page.should have_content(@project.name)
  page.should have_content(@project.description)
end

Then(/^I should be in the All Projects page$/) do
  page.should have_content("Listing Projects")
end
