class CreateSubdocs < ActiveRecord::Migration
  def self.up
    create_table :subdocs do |t|
      t.string :label
      t.integer :document_id
      t.string :description

      t.timestamps
    end
      add_index :subdocs, :label
  end

  def self.down
    drop_table :subdocs
  end
end
