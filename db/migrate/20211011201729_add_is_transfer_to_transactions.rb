class AddIsTransferToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :is_transfer, :boolean, default: false
  end
end
