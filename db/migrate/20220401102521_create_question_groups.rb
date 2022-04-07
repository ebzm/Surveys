class CreateQuestionGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :question_groups do |t|
      t.string :label
      t.references :survey
    end
  end
end
