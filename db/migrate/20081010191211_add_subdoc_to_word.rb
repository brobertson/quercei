class AddSubdocToWord < ActiveRecord::Migration
  def self.up
    add_column :words, :subdoc, :string
    add_index :words, :subdoc
  end

  def self.down
    remove_column :words, :subdoc
  end
end
