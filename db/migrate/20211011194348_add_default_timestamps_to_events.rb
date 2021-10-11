class AddDefaultTimestampsToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :created_at, :datetime, null: false
  end
end
