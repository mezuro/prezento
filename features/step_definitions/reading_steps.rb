Given(/^I have a sample reading within the sample reading group$/) do
  @reading = FactoryGirl.create(:reading, {group_id: @reading_group.id, id: nil})
end

