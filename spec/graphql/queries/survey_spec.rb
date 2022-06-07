require "rails_helper"

RSpec.describe "query survey" do
  it "returns first survey's label" do
    FactoryBot.create(:survey, label: 'test survey')
    FactoryBot.create(:survey, label: 'test survey 2')
    query = <<~GQL
    query {
      survey(id:1) {
        label
      }
    }
    GQL

    result = SurveysSchema.execute(query)

    expect(result.dig("data", "survey", "label")).to eq("test survey")
  end

  it "returns all surveys labels" do
    FactoryBot.create(:survey, label: 'test survey')
    FactoryBot.create(:survey, label: 'test survey 2')
    query = <<~GQL
    query {
      surveys {
        label
      }
    }
    GQL

    result = SurveysSchema.execute(query)

    expect(result.dig("data", "surveys").map{|x| x.values}.flatten).to eq(["test survey", "test survey 2"])
  end
end
  