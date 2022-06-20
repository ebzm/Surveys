# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Survey queries' do
  subject(:result) { execute_query(query, variables: variables).to_h }

  describe 'create Survey' do
    let(:query) { <<~GRAPHQL }
      mutation CreateSurvey($input: CreateSurveyInput!) {#{' '}
        createSurvey(input: $input){
            survey{
              label
            }
          }
        }
    GRAPHQL

    let(:variables) do
      {
        'input' => {
          'label' => 'test'
        }
      }
    end

    it 'creates one survey' do
      expect { result }.to(change(Survey, :count).by(1))
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createSurvey')).to eq({ 'survey' => { 'label' => 'test' } })
    end
  end

  describe 'update Survey' do
    let!(:survey) { create(:survey, label: 'test survey') }
    let(:query) { <<~GRAPHQL }
      mutation UpdateSurvey($input: UpdateSurveyInput!) {#{' '}
        updateSurvey(input: $input){
            survey{
              label
            }
          }
        }
    GRAPHQL

    let(:variables) do
      {
        'input' => {
          'id' => survey.id.to_s,
          'label' => 'testing'
        }
      }
    end

    it 'updates Survey' do
      expect { result && survey.reload }.to(change(survey, :label).from('test survey').to('testing'))
    end
  end

  describe '#delete Survey' do
    let!(:survey) { create(:survey) }
    let(:query) { <<~GRAPHQL }
      mutation DestroySurvey($input: DestroySurveyInput!) {#{' '}
        destroySurvey(input: $input) {
          surveys
        }
        }
    GRAPHQL

    let(:variables) do
      {
        'input' => {
          'id' => survey.id.to_s
        }
      }
    end

    it 'deletes survey' do
      expect { result }.to change { Survey.count }.by(-1)
    end
  end
end
