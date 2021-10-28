class RemoveIsTransferFromTransactions < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :is_transfer
  end
end
