class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.integer :team_id
      t.integer :user_id
      t.integer :role, default: 1

      t.timestamps
    end

    add_index :team_members, :team_id
    add_index :team_members, :user_id
    add_index :team_members, [:team_id, :user_id], unique: true
  end
end
