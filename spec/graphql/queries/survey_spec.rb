require "rails_helper"

RSpec.describe "query survey" do
  subject(:result) { execute_query(query, variables: variables).to_h }
  let(:variables) { {} }

  describe 'one survey' do
    let(:survey1) { FactoryBot.create(:survey, label: 'test survey') }
    let(:survey2) { FactoryBot.create(:survey, label: 'test survey 2') }
    let(:query) { <<~GRAPHQL }
      query Survey($surveyId: ID!) {
        survey(id :$surveyId) {
          label
        }
      }
      GRAPHQL

    let(:variables) { { "surveyId" => survey1.id.to_s } }

    it "returns first survey's label" do
      expect(result.dig("data", "survey", "label")).to eq("test survey")
    end
  end

  describe 'all surveys' do
    let!(:survey1) { FactoryBot.create(:survey, label: 'test survey') }
    let!(:survey2) { FactoryBot.create(:survey, label: 'test survey 2') }
    let(:query) { <<~GRAPHQL }
      query {
        surveys {
          label
        }
      }
      GRAPHQL

    it "returns all surveys labels" do
      expect(result.dig("data", "surveys").map{|x| x.values}.flatten).to eq(["test survey", "test survey 2"])
    end
  end

  context 'sorting' do
    let!(:survey1) { FactoryBot.create(:survey, label: '2 Survey') }
    let!(:survey2) { FactoryBot.create(:survey, label: '1 Survey') }
    let!(:survey3) { FactoryBot.create(:survey, label: '3 Survey') }
    let(:query) { <<~GRAPHQL }
    query Syrveys($sort: [SurveySortInput!]) {
      surveys(sort: $sort) {
          label
        }
      } 
      GRAPHQL
    
    describe 'by label' do
      context 'DESC direction' do
        let(:variables) { { "sort" => [{ "label" => "DESC" }] } }

        it "returns sorted surveys" do
          expect(result.dig("data", "surveys").map{|x| x.values}.flatten).to eq([
            survey3.label, survey1.label, survey2.label
            ])
        end
      end

      context 'ASC direction' do
        let(:variables) { { "sort" => [{ "label" => "ASC" }] } }

        it "returns sorted surveys" do
          expect(result.dig("data", "surveys").map{|x| x.values}.flatten).to eq([
            survey2.label, survey1.label, survey3.label
            ])
        end
      end
    end
  end
end
  