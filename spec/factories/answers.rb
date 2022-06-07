FactoryBot.define do
  factory :answer do
    association :question
    association :user
    answer_val { 3.0 }
  end
end