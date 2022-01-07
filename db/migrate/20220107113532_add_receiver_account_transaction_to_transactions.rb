# frozen_string_literal: true

class AddReceiverAccountTransactionToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :transferee_account_transaction_id, :integer
    add_foreign_key :transactions, :account_transactions, column: :transferee_account_transaction_id
    add_index :transactions, :transferee_account_transaction_id
  end
end
