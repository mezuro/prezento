When(/^I click the (.+) link$/) do |text|
  click_link text
end

When(/^I press the (.+) button$/) do |text|
  click_button text
end

When(/^I fill the (.+) field with "(.+)"$/) do |field, text|
  fill_in field, :with => text
end

Then(/^the field "(.*?)" should be filled with "(.*?)"$/) do |field, value|
  expect(page.find_field(field).value).to eq(value)
end

Then(/^my name should have changed to (.+)$/) do |text|
  @user.reload
  expect(@user.name).to eq(text)
end

Then(/^I should be in the User Projects page$/) do
  expect(page).to have_content("#{@user.name} Projects")
end

When(/^I take a picture of the page$/) do
  page.save_screenshot("/tmp/picture.png")
end

When(/^I click the "(.*?)" icon$/) do |icon|
  find('#' + icon).click # the hashtag symbol is necessary to find the id of a HTML element
  sleep(1) #This sleep is essential to make the popup visible when we take a picture of the page
end
