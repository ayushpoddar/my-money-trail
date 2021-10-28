class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :event
      t.references :account
      t.string :summary
      t.datetime :performed_at, null: false
      t.boolean :is_necessity, default: false
      t.boolean :is_confirmed, default: false
    end
  end
end
