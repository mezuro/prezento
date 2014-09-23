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

Then(/^I should see the custom project image$/) do
	pager = page.body
  var = (pager =~ /#{@image_url}/)
  var.should_not be_nil
end