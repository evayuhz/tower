class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.integer :team_id
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :projects, :team_id
    add_index :projects, :name
  end
end
