class FixLists < ActiveRecord::Migration
  def up
    remove_column :todos, :list_name
    remove_column :todos, :todo_count
    add_column :todos, :list_id, :integer
    create_table :lists do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    add_column :todos, :list_name, :string
    add_column :todos, :todo_count, :integer
    remove_column :todos, :list_id
    drop_table :lists
  end
end
