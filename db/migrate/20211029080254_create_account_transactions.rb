# frozen_string_literal: true

class CreateAccountTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :account_transactions do |t|
      t.string :summary
      t.datetime :performed_at
      t.string :status
      t.string :transaction_id
      t.float :amount
      t.string :direction

      t.references :account
    end

    add_reference :transactions, :account_transactions, index: true
  end
end
