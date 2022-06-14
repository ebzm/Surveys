require "rails_helper"

RSpec.describe "query question group" do
  subject(:result) { execute_query(query, variables: variables).to_h }
  let(:variables) { {} }

  describe 'one question group' do
    let(:question_group1) { FactoryBot.create(:question_group, label: 'test question group') }
    let(:question_group2) { FactoryBot.create(:question_group, label: 'test question group 2') }
    let(:query) { <<~GRAPHQL }
      query QuestionGroup($questionGroupId: ID!) {
        questionGroup(id :$questionGroupId) {
          label
        }
      }
      GRAPHQL

    let(:variables) { { "questionGroupId" => question_group1.id.to_s } }

    it "returns first question group's label" do
      expect(result.dig("data", "questionGroup", "label")).to eq("test question group")
    end
  end

  describe 'all question groups' do
    let!(:question_group1) { FactoryBot.create(:question_group, label: 'test question group') }
    let!(:question_group2) { FactoryBot.create(:question_group, label: 'test question group 2') }
    let(:query) { <<~GRAPHQL }
      query {
        questionGroups {
          label
        }
      }
      GRAPHQL

    it "returns all question groups labels" do
      expect(result.dig("data", "questionGroups").map{|x| x.values}.flatten).to eq(["test question group", "test question group 2"])
    end
  end

  context 'sorting' do
    let!(:question_group1) { FactoryBot.create(:question_group, label: '2 question group') }
    let!(:question_group2) { FactoryBot.create(:question_group, label: '1 question group') }
    let!(:question_group3) { FactoryBot.create(:question_group, label: '3 question group') }
    let(:query) { <<~GRAPHQL }
    query QuestionGroups($sort: [QuestionGroupSortInput!]) {
      questionGroups(sort: $sort) {
          label
        }
      } 
      GRAPHQL
    
    describe 'by label' do
      context 'DESC direction' do
        let(:variables) { { "sort" => [{ "label" => "DESC" }] } }

        it "returns sorted question groups" do
          expect(result.dig("data", "questionGroups").map{|x| x.values}.flatten).to eq([
            question_group3.label, question_group1.label, question_group2.label
            ])
        end
      end

      context 'ASC direction' do
        let(:variables) { { "sort" => [{ "label" => "ASC" }] } }

        it "returns sorted question groups" do
          expect(result.dig("data", "questionGroups").map{|x| x.values}.flatten).to eq([
            question_group2.label, question_group1.label, question_group3.label
            ])
        end
      end
    end
  end
end