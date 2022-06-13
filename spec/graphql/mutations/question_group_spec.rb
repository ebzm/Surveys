# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Question group queries' do
  subject(:result) { execute_query(query, variables: variables).to_h }

  describe 'create Question group' do
    let(:survey) { FactoryBot.create(:survey) }
    let(:query) { <<~GRAPHQL }
      mutation CreateQuestionGroup($input: CreateQuestionGroupInput!) { 
        createQuestionGroup(input: $input){
          questionGroup{
              label
            }
          }
        }
        GRAPHQL

    let(:variables) do
      {
        "input" => {
          "label" => "test",
          "surveyId" => "#{survey.id}",
        },
      }
    end

    it 'creates one question group' do
      expect { result }.to(change(QuestionGroup, :count).by(1))
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createQuestionGroup')).to eq({"questionGroup"=>{"label"=>"test"}})
    end
  end

  describe 'update Question group' do
    let!(:question_group) { create(:question_group, label: "test question group") }
    let(:query) { <<~GQL
      mutation UpdateQuestionGroup($input: UpdateQuestionGroupInput!) { 
        updateQuestionGroup(input: $input){
            questionGroup{
              label
            }
          }
        }
    GQL
      }

    let(:variables) do
      {
        "input" => {
          "id" => "#{question_group.id}",
          "label" => "testing",
        },
      }
    end    

    it 'updates Question group' do
      expect(result.dig('data', 'updateQuestionGroup')).to eq({"questionGroup"=>{"label"=>"testing"}})
    end
  end
end