FactoryGirl.define do
  factory :repository, class: Repository do
    id 1
    name "QtCalculator"
    description "A simple calculator"
    license "GPLv3"
    process_period 1
    type "SVN"
    address "svn://svn.code.sf.net/p/qt-calculator/code/trunk"
    configuration_id 1
    project_id 1
    send_email "test@test.com"
  end

  factory :another_repository, class: KalibroEntities::Entities::Repository, parent: :repository do
    id 2
  end
end