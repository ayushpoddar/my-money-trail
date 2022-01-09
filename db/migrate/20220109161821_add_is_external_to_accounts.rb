# frozen_string_literal: true

class AddIsExternalToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :is_external, :boolean, default: true
  end
end
