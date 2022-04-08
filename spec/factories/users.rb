FactoryBot.define do
  factory :user do
    first_name { "Name" }
    last_name { "Surname" }
    account_type { 0 }
  end

  factory :invalid_user, class: User do
    email { nil }
  end
end
