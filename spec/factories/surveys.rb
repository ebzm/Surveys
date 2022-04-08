FactoryBot.define do
  factory :survey do
    id { 1 }
    label { "label" }
  end

  factory :invalid_survey, class: Survey do
    id { nil }
  end
end