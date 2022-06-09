FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "test#{n}@test.com" }
    first_name { "Test" }
    last_name { "Test" }
    password { "testtest" }
  end
end