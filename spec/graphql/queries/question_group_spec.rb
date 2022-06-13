require "rails_helper"

RSpec.describe "query question group" do
  subject(:result) { SurveysSchema.execute(query) }

  describe 'one question group' do
    let(:question_group1) { FactoryBot.create(:question_group, label: 'test question group') }
    let(:question_group2) { FactoryBot.create(:question_group, label: 'test question group 2') }
    let(:query) { <<~GQL
      query {
        questionGroup(id:#{question_group1.id}) {
          label
        }
      }
      GQL
    }

    it "returns first question group's label" do
      expect(result.dig("data", "questionGroup", "label")).to eq("test question group")
    end
  end

  describe 'all question groups' do
    let!(:question_group1) { FactoryBot.create(:question_group, label: 'test question group') }
    let!(:question_group2) { FactoryBot.create(:question_group, label: 'test question group 2') }
    let(:query) { <<~GQL
      query {
        questionGroups {
          label
        }
      }
      GQL
    }

    it "returns all question groups labels" do
      expect(result.dig("data", "questionGroups").map{|x| x.values}.flatten).to eq(["test question group", "test question group 2"])
    end
  end
end