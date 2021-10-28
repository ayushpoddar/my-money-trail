class AddAmountToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :amount, :float, default: 0.0, null: false
  end
end
