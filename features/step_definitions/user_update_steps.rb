When(/^I click the (.+) link$/) do |text|
  click_link text
end

When(/^I press the (.+) button$/) do |text|
  click_button text
end

When(/^I fill the (.+) field with (.+)$/) do |field, text|
  fill_in field, :with => text
end

Then(/^my name should have changed to (.+)$/) do |text|
  @user.reload
  @user.name.should eq(text)
end