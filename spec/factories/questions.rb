FactoryBot.define do
  factory :question do
    association :question_group
    questiontype { 'test question' }
  end
end