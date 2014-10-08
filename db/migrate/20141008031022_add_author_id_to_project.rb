class AddAuthorIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :author_id, :integer
    add_index :projects, :author_id
  end
end
