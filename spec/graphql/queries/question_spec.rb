require "rails_helper"

RSpec.describe "query question" do
  subject(:result) { execute_query(query, variables: variables).to_h }
  let(:variables) { {} }

  describe 'one question' do
    let(:question1) { FactoryBot.create(:question, questiontype: 'test question') }
    let(:question2) { FactoryBot.create(:question, questiontype: 'test question 2') }
    let(:query) { <<~GRAPHQL }
      query Question($questionId: ID!) {
        question(id :$questionId) {
          questiontype
        }
      }
      GRAPHQL

    let(:variables) { { "questionId" => question1.id.to_s } }

    it "returns first question's questiontype" do
      expect(result.dig("data", "question", "questiontype")).to eq("test question")
    end
  end

  describe 'all questions' do
    let!(:question1) { FactoryBot.create(:question, questiontype: 'test question') }
    let!(:question2) { FactoryBot.create(:question, questiontype: 'test question 2') }
    let(:query) { <<~GRAPHQL }
      query {
        questions {
          questiontype
        }
      }
      GRAPHQL

    it "returns all questions questiontypes" do
      expect(result.dig("data", "questions").map{|x| x.values}.flatten).to eq(["test question", "test question 2"])
    end
  end
end