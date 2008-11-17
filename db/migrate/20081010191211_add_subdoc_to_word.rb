class AddSubdocToWord < ActiveRecord::Migration
  def self.up
    add_column :words, :subdoc, :string
  end

  def self.down
    remove_column :words, :subdoc
  end
end
