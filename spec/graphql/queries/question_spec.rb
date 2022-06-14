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

  context 'sorting' do
    let!(:question1) { FactoryBot.create(:question, questiontype: '2 question') }
    let!(:question2) { FactoryBot.create(:question, questiontype: '1 question') }
    let!(:question3) { FactoryBot.create(:question, questiontype: '3 question') }
    let(:query) { <<~GRAPHQL }
    query Questions($sort: [QuestionSortInput!]) {
      questions(sort: $sort) {
          questiontype
        }
      } 
      GRAPHQL
    
    describe 'by questiontype' do
      context 'DESC direction' do
        let(:variables) { { "sort" => [{ "questiontype" => "DESC" }] } }

        it "returns sorted questions" do
          expect(result.dig("data", "questions").map{|x| x.values}.flatten).to eq([
            question3.questiontype, question1.questiontype, question2.questiontype
            ])
        end
      end

      context 'ASC direction' do
        let(:variables) { { "sort" => [{ "questiontype" => "ASC" }] } }

        it "returns sorted questions" do
          expect(result.dig("data", "questions").map{|x| x.values}.flatten).to eq([
            question2.questiontype, question1.questiontype, question3.questiontype
            ])
        end
      end
    end
  end
end