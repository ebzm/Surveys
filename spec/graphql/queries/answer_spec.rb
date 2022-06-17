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

  context 'filtering' do
    let!(:answer1) { FactoryBot.create(:answer, answer_val: 1.0) }
    let!(:answer2) { FactoryBot.create(:answer, answer_val: 3.0) }
    let!(:answer3) { FactoryBot.create(:answer, answer_val: 5.0) }
    let(:query) { <<~GRAPHQL }
    query Answer($val: Float, $min: Float, $max: Float, $indicator: String){
      answers(val: $val, min: $min, max: $max, indicator: $indicator) {
          answerVal
        }
      } 
      GRAPHQL
    
    describe 'by answer val' do
      let(:variables) { { "val" => answer2.answer_val } }

      it "returns filtered answers" do
        expect(result.dig("data", "answers").map{|x| x.values}.flatten).to eq([answer2.answer_val])
      end
    end

    describe 'by min and max val' do
      let(:variables) { { "min" => 2, "max" => 4, "indicator" => "answer_val" } }

      it "returns filtered asnwers" do
        expect(result.dig("data", "answers").map{|x| x.values}.flatten).to eq([answer2.answer_val])
      end
    end
    
    describe 'by min val' do
      let(:variables) { { "min" => 2, "indicator" => "answer_val" } }

      it "returns filtered asnwers" do
        expect(result.dig("data", "answers").map{|x| x.values}.flatten).to eq([answer2.answer_val, answer3.answer_val])
      end
    end

    describe 'by max val' do
      let(:variables) { { "max" => 4, "indicator" => "answer_val" } }

      it "returns filtered asnwers" do
        expect(result.dig("data", "answers").map{|x| x.values}.flatten).to eq([answer1.answer_val ,answer2.answer_val])
      end
    end
  end
end