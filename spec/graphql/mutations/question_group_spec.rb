# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Question group queries' do
  subject(:result) { execute_query(query, viewer: viewer, variables: variables).to_h }
  let(:viewer) { create(:user) }

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
        'input' => {
          'label' => 'test',
          'surveyId' => make_global_id(survey)
        }
      }
    end

    it 'creates one question group' do
      expect { result }.to(change(QuestionGroup, :count).by(1))
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createQuestionGroup')).to eq({ 'questionGroup' => { 'label' => 'test' } })
    end
  end

  describe 'update Question group' do
    let!(:question_group) { create(:question_group, label: 'test question group') }
    let(:query) do
      <<~GQL
        mutation UpdateQuestionGroup($input: UpdateQuestionGroupInput!) {
          updateQuestionGroup(input: $input){
              questionGroup{
                label
              }
            }
          }
      GQL
    end

    let(:variables) do
      {
        'input' => {
          'questionGroupId' => make_global_id(question_group),
          'label' => 'testing'
        }
      }
    end

    it 'updates Question group' do
      expect do
        result && question_group.reload
      end.to(change(question_group, :label).from('test question group').to('testing'))
    end
  end

    it_behaves_like "destroy record", "question_group"
end
