class AddDestinationAccountToTransactions < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :account_id

    add_column :transactions, :source_account_id, :integer, null: false
    add_index :transactions, :source_account_id

    add_column :transactions, :destination_account_id, :integer, null: false
    add_index :transactions, :destination_account_id

    add_foreign_key :transactions, :accounts, column: :source_account_id
    add_foreign_key :transactions, :accounts, column: :destination_account_id
  end
end
