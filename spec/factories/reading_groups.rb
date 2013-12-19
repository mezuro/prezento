FactoryGirl.define do
  factory :reading_group do
    id 1
    name "Mussum"
    description "Cacildis!"
  end

  factory :another_reading_group, class: ReadingGroup do
    id 2
    name "My Reading Group"
    description "The best one"
  end
end
