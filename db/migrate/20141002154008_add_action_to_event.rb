class AddActionToEvent < ActiveRecord::Migration
  def change
    add_column :events, :changed_attr, :string
    add_column :events, :old_value, :string
    add_column :events, :new_value, :string
    remove_column :events, :description
  end
end
