require "rails_helper"

RSpec.describe "query question" do
  subject(:result) { SurveysSchema.execute(query) }

  describe 'one question' do
    let(:question1) { FactoryBot.create(:question, questiontype: 'test question') }
    let(:question2) { FactoryBot.create(:question, questiontype: 'test question 2') }
    let(:query) { <<~GQL
      query {
        question(id:#{question1.id}) {
          questiontype
        }
      }
      GQL
    }

    it "returns first question's questiontype" do
      expect(result.dig("data", "question", "questiontype")).to eq("test question")
    end
  end

  describe 'all questions' do
    let!(:question1) { FactoryBot.create(:question, questiontype: 'test question') }
    let!(:question2) { FactoryBot.create(:question, questiontype: 'test question 2') }
    let(:query) { <<~GQL
      query {
        questions {
          questiontype
        }
      }
      GQL
    }
    it "returns all questions questiontypes" do
      expect(result.dig("data", "questions").map{|x| x.values}.flatten).to eq(["test question", "test question 2"])
    end
  end
end