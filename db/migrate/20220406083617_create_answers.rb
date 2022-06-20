# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.float :answer_val, null: false
      t.references :question, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
