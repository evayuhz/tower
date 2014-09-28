class CreateProjectMembers < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.integer :project_id
      t.integer :user_id
    end
    add_index :project_members, :project_id
    add_index :project_members, :user_id
    add_index :project_members, [:project_id, :user_id], unique: true
  end
end
