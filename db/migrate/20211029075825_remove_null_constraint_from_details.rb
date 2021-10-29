class RemoveNullConstraintFromDetails < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :details
    add_column :events, :summary, :string
  end
end
