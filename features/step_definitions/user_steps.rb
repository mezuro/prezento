When(/^I click the (.+) link$/) do |text|
  click_link text
end

When(/^I click the (.+) image$/) do |image|
  find(:xpath, "//a/img[@alt='#{image}']/..").click
  sleep(1) #This sleep is essential to make the popup visible when we take a picture of the page
end

When(/^I press the (.+) button$/) do |text|
  click_button text
end

When(/^I fill the (.+) field with "(.+)"$/) do |field, text|
  fill_in field, :with => text
end

Then(/^my name should have changed to (.+)$/) do |text|
  @user.reload
  @user.name.should eq(text)
end

Then(/^I should be in the User Projects page$/) do
  page.should have_content("#{@user.name} Projects")
end

When(/^I take a picture of the page$/) do
  page.save_screenshot("/tmp/picture.png")
end
