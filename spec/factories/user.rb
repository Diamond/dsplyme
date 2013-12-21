FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email)    { |n| "test#{n}@email.com" }
    password "test"
    password_confirmation "test"
  end
end
