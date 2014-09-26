class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text :content
      t.integer :assigned_to
      t.date :end_time
      t.integer :status, default: 0
      t.integer :author_id
      t.integer :priority, default: 0
      t.integer :project_id

      t.timestamps
    end

    add_index :todos, :status
    add_index :todos, :assigned_to
    add_index :todos, :project_id
  end
end
