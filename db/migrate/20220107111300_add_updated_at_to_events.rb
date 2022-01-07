# frozen_string_literal: true

class AddUpdatedAtToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :updated_at, :datetime, null: false
  end
end
