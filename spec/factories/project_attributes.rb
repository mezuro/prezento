FactoryGirl.define do
  factory :project_attributes, :class => 'ProjectAttributes' do
    project_id 1
    image_url "MyString"
    user_id 1
    hidden false
  end
end
