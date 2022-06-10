# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Survey queries' do
  subject(:result) { SurveysSchema.execute(query) }

  describe 'create Survey' do
    let(:query) { <<~GQL
      mutation { 
        create_survey(input:{label: "test"}){
            survey{
              label
            }
          }
        }
    GQL
    }

    it 'creates one survey' do
      data = result.dig('data')
      expect(data.count).to eq(1)
    end

    it 'returns correct data' do
      expect(result.dig('data', 'create_survey')).to eq({"survey"=>{"label"=>"test"}})
    end
  end

  describe 'update Survey' do
    let!(:survey) { create(:survey) }
    let(:query) { <<~GQL
      mutation { 
        update_survey(input:{
          id:#{survey.id}
          label: "testing"}){
            survey{
              label
            }
          }
        }
    GQL
      }

    it 'updates Survey' do
      expect(survey.label).to eq('test survey')
      expect(result.dig('data', 'update_survey')).to eq({"survey"=>{"label"=>"testing"}})
    end
  end

  describe '#delete Survey' do
    let!(:survey) { create(:survey) }
    let(:query) { <<~GQL 
      mutation { 
        delete_survey(input:{id:#{survey.id}}) {
          surveys
        }
        }
    GQL
      }

    it 'deletes survey' do
      expect{ result }.to change { Survey.count }.by(-1)
    end
  end
end