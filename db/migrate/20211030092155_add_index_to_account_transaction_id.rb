# frozen_string_literal: true

class AddIndexToAccountTransactionId < ActiveRecord::Migration[6.0]
  def change
    add_index :transactions, :account_transaction_id
  end
end
