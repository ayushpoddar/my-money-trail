# frozen_string_literal: true

class AddDescriptionToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :description, :string
  end
end
