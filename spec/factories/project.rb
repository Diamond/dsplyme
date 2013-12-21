FactoryGirl.define do
  factory :project do
    sequence(:title) { |n| "Project #{n}" }
    sequence(:identifier) { |n| "#{n}" }
    path "/dev/null"
    public false
  end
end
