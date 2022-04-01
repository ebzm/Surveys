class CreateQuestiongroups < ActiveRecord::Migration[7.0]
  def change
    create_table :questiongroups do |t|
      t.string :label
      t.integer :survey_id
    end
  end
end
