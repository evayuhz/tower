class AddProjectIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :project_id, :integer
    add_index :events, :project_id
  end
end
