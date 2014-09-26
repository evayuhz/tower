class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :leader_id

      t.timestamps
    end

    add_index :teams, :leader_id
  end
end
