require "rails_helper"

RSpec.describe "query survey" do
  subject(:result) { SurveysSchema.execute(query) }

  describe 'one survey' do
    let(:survey1) { FactoryBot.create(:survey, label: 'test survey') }
    let(:survey2) { FactoryBot.create(:survey, label: 'test survey 2') }
    let(:query) { <<~GQL
      query {
        survey(id:#{survey1.id}) {
          label
        }
      }
      GQL
    }

    it "returns first survey's label" do
      expect(result.dig("data", "survey", "label")).to eq("test survey")
    end
  end

  describe 'all surveys' do
    let!(:survey1) { FactoryBot.create(:survey, label: 'test survey') }
    let!(:survey2) { FactoryBot.create(:survey, label: 'test survey 2') }
    let(:query) { <<~GQL
      query {
        surveys {
          label
        }
      }
      GQL
    }

    it "returns all surveys labels" do
      expect(result.dig("data", "surveys").map{|x| x.values}.flatten).to eq(["test survey", "test survey 2"])
    end
  end
end
  