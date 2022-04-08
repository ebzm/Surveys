require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe 'relations' do
    it "is associated with question groups" do
      expect(Survey.reflect_on_association(:question_groups)).not_to eq(nil)
    end
  end

  describe "validations" do
    it "ensures label is present" do
      survey = Survey.new(label: "label")
      expect(survey.valid?).to be true
    end

    it "should be able to save survey" do
      survey = Survey.new(label: "label")
      expect(survey.save).to be true
    end
  end
end