require "rails_helper"

RSpec.describe "query question group" do

  it "returns first question group's label" do
    FactoryBot.create(:question_group, label: 'test question group')
    FactoryBot.create(:question_group, label: 'test question group 2')

    query = <<~GQL
    query {
      question_group(id:1) {
        label
      }
    }
    GQL

    result = SurveysSchema.execute(query)

    expect(result.dig("data", "question_group", "label")).to eq("test question group")
  end

  it "returns all question groups labels" do
    FactoryBot.create(:question_group, label: 'test question group')
    FactoryBot.create(:question_group, label: 'test question group 2')

    query = <<~GQL
    query {
      question_groups {
        label
      }
    }
    GQL

    result = SurveysSchema.execute(query)

    expect(result.dig("data", "question_groups").map{|x| x.values}.flatten).to eq(["test question group", "test question group 2"])
  end
end