Given(/^I am at the All Projects page$/) do
  visit projects_path
end

Then(/^I should not see (.+)$/) do |text|
  page.should_not have_content(text)
end