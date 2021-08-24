class Accounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.float :initial_balance, default: 0.0
    end
  end
end
