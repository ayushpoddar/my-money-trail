class AddIsDeletedToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :is_deleted, :boolean, default: false, null: false
  end
end
