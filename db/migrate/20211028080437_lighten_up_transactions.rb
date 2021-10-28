class LightenUpTransactions < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :transactions, :events

    remove_column :transactions, :is_necessity
    remove_column :transactions, :is_confirmed
    
    remove_column :transactions, :source_account_id
    remove_column :transactions, :destination_account_id

    add_column :transactions, :direction, :string
  end
end
