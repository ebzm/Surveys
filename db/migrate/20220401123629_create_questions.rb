class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :questiontype
      t.integer :questiongroup_id
    end
  end
end
