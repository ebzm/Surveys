# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Question queries' do
  subject(:result) { SurveysSchema.execute(query) }

  describe 'create Question' do
    question_group = FactoryBot.create(:question_group)
    let(:query) { <<~GQL
      mutation { 
        create_question(input:{questiontype: "test", questionGroupId: "#{question_group.id}"}){
          question{
              questiontype
            }
          }
        }
    GQL
    }

    it 'creates one question' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'create_question')).to eq({"question"=>{"questiontype"=>"test"}})
    end
  end

  describe 'update Question' do
    let!(:question) { create(:question) }
    let(:query) { <<~GQL
      mutation { 
        update_question(input:{
          id: 1
          questiontype: "testing"}){
            question{
              questiontype
            }
          }
        }
    GQL
      }

    it 'updates Question' do
      expect(question.questiontype).to eq('test question')
      expect(result.dig('data', 'update_question')).to eq({"question"=>{"questiontype"=>"testing"}})
    end
  end
end