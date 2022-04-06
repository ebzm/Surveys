class AddAccountTypeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :account_type, :integer, default: 0, null: false
    add_index :users, :account_type
  end
end
