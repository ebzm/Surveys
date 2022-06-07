require "rails_helper"

RSpec.describe "query question" do

  it "returns first question's questiontype" do
    FactoryBot.create(:question, questiontype: 'test question')
    FactoryBot.create(:question, questiontype: 'test question 2')

    query = <<~GQL
    query {
      question(id:1) {
        questiontype
      }
    }
    GQL

    result = SurveysSchema.execute(query)

    expect(result.dig("data", "question", "questiontype")).to eq("test question")
  end

  it "returns all questions questiontypes" do
    FactoryBot.create(:question, questiontype: 'test question')
    FactoryBot.create(:question, questiontype: 'test question 2')

    query = <<~GQL
    query {
      questions {
        questiontype
      }
    }
    GQL

    result = SurveysSchema.execute(query)

    expect(result.dig("data", "questions").map{|x| x.values}.flatten).to eq(["test question", "test question 2"])
  end
end