class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :eventable_id
      t.string :eventable_type
      t.text :description
      t.integer :user_id

      t.timestamps
    end

    add_index :events, [:eventable_id, :eventable_type]
    add_index :events, :user_id
  end
end
