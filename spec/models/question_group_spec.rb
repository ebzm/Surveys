require 'rails_helper'

RSpec.describe QuestionGroup, type: :model do
  describe 'relations' do
    it "is associated with questions" do
      expect(QuestionGroup.reflect_on_association(:questions)).not_to eq(nil)
    end

    it "is associated with surveys" do
      expect(QuestionGroup.reflect_on_association(:survey)).not_to eq(nil)
    end
  end

  context "validation test" do
    it "ensures label is present" do
      group = QuestionGroup.new(label: "label")
      expect(group.label == "label").to eq(true)
    end

    it "is not valid without a survey_id" do
      group = QuestionGroup.new(label: "label", survey_id: nil)
      expect(group).to_not be_valid
    end
  end
end