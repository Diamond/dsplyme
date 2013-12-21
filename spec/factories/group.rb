FactoryGirl.define do
  factory :group do
    sequence(:name) { |n| "Group #{n}" }
    description "A test group"
  end
end
