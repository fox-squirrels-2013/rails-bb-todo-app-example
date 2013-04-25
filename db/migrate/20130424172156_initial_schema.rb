class InitialSchema < ActiveRecord::Migration

  def change

    create_table :lists do |t|
      t.string   :name, :null => false

      t.timestamps
    end

    create_table :todos do |t|
      t.string  :title,  :null => false
      t.string  :status, :null => false

      t.timestamps

      t.references :list
      t.foreign_key :lists, dependent: :delete
    end

  end

end
