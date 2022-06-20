# frozen_string_literal: true

FactoryBot.define do
  factory :question_group do
    association :survey
    label { 'test question group' }
  end
end
