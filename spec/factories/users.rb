FactoryBot.define do
  factory :user do
    sequence(:email){ |n| "user_#{n}@example.com" }
    password { 'user12345' }
    password_confirmation { 'user12345' }
  end
end
