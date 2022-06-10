# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Question group queries' do
  subject(:result) { SurveysSchema.execute(query) }

  describe 'create Question group' do
    survey = FactoryBot.create(:survey)
    let(:query) { <<~GQL
      mutation { 
        create_question_group(input:{label: "test", surveyId: "#{survey.id}"}){
          question_group{
              label
            }
          }
        }
    GQL
    }

    it 'creates one question group' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'create_question_group')).to eq({"question_group"=>{"label"=>"test"}})
    end
  end

  describe 'update Question group' do
    let!(:question_group) { create(:question_group) }
    let(:query) { <<~GQL
      mutation { 
        update_question_group(input:{
          id:#{question_group.id}
          label: "testing"}){
            question_group{
              label
            }
          }
        }
    GQL
      }

    it 'updates Question group' do
      expect(question_group.label).to eq('test question group')
      expect(result.dig('data', 'update_question_group')).to eq({"question_group"=>{"label"=>"testing"}})
    end
  end
end