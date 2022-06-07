require "rails_helper"

RSpec.describe "query answer" do

  it "returns first answer's answer val" do
    FactoryBot.create(:answer, answer_val: 3.0)
    FactoryBot.create(:answer, answer_val: 5.0)

    query = <<~GQL
    query {
      answer(id:1) {
        answer_val
      }
    }
    GQL

    result = SurveysSchema.execute(query)

    expect(result.dig("data", "answer", "answer_val")).to eq(3.0)
  end

  it "returns all answers answer vals" do
    FactoryBot.create(:answer, answer_val: 3.0)
    FactoryBot.create(:answer, answer_val: 5.0)

    query = <<~GQL
    query {
      answers {
        answer_val
      }
    }
    GQL

    result = SurveysSchema.execute(query)

    expect(result.dig("data", "answers").map{|x| x.values}.flatten).to eq([3.0, 5.0])
  end
end