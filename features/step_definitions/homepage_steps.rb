Given(/^I am at the homepage$/) do
  visit root_path
end

Given(/^I am signed in$/) do
  login_as(@user, :scope => :user)
end

Given(/^I am a regular user$/) do
  @user = FactoryGirl.create(:user)
end

Then(/^I should see "(.+)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^I should see "(.*?)" only "(.*?)" times$/) do |text, times|
  expect(page).to have_content(text, count: times.to_i)
end

When(/^I click the "(.*?)" flag$/) do |text|
  find(:css, "a[href='/#{text}']").click
end

Then(/^I should see "(.*?)" flag$/) do |flag|
  expect(page).to have_css(".flag-icon.flag-icon-#{flag}")
end
