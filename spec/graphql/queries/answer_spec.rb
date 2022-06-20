# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'query answer' do
  subject(:result) { execute_query(query, variables: variables).to_h }
  let(:variables) { {} }

  describe 'one answer' do
    let(:answer1) { FactoryBot.create(:answer, answer_val: 3.0) }
    let(:answer2) { FactoryBot.create(:answer, answer_val: 5.0) }
    let(:query) { <<~GRAPHQL }
      query Answer($answerId: ID!) {
        node(id: $answerId) {
          ... on Answer {
            answerVal
          }
        }
      }
    GRAPHQL

    let(:variables) { { 'answerId' => make_global_id(answer1) } }

    it "returns first answer's answer val" do
      expect(result.dig('data', 'node', 'answerVal')).to eq(3.0)
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

    it 'returns all answers answer vals' do
      expect(result.dig('data', 'answers').map(&:values).flatten).to eq([3.0, 5.0])
    end
  end

  context 'filtering' do
    let!(:answer1) { FactoryBot.create(:answer, answer_val: 1.0) }
    let!(:answer2) { FactoryBot.create(:answer, answer_val: 3.0) }
    let!(:answer3) { FactoryBot.create(:answer, answer_val: 5.0) }
    let(:query) { <<~GRAPHQL }
      query Answer($val: Float, $min: Float, $max: Float){
        answers(val: $val, min: $min, max: $max) {
            answerVal
          }
        }#{' '}
    GRAPHQL

    describe 'by answer val' do
      let(:variables) { { 'val' => answer2.answer_val } }

      it 'returns filtered answers' do
        expect(result.dig('data', 'answers').map(&:values).flatten).to eq([answer2.answer_val])
      end
    end

    describe 'by min and max val' do
      let(:variables) { { 'min' => 2, 'max' => 4 } }

      it 'returns filtered answers' do
        expect(result.dig('data', 'answers').map(&:values).flatten).to eq([answer2.answer_val])
      end
    end

    describe 'by min val' do
      let(:variables) { { 'min' => 3 } }

      it 'returns filtered answers' do
        expect(result.dig('data', 'answers').map(&:values).flatten).to eq([answer2.answer_val, answer3.answer_val])
      end
    end

    describe 'by max val' do
      let(:variables) { { 'max' => 3 } }

      it 'returns filtered answers' do
        expect(result.dig('data', 'answers').map(&:values).flatten).to eq([answer1.answer_val, answer2.answer_val])
      end
    end

    describe 'by min, max and answer val within the interval' do
      let(:variables) { { 'min' => 2, 'max' => 3, 'val' => 3 } }

      it 'returns filtered answers' do
        expect(result.dig('data', 'answers').map(&:values).flatten).to eq([answer2.answer_val])
      end
    end

    describe 'by min, max and answer val outside the interval' do
      let(:variables) { { 'min' => 2, 'val' => 1 } }

      it 'returns filtered answers' do
        expect(result.dig('data', 'answers')).to eq([])
      end
    end
  end
end
