# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Question queries' do
  subject(:result) { execute_query(query, variables: variables).to_h }

  describe 'create Question' do
    let(:question_group) { FactoryBot.create(:question_group) }
    let(:query) { <<~GRAPHQL }
      mutation CreateQuestion($input: CreateQuestionInput!) {#{' '}
        createQuestion(input: $input){
          question{
              questiontype
            }
          }
        }
    GRAPHQL

    let(:variables) do
      {
        'input' => {
          'questiontype' => 'test',
          'questionGroupId' => question_group.id.to_s
        }
      }
    end

    it 'creates one question' do
      expect { result }.to(change(Question, :count).by(1))
    end

    it 'returns correct data' do
      expect(result.dig('data', 'createQuestion')).to eq({ 'question' => { 'questiontype' => 'test' } })
    end
  end

  describe 'update Question' do
    let!(:question) { create(:question, questiontype: 'test question') }
    let(:query) { <<~GRAPHQL }
      mutation UpdateQuestion($input: UpdateQuestionInput!) {#{' '}
        updateQuestion(input: $input){
            question{
              questiontype
            }
          }
        }
    GRAPHQL

    let(:variables) do
      {
        'input' => {
          'id' => question.id.to_s,
          'questiontype' => 'testing'
        }
      }
    end

    it 'updates Question' do
      expect { result && question.reload }.to(change(question, :questiontype).from('test question').to('testing'))
    end
  end
end
