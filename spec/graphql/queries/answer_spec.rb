require "rails_helper"

RSpec.describe "query answer" do
  subject(:result) { SurveysSchema.execute(query) }

  describe 'one answer' do
    let(:answer1) { FactoryBot.create(:answer, answer_val: 3.0) }
    let(:answer2) { FactoryBot.create(:answer, answer_val: 5.0) }
    let(:query) { <<~GQL
      query {
        answer(id:#{answer1.id}) {
          answerVal
        }
      }
      GQL
    }

    it "returns first answer's answer val" do
      expect(result.dig("data", "answer", "answerVal")).to eq(3.0)
    end
  end

  describe 'all answers' do
    let!(:answer1) { FactoryBot.create(:answer, answer_val: 3.0) }
    let!(:answer2) { FactoryBot.create(:answer, answer_val: 5.0) }
    let(:query) { <<~GQL
      query {
        answers {
          answerVal
        }
      }
      GQL
    }
    it "returns all answers answer vals" do
      expect(result.dig("data", "answers").map{|x| x.values}.flatten).to eq([3.0, 5.0])
    end
  end
end