class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :details, null: false
      t.datetime :started_at
      t.datetime :finished_at
    end
  end
end
