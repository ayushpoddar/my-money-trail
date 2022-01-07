# frozen_string_literal: true

class CreateJoinTableBetweenTransactionAndAccountTransaction < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :account_transaction_id
    remove_column :transactions, :transferee_account_transaction_id

    create_table :transaction_relations, id: false do |t|
      t.belongs_to :account_transaction
      t.belongs_to :transaction
    end
  end
end
