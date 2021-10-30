# frozen_string_literal: true

class AddForeignKeysToTables < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :account_transactions_id

    add_column :transactions, :account_transaction_id, :bigint, null: false

    add_foreign_key :account_transactions, :accounts
    add_foreign_key :transactions, :account_transactions
  end
end
