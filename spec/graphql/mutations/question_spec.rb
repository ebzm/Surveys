# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Question queries' do
  subject(:result) { execute_query(query, variables: variables).to_h }

  describe 'create Question' do
    let(:question_group) { FactoryBot.create(:question_group) }
    let(:query) { <<~GRAPHQL }
      mutation CreateQuestion($input: CreateQuestionInput!) {
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
          'questionGroupId' => make_global_id(question_group)
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
      mutation UpdateQuestion($input: UpdateQuestionInput!) {
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
          'questionId' => make_global_id(question),
          'questiontype' => 'testing'
        }
      }
    end

    it 'updates Question' do
      expect { result && question.reload }.to(change(question, :questiontype).from('test question').to('testing'))
    end
  end

  describe 'delete Question' do
    let!(:question) { create(:question) }
    let(:query) { <<~GRAPHQL }
      mutation DestroyRecord($input: DestroyRecordInput!) {
        destroyRecord(input: $input) {
          errors
        }
        }
    GRAPHQL

    let(:variables) do
      {
        'input' => {
          'recordId' => make_global_id(question)
        }
      }
    end

    it 'deletes question' do
      expect { result }.to change { Question.count }.by(-1)
    end
  end
end
