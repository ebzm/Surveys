require "rails_helper"

RSpec.describe "query answer" do
  subject(:result) { execute_query(query, variables: variables).to_h }
  let(:variables) { {} }

  describe 'one answer' do
    let(:answer1) { FactoryBot.create(:answer, answer_val: 3.0) }
    let(:answer2) { FactoryBot.create(:answer, answer_val: 5.0) }
    let(:query) { <<~GRAPHQL }
      query Answer($answerId: ID!) {
        answer(id :$answerId) {
          answerVal
        }
      }
      GRAPHQL

    let(:variables) { { "answerId" => answer1.id.to_s } }

    it "returns first answer's answer val" do
      expect(result.dig("data", "answer", "answerVal")).to eq(3.0)
    end
  end

  describe 'all answers' do
    let!(:answer1) { FactoryBot.create(:answer, answer_val: 3.0) }
    let!(:answer2) { FactoryBot.create(:answer, answer_val: 5.0) }
    let(:query) { <<~GRAPHQL }
      query {
        answers {
          answerVal
        }
      }
      GRAPHQL

    it "returns all answers answer vals" do
      expect(result.dig("data", "answers").map{|x| x.values}.flatten).to eq([3.0, 5.0])
    end
  end
end